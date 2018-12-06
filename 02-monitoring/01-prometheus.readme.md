# Prometheus notes

## Prometheus server port forward:

```shell
export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitoring port-forward $POD_NAME 9090
```

## Internal DNS entry:

- prometheus-alertmanager.monitoring.svc.cluster.local
