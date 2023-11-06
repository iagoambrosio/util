# Procedimento para instalação do loki

### Criando namespace monitoring
kubectl create namespace monitoring

### Adicionando repo grafana
helm repo add grafana https://grafana.github.io/helm-charts
### atualizando os repositórios
helm repo update
### Você precisa ter o loki-values.yaml, promtail.yaml e loki.yaml na pasta para atualizarmos o promtail e o loki da forma que queremos

### instalação do loki
helm install -n monitoring --values loki-values.yaml loki grafana/loki-stack
