#!/usr/bin/env bash

set -eu

DIR=$(cd "$( dirname "$0")" && pwd)

helm install stable/grafana --tls \
  --name grafana                  \
  --namespace monitoring          \
  -f $DIR/02-grafana.values.yaml
