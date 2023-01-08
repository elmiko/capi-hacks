#!/bin/sh
# deploy ovn cni to target cluster
set -ex

if [ -n "$1" ]
then
    KUBECONFIG_FLAG="--kubeconfig $1"
else
    KUBECONFIG_FLAG=""
fi
if [ -n "$2" ]
then
    KIND_CLUSTER_FLAG="--cn $2"
else
    KIND_CLUSTER_FLAG=""
fi
KIND_NODES=$(kind get nodes --name ovn)
for n in $KIND_NODES; do
    docker exec "$n" sysctl --ignore net.ipv6.conf.all.disable_ipv6=0
    docker exec "$n" sysctl --ignore net.ipv6.conf.all.forwarding=1
done
if [ ! -d "ovn-kubernetes" ]
then
    git clone https://github.com/ovn-org/ovn-kubernetes.git
fi
pushd ovn-kubernetes/contrib/
./kind.sh $KIND_CLUSTER_FLAG $KUBECONFIG_FLAG --deploy
popd
