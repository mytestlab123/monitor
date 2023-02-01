# Kong Ingress Controller monitoring

### Using Prometheus 

* Create kind (kubernetes) cluster: `make cluster`
* Install all helm charts for Prometheus and Grafana: `make monitor`
* Installing and Configuring Kong Gateway: `make kong`
* Deploy http service to test kong ingress and http traffic: `make deployhttp`
* Final Server Configuration to access various service using port forward: `make runservices`
* Deploy demo application and generate traffic: `make sendtraffic`



### Reference:
* [Blog](https://konghq.com/blog/prometheus-grafana-kubernetes)
* [Video](https://www.youtube.com/watch?v=GJRbpQth3QY)