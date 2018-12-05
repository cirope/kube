#!/usr/bin/env bash

set -eu

NAME=${1:-tiller}
DIR=$(cd "$( dirname "$0")" && pwd)
CERTS_DIR=$DIR/certs

# Taken from: https://github.com/helm/helm/blob/master/docs/rbac.md

kubectl apply -f $DIR/03-helm-init-tiller-rbac-config.yaml
helm init --tiller-tls-verify --tiller-tls --wait \
  --service-account $NAME                         \
  --tiller-tls-cert $CERTS_DIR/$NAME.cert.pem     \
  --tiller-tls-key $CERTS_DIR/$NAME.key.pem       \
  --tiller-tls-hostname $NAME-server              \
  --tls-ca-cert $CERTS_DIR/ca.cert.pem
