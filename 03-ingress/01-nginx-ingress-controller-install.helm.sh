#!/usr/bin/env bash

set -eu

DIR=$(cd "$( dirname "$0")" && pwd)

helm install stable/nginx-ingress --tls           \
  --name ingress-nginx                            \
  --namespace ingress-nginx                       \
  -f $DIR/01-nginx-ingress-controller.values.yaml
