#!/bin/sh
# usage: start-autoscaler management.kubeconfig workload.kubeconfig
#/home/mike/cluster-autoscaler-amd64 \
/home/mike/kubernetes-autoscaler/cluster-autoscaler/cluster-autoscaler-amd64 \
	--cloud-provider=clusterapi \
	--v=5 \
	--namespace=default \
	--max-nodes-total=30 \
	--scale-down-delay-after-add=1m \
	--scale-down-delay-after-delete=1m \
	--scale-down-delay-after-failure=1m \
	--scale-down-unneeded-time=3m \
	--max-node-provision-time=2m \
	--balance-similar-node-groups \
	--expander=random \
	--kubeconfig=$2 \
	--cloud-config=$1
