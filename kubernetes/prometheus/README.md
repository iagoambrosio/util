# Prometheus Helm deployment

Instala um servidor Prometheus usando o chart `prometheus-community/prometheus`.

### Passos

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm upgrade --install -n monitoring prometheus prometheus-community/prometheus -f values_prometheus.yaml
```

### Arquivo de valores

- `values_prometheus.yaml`
