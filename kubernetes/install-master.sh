#!/bin/bash
#deve ser rodado como root
swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# master - firewall
ufw allow 6443/tcp
ufw allow 2379/tcp
ufw allow 2380/tcp
ufw allow 10250/tcp
ufw allow 10251/tcp
ufw allow 10252/tcp
ufw allow 10255/tcp
ufw reload

# wordkers
ufw allow 10250/tcp
ufw allow 30000:32767/tcp
ufw reload

cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-k8s.conf
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
EOF

sysctl --system

apt  update
apt -y install containerd

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
systemctl restart containerd
systemctl enable containerd
apt install gnupg gnupg2 curl software-properties-common -y
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/cgoogle.gpg
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

apt update
apt install kubelet kubeadm kubectl -y
apt-mark hold kubelet kubeadm kubectl


sudo kubeadm init --upload-certs --control-plane-endpoint=$(hostname --all-ip-addresses | cut -d ' ' -f 1 )  --cri-socket /run/containerd/containerd.sock --pod-network-cidr=10.32.0.0/16