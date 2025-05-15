#!/bin/bash
sudo kubeadm reset -f
sudo iptables -F && sudo iptables -t nat -F && sudo iptables -t mangle -F && sudo iptables -X
sudo rm -rf /etc/kubernetes
sudo rm -rf /etc/cni/net.d
sudo rm -rf /var/lib/kubelet
sudo rm -rf /var/lib/etcd
sudo rm -rf $HOME/.kube
sudo systemctl restart containerd
sudo systemctl restart kubelet