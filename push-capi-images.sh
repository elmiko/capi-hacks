#!/bin/sh
# push the capi images from the localhost registry to the kubernetes linked container registry
set -ex
docker push localhost:5000/capd-manager-amd64:dev
docker push localhost:5000/kubeadm-control-plane-controller-amd64:dev
docker push localhost:5000/kubeadm-bootstrap-controller-amd64:dev
docker push localhost:5000/cluster-api-controller-amd64:dev

