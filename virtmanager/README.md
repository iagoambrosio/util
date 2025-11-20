Aqui está um **README.md** claro, organizado e pronto para uso:

---

# 🚀 Script de Criação Automática de VM com Ubuntu Cloud-Init

Este script automatiza o processo de download da imagem cloud do Ubuntu, redimensionamento do disco, criação de uma máquina virtual via **virt-install** e acesso direto ao console via **virsh**.

## 📌 Pré-requisitos

Antes de usar o script, certifique-se de ter instalado:

* `qemu-img`
* `libvirt`
* `virt-install` (do pacote `virt-manager` ou `virt-install`)
* `wget`
* Rede *default* do libvirt ativa:

  ```bash
  virsh net-start default
  virsh net-autostart default
  ```

## 📦 Arquivos Necessários

Além do script principal, você precisa criar um arquivo **user-data** contendo configurações de cloud-init.

Exemplo mínimo:

```yaml
#cloud-config
password: password
chpasswd:
  expire: False
ssh_pwauth: true
```

## 📝 Uso

Execute o script passando o nome da VM como argumento:

```bash
./criar-vm.sh minha-vm
```

O script irá:

1. Baixar a imagem cloud do Ubuntu (Noble 24.04):

   ```
   https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
   ```
2. Redimensionar a imagem adicionando **50GB**.
3. Criar a VM utilizando VirtIO, 2 vCPUs e 2GB de RAM.
4. Aplicar as configurações de cloud-init usando o arquivo `user-data`.
5. Conectar automaticamente ao console via `virsh console`.

## 🖥️ Acessando a VM

Após a finalização, você será conectado ao console:

```bash
virsh console <nome-da-vm>
```

Para sair do console:

* Pressione: **Ctrl + ]**

## 🗑️ Remover a VM

Caso queira excluir a VM:

```bash
virsh destroy <nome-da-vm>
virsh undefine <nome-da-vm>"
rm <nome-da-vm>.img
```

## 📁 Script Completo (para referência)

```bash
#!/bin/bash

VM_NAME="$1"

if [ -z "$VM_NAME" ]; then
  echo "Uso: $0 <nome-da-vm>"
  exit 1
fi

IMG_FILE="${VM_NAME}.img"

wget -O "$IMG_FILE" https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img
qemu-img resize "$IMG_FILE" +50G

virt-install \
   --name "$VM_NAME" \
   --noautoconsole \
   --import \
   --memory 2048 --vcpus=2 \
   --osinfo generic \
   --disk bus=virtio,path="$IMG_FILE" \
   --network default \
   --cloud-init user-data=user-data

virsh console "$VM_NAME"
```

---

Se quiser, posso **melhorar o README**, **criar versão em inglês**, ou **adaptar o script** (ex.: adicionar meta-data, habilitar SSH via chave, mudar tamanho do disco, etc.).
