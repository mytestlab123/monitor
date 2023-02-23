#!/bin/bash


echo "Run prometheus"
POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=prometheus" -o jsonpath="{.items[0].metadata.name}")
# POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")
echo $POD_NAME
kubectl --namespace monitoring port-forward $POD_NAME 9090  --address 0.0.0.0 &
sleep 2

echo "Run grafana"
POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=grafana" -o jsonpath="{.items[0].metadata.name}")
# POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")
echo $POD_NAME
kubectl --namespace monitoring port-forward $POD_NAME 3000  --address 0.0.0.0 &
sleep 2

echo "Run kong"
POD_NAME=$(kubectl get pods --namespace kong -l "app.kubernetes.io/name=kong" -o jsonpath="{.items[0].metadata.name}")
echo $POD_NAME
kubectl --namespace kong port-forward $POD_NAME 8000  --address 0.0.0.0 &
sleep 2