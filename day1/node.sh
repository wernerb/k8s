#!/bin/bash



wget https://dl.k8s.io/v1.13.3/kubernetes-server-linux-amd64.tar.gz
tar -xzvf kubernetes-server-linux-amd64.tar.gz
sudo cp kubernetes/server/bin/hyperkube /usr/local/bin
sudo cp kubernetes/server/bin/kubectl /usr/local/bin
sudo cp kubernetes/server/bin/kube-proxy /usr/local/bin

kubectl config set-cluster myfirstcluster --server=http://master:8080 --insecure-skip-tls-verify=true
kubectl config set-context local --cluster=myfirstcluster
kubectl config use-context local
sudo mkdir -p /var/lib/kubelet
sudo cp ~/.kube/config /var/lib/kubelet/kubeconfig
sudo mkdir -p /etc/kubernetes/manifests
