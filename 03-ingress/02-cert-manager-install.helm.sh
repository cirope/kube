#!/usr/bin/env bash

set -eu

DIR=$(cd "$( dirname "$0")" && pwd)

helm install stable/cert-manager --tls \
  --name cert-manager                  \
  --namespace kube-system              \
  -f $DIR/02-cert-manager.values.yaml
