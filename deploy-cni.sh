#!/bin/sh
# deploy calico cni to target cluster
set -ex

if [ -n "$1" ]
then
    kubeconfig_flag="--kubeconfig $1"
else
    kubeconfig_flag=""
fi

kubectl $kubeconfig_flag apply -f https://docs.projectcalico.org/v3.15/manifests/calico.yaml
