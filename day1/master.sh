#!/bin/sh

docker run -d --net=host k8s.gcr.io/etcd:3.3.10-0  /usr/local/bin/etcd

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


sudo mkdir -p /srv/kubernetes
openssl genrsa -out ca.key 2048
openssl req -x509 -new -nodes -key ca.key -subj "/CN=master" -days 10000 -out ca.crt
openssl genrsa -out server.key 2048
sudo cp server.key /srv/kubernetes/server.key
openssl req -new -key server.key -out server.csr -config csr.conf
openssl x509 -req -in server.csr -CA ca.crt -CAkey ca.key -CAcreateserial -out server.crt -days 10000 -extensions v3_ext -extfile csr.conf

sudo cp ca.crt /srv/kubernetes/
sudo cp server.crt /srv/kubernetes/

sudo mkdir -p /etc/kubernetes/manifests
sudo cp manifests/* /etc/kubernetes/manifests

echo Kubelet run command
echo sudo hyperkube kubelet --pod-manifest-path=/etc/kubernetes/manifests/ --kubeconfig=/var/lib/kubelet/kubeconfig --hostname-override=master --allow-privileged  --network-plugin=cni --cluster-dns=10.0.0.86 
echo Kube proxy run command
echo sudo kube-proxy --master=http://172.17.8.101:8080

