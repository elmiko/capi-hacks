#!/bin/sh
set -ex

kind create cluster --config 01-kind-mgmt-config.yaml
