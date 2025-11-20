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

