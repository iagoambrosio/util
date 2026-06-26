# Grafana Helm deployment

Instala o Grafana usando o chart `grafana/grafana`.

### Passos

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm upgrade --install -n monitoring grafana grafana/grafana -f values_grafana.yaml
```

### Datasources internos

Este `values_grafana.yaml` configura os datasources para uso dentro do cluster Kubernetes no namespace `monitoring`:

- Prometheus: `http://prometheus-server`
- Loki: `http://loki:3100`
- Tempo: `http://tempo:3200`
- Pyroscope: `http://pyroscope:4040`

### Arquivo de valores

- `values_grafana.yaml`
