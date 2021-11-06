#!/bin/sh
# usage: start-autoscaler management.kubeconfig workload.kubeconfig
cluster-autoscaler \
	--cloud-provider=clusterapi \
	--v=4 \
	--namespace=default \
	--max-nodes-total=30 \
	--scale-down-delay-after-add=10s \
	--scale-down-delay-after-delete=10s \
	--scale-down-delay-after-failure=10s \
	--scale-down-unneeded-time=23s \
	--max-node-provision-time=2m \
	--balance-similar-node-groups \
	--expander=random \
	--kubeconfig=$2 \
	--cloud-config=$1
