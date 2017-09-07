#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#source sourcefile
PATH=$PATH:/usr/local/share/google/google-cloud-sdk/bin/
echo "CREANDO MAQUINA VIRTUAL"
gcloud config set project PROYECTO_ID
gcloud compute instances create instance-name --scopes storage-rw,bigquery,compute-rw --image container-vm --zone europe-west1-b --machine-type f1-micro
echo "TERMINO LA CREACION DE LA MAQUINA VIRTUAL"

echo "ACTUALIZANDO COMPONENTES DE GCLOUD"
gcloud components update
gcloud components install kubectl alpha beta
echo $PATH

echo "CLONANDO EL REPOSITORIO"
git clone https://github.com/GoogleCloudPlatform/kubernetes-bigquery-python.git kube-pubsub-bq

echo "BAJANDO KUBERNETES"
wget https://github.com/kubernetes/kubernetes/releases/download/v1.5.7/kubernetes.tar.gz
tar -zxvf kubernetes.tar.gz

echo "CREANDO DATASET Y TABLA DE BIGQUERY"
bq mk rtda
bq mk -t rtda.tweets kube-pubsub-bq/bigquery-setup/schema.json

echo "REEMPLAZANDO DATOS DE CONFIGURACION"
sed -i '25s/xxxx/PROYECTO_ID/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml
sed -i '28s/xxxx/rtda/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml
sed -i '30s/xxxx/tweets/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml

echo "REEMPLAZANDO DATOS DE KUBERNETE"
sed -i 's/storage-ro/storage-ro\,bigquery\,https\:\/\/www\.googleapis\.com\/auth\/pubsub/g' kubernetes/cluster/gce/config-common.sh

echo "INICIALIZANDO KUBERNETE"
kubernetes/cluster/kube-up.sh

echo "CONFIGURANDO TWITTER YAML"
sed -i '26s/xxxx/E4eJpgklAZmCTQioPFhILraCu/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
sed -i '28s/xxxx/KDDr7ivpJMB6YeTBDOtMoXASdLGUz4HgcqpcGZVEsFI2enspRR/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
sed -i '30s/xxxx/847877952322850819\-n3bMdBTeiGsUu3VysHrw5847CwYZIM2/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
sed -i '32s/xxxx/qpudOcNBJG28s6eL7JpyPks9M5bmDO58aVWKINSYJxer8/g' kube-pubsub-bq/pubsub/twitter-stream.yaml

echo "REEMPLAZANDO PUBSUB TOPIC"
sed -i '22s/projects\/your-project\/topics\/your-topic/projects\/PROYECTO_ID\/topics\/new_tweets/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
sed -i '22s/projects\/your-project\/topics\/your-topic/projects\/PROYECTO_ID\/topics\/new_tweets/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml

echo "INICIANDO LOS CONTENEDORES"
kubectl create -f kube-pubsub-bq/pubsub/bigquery-controller.yaml
kubectl create -f kube-pubsub-bq/pubsub/twitter-stream.yaml

echo "DEPLOYMENT TERMINADO - Este ha sido un script de macevedo para solucionesorion"

exit
