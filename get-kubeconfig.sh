#!/bin/sh
# write out the kubeconfig for the named kind cluster
# usage: get-kubeconfig <kind cluster name>
outfile="kubeconfig.$1"
kind get kubeconfig --name $1 > $outfile
sed -i -e "s/0.0.0.0/127.0.0.1/g" $outfile
