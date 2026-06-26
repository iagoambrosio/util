sudo docker apt install docker 

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/kubectl

kubectl version --client

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.16.0/kind-linux-amd64

chmod +x ./kind

sudo mv ./kind /usr/local/bin/kind
