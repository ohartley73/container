#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#source sourcefile
PATH=$PATH:/usr/local/share/google/google-cloud-sdk/bin/
echo "DETENIENDO DEPLOYMENT"
kubectl delete deployment -l "name in (twitter-stream, bigquery-controller)"
kubernetes/cluster/kube-down.sh

exit
