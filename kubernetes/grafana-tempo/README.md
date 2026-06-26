# Grafana Tempo Helm deployment

Instala uma instância Tempo usando o chart `grafana/tempo`.

### Passos

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm upgrade --install -n monitoring tempo grafana/tempo -f values_tempo.yaml
```

### Arquivo de valores

- `values_tempo.yaml`
