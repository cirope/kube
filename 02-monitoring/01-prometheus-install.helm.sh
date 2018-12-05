#!/usr/bin/env bash

helm install stable/prometheus --tls --name prometheus --namespace monitoring

# Get the Prometheus server URL by running these commands in the same shell:
#   export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
#   kubectl --namespace monitoring port-forward $POD_NAME 9090
