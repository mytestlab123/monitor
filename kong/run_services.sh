#!/bin/bash


echo "Run prometheus"
POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=prometheus" -o jsonpath="{.items[0].metadata.name}")
# POD_NAME=$(kubectl get pods --namespace monitoring -l "app=prometheus,component=server" -o jsonpath="{.items[0].metadata.name}")

kubectl --namespace monitoring port-forward $POD_NAME 9090 &

echo "Run grafana"
POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/name=grafana" -o jsonpath="{.items[0].metadata.name}")
# POD_NAME=$(kubectl get pods --namespace monitoring -l "app.kubernetes.io/instance=grafana" -o jsonpath="{.items[0].metadata.name}")

kubectl --namespace monitoring port-forward $POD_NAME 3000 &

echo "Run kong"
POD_NAME=$(kubectl get pods --namespace kong -l "app.kubernetes.io/name=kong" -o jsonpath="{.items[0].metadata.name}")

kubectl --namespace kong port-forward $POD_NAME 8000 &