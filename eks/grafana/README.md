# Source: https://www.eksworkshop.com/intermediate/240_monitoring/deploy-grafana/


# helm install grafana grafana/grafana \
#     --namespace grafana \
#     --set persistence.storageClassName="gp2" \
#     --set persistence.enabled=true \
#     --set adminPassword='EKS!sAWSome' \
#     --values grafana.yaml \
#     --set service.type=LoadBalancer 


https://docs.konghq.com/kubernetes-ingress-controller/2.8.x/guides/prometheus-grafana/
https://github.com/Kong/charts/blob/main/charts/kong/README.md
https://konghq.com/blog/prometheus-grafana-kubernetes
video: https://www.youtube.com/watch?v=GJRbpQth3QY
