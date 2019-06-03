#!/bin/bash
killall hyperkube kube-proxy

sudo hyperkube kubelet --pod-manifest-path=/etc/kubernetes/manifests/ --kubeconfig=/var/lib/kubelet/kubeconfig --hostname-override=172.17.8.101 
sudo kube-proxy --master=http://172.17.8.101:8080
