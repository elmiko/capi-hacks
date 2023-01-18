# capi-hacks

some scripts i use when testing cluster-api, these are scripts that i run on
the host i prepare with
[elmiko/cluster-api-kubemark-ansible](https://github.com/elmiko/cluster-api-kubemark-ansible).

this repo contains scripts to:
* setup a docker registry for kind
* start a cluster api management cluster with docker and kubemark providers
* get kubeconfig files for kind clusters
* deploy cni (Calico or OVN) to cluster api workload clusters
* start a local cluster autoscaler

and kubernetes manifests for creating various cluster api kubemark clusters.

Tested with:
* Ubuntu Server 22.04
* Kubernetes 1.23.6
* cluster-api 1.3.0
* cluster-api-provider-kubemark v0.5.0

Some additional usefull resources:
* [Demo at DevConf.cz 2022](https://vimeo.com/671479117): Testing at Scale with Cluster API and Kubemark
* Notes on [Setting Up a Development Environment for the Cluster API Kubemark Provider](https://notes.elmiko.dev/2021/10/11/setup-dev-capi-kubemark.html)
* [Blog post](https://josecastillolema.github.io/kubemark/) describing the step by step use of this repo
