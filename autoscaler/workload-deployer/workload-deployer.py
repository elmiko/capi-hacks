#!/bin/env python3
import argparse
import subprocess
import tempfile
import time

workload_tmpl = '''---
apiVersion: apps/v1
kind: Deployment
metadata:
  generateName: scale-up-{nodeselector}-
  labels:
    app: scale-up
spec:
  replicas: {replicas}
  selector:
    matchLabels:
      app: scale-up
  template:
    metadata:
      labels:
        app: scale-up
    spec:
      nodeSelector:
        node.cluster.x-k8s.io: {nodeselector}
      containers:
        - name: busybox
          image: quay.io/elmiko/busybox
          resources:
            requests:
              memory: 1G
              cpu: 1
          command:
            - /bin/sh
            - "-c"
            - "echo 'this should be in the logs' && sleep 86400"
      terminationGracePeriodSeconds: 0
'''

class WorkloadApplier:
    _command_tmpl = 'kubectl --kubeconfig {kubeconfig} {command}'

    def __init__(self, kubeconfig):
        self.kubeconfig = kubeconfig
        self._tmpl_files = {}

    def get_all_pods(self):
        cmd = self._command_tmpl.format(kubeconfig=self.kubeconfig, command='get pods -A')
        p = subprocess.run(cmd.split(' '), capture_output=True)
        if p.returncode != 0:
            # print(f'command "{cmd}" failed')
            print(p.stderr.decode('utf8'))
        else:
            print(p.stdout.decode('utf8'))

    def create_workload(self, nodeselector, replicas):
        name = f'{nodeselector}-{replicas}'
        if not self._tmpl_files.get(name):
            manifest = tempfile.NamedTemporaryFile(mode='w', encoding='utf8', delete=False)
            manifest.write(workload_tmpl.format(replicas=replicas, nodeselector=nodeselector))
            manifest.close()
            self._tmpl_files[name] = manifest.name

        cmd = self._command_tmpl.format(kubeconfig=self.kubeconfig, command=f'create -f {self._tmpl_files[name]}')
        print(f'executing "{cmd}"')
        p = subprocess.run(cmd.split(' '), capture_output=True)
        if p.returncode != 0:
            print(f'command "{cmd}" failed')
        else:
            print(p.stdout.decode('utf8'))




def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--kubeconfig', required=True)
    parser.add_argument('--runonce', action='store_true')
    parser.add_argument('--delay', default=20)
    args = parser.parse_args()

    wa = WorkloadApplier(args.kubeconfig)
    done = False
    while not done:
        wa.create_workload('large', 5)
        wa.create_workload('medium', 3)
        wa.create_workload('small', 1)
        if args.runonce:
            return
        print(f'sleeping for {args.delay}s')
        time.sleep(int(args.delay))


if __name__ == '__main__':
    main()
