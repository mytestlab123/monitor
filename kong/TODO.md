#TODO: List of tasks

* [minikube or kind guide](https://github.com/Kong/kubernetes-ingress-controller)
* [ServiceMonitor](https://www.acagroup.be/en/blog/auto-discovery-of-kubernetes-endpoint-services-prometheus/)
* [kong & eks](https://kong.awsworkshop.io/eks-enterprise-setup/observability/data_plane_monitoring.html)
* [Add Anonymous authentication](https://grafana.com/docs/grafana/latest/setup-grafana/configure-security/configure-authentication/#anonymous-authentication)
* [Auth for grafana]

```
kubectl get cm promstack-grafana -ojson | jq .data

[auth]
login_maximum_inactive_lifetime_duration = 2M
login_maximum_lifetime_duration = 2M
token_rotation_interval_minutes = 1000
```
