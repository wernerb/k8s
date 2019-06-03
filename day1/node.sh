#!/bin/bash



wget https://dl.k8s.io/v1.14.0/kubernetes-server-linux-amd64.tar.gz
tar -xzvf kubernetes-server-linux-amd64.tar.gz
sudo mkdir -p /opt/bin
sudo cp kubernetes/server/bin/hyperkube /opt/bin
sudo cp kubernetes/server/bin/kubectl /opt/bin
sudo cp kubernetes/server/bin/kube-proxy /opt/bin

kubectl config set-cluster myfirstcluster --server=http://172.17.8.101:8080 --insecure-skip-tls-verify=true
kubectl config set-context local --cluster=myfirstcluster
kubectl config use-context local
sudo mkdir -p /var/lib/kubelet
sudo cp ~/.kube/config /var/lib/kubelet/kubeconfig
sudo mkdir -p /etc/kubernetes/manifests
