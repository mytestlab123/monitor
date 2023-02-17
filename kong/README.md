# Kong Ingress Controller monitoring

### Using Prometheus 

* Create kind (kubernetes) cluster: `make cluster`
* Install all helm charts for Prometheus and Grafana: `make monitor`
* Installing and Configuring Kong Gateway: `make kong`
* Deploy http service to test kong ingress and http traffic: `make deployhttp`
* Final Server Configuration to access various service using port forward: `make runservices`
* Deploy demo application and generate traffic: `make sendtraffic`


* Prometheus plugin config - [guide](https://docs.konghq.com/hub/kong-inc/prometheus/)
```json
{
  "consumer": null,
  "protocols": [
    "grpc",
    "grpcs",
    "http",
    "https"
  ],
  "created_at": 1675142465,
  "id": "b4e2c366-2a3b-45b7-8361-ff45f68999c2",
  "enabled": true,
  "service": null,
  "name": "prometheus",
  "tags": null,
  "config": {
    "latency_metrics": true,
    "upstream_health_metrics": true,
    "per_consumer": false,
    "status_code_metrics": true,
    "bandwidth_metrics": true
  },
  "route": null
}
```

### Reference:
* [Latest Guide - Integrate the Kubernetes Ingress Controller with Prometheus/Grafana](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/prometheus-grafana/)
* [Old Blog - September 21, 2021](https://konghq.com/blog/prometheus-grafana-kubernetes)
* [Very old Blog - February 14, 2019](https://konghq.com/blog/observability-kubernetes-kong)
* [Video](https://www.youtube.com/watch?v=GJRbpQth3QY)
* [KONG ON AWS WORKSHOP](https://kong.awsworkshop.io/)
* [Kong + minikube](https://gist.github.com/subnetmarco/acf30a6e87c467082e0f3870d88bc972)
* [Using Kong ingress controller for K3s](https://speakerdeck.com/xibuka/using-kong-ingress-controller-for-k3s)

