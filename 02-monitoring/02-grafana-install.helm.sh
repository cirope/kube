#!/usr/bin/env bash

helm install stable/grafana --tls --name grafana --namespace monitoring

# 'admin' user password:
#    kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
# Internal DNS entry:
#    grafana.monitoring.svc.cluster.local
# Grafana forward:
#   export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana" -o jsonpath="{.items[0].metadata.name}")
#   kubectl --namespace monitoring port-forward $POD_NAME 3000
