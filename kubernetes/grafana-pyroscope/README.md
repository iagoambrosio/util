# Pyroscope Helm deployment

Instala uma instância Pyroscope usando o chart `pyroscope-io/pyroscope`.

### Passos

```bash

helm repo update
kubectl create namespace monitoring
helm upgrade --install -n monitoring pyroscope grafana/pyroscope -f values_pyroscope.yaml
```

### Arquivo de valores

- `values_pyroscope.yaml`
