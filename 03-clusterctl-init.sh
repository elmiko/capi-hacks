#!/bin/sh
set -ex
if [ -z "$1" ];then
    kubeconfig_flag=""
else
    kubeconfig_flag="--kubeconfig $1"
fi

capi_version="v1.2.99"
capk_version="v0.3.99"

clusterctl init \
    --core cluster-api:$capi_version \
    --bootstrap kubeadm:$capi_version \
    --control-plane kubeadm:$capi_version \
    --infrastructure kubemark:$capk_version,docker:$capi_version \
    --config ~/.cluster-api/dev-repository/config.yaml $kubeconfig_flag

