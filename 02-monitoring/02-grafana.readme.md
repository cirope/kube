# Grafana notes

## Get 'admin' user password:

```shell
kubectl get secret --namespace monitoring grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

## Grafana port forward:

```shell
export POD_NAME=$(kubectl get pods --namespace monitoring -l "app=grafana" -o jsonpath="{.items[0].metadata.name}")
kubectl --namespace monitoring port-forward $POD_NAME 3000
```
## Internal DNS entry:

- grafana.monitoring.svc.cluster.local
