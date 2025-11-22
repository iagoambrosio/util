#!/bin/bash

MASTER_NAME="k3s-master"
AGENT_PREFIX="k3s-agent"
NUM_AGENTS="$1"

if [ -z "$NUM_AGENTS" ]; then
  echo "Uso: $0 <numero-de-agents>"
  exit 1
fi

IMG_BASE="ubuntu-base.img"

# Verifica se a imagem já existe
if [ -f "$IMG_BASE" ]; then
  echo "Imagem base já existe: $IMG_BASE"
else
  echo "Baixando imagem base Ubuntu..."
  wget -O "$IMG_BASE" https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
fi

# Cria master
MASTER_IMG="${MASTER_NAME}.img"
cp "$IMG_BASE" "$MASTER_IMG"
qemu-img resize "$MASTER_IMG" +10G

cat > user-data-master.yaml <<EOF
#cloud-config
password: ubuntu
chpasswd:
  expire: False
ssh_pwauth: True
packages:
  - curl
runcmd:
  - curl -sfL https://get.k3s.io | sh -
EOF

virt-install \
   --name "$MASTER_NAME" \
   --noautoconsole \
   --import \
   --memory 4048 --vcpus=4 \
   --osinfo ubuntu22.04 \
   --disk bus=virtio,path="$MASTER_IMG" \
   --network default \
   --cloud-init user-data=user-data-master.yaml

echo "Aguardando master iniciar e gerar token..."

# Loop para tentar extrair o token até conseguir
TOKEN=""
while [ -z "$TOKEN" ]; do
  sleep 3
  TOKEN=$(sudo guestfish --ro -a "$MASTER_IMG" -i cat /var/lib/rancher/k3s/server/node-token 2>/dev/null)
  if [ -z "$TOKEN" ]; then
    echo "Ainda não consegui pegar o token, tentando novamente..."
  fi
done

# Pega IP do master
MASTER_IP=$(virsh domifaddr "$MASTER_NAME" | awk '/ipv4/ {print $4}' | cut -d/ -f1)

echo "Token do master: $TOKEN"
echo "IP do master: $MASTER_IP"

# Cria agents
for i in $(seq 1 "$NUM_AGENTS"); do
  AGENT_NAME="${AGENT_PREFIX}-${i}"
  AGENT_IMG="${AGENT_NAME}.img"
  cp "$IMG_BASE" "$AGENT_IMG"
  qemu-img resize "$AGENT_IMG" +10G

  cat > user-data-agent.yaml <<EOF
#cloud-config
password: ubuntu
chpasswd:
  expire: False
ssh_pwauth: True
packages:
  - curl
runcmd:
  - curl -sfL https://get.k3s.io | K3S_URL=https://${MASTER_IP}:6443 K3S_TOKEN=${TOKEN} sh -
EOF

  virt-install \
     --name "$AGENT_NAME" \
     --noautoconsole \
     --import \
     --memory 1024 --vcpus=2 \
     --osinfo ubuntu22.04 \
     --disk bus=virtio,path="$AGENT_IMG" \
     --network default \
     --cloud-init user-data=user-data-agent.yaml
done

echo "Cluster K3s iniciado com 1 master e $NUM_AGENTS agents."
