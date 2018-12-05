#!/usr/bin/env bash

set -eu

DIR=$(cd "$( dirname "$0")" && pwd)

kubectl apply -f $DIR/03-cert-manager.clusterissuer.yaml
