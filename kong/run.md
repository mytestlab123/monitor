# Run the server

```
POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")


kubectl --namespace monitoring port-forward $POD_NAME 9090 &


POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")


kubectl --namespace monitoring port-forward $POD_NAME 3000 &


POD_NAME=$(kubectl get pods --namespace kong -l "app.kubernetes.io/name=kong" -o jsonpath="{.items[0].metadata.name}")


kubectl --namespace kong port-forward $POD_NAME 8000 &
```
