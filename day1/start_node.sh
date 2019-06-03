#!/bin/bash

IP=$(ip addr show eth1 | grep "inet\b" | awk '{print $2}' | cut -d/ -f1)
sudo hyperkube kubelet --pod-manifest-path=/etc/kubernetes/manifests/ --kubeconfig=/var/lib/kubelet/kubeconfig --hostname-override=$IP &
sudo kube-proxy --master=http://172.17.8.101:8080 --hostname-override=$IP --masquerade-all 
