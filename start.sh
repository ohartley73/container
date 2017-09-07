#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#source sourcefile
PATH=$PATH:/usr/local/share/google/google-cloud-sdk/bin/
echo "INICIANDO DEPLOYMENT"
kubernetes/cluster/kube-up.sh
kubectl create -f kube-pubsub-bq/pubsub/bigquery-controller.yaml
kubectl create -f kube-pubsub-bq/pubsub/twitter-stream.yaml

exit
