#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#source sourcefile

echo "Iremos ejecutando comando por comando para"
echo "crear una cosa bakan"
echo "Despues de cada comando el script parara y esperara un Enter para continuar"
echo "A ver probemos, voy a parar el script ahora"

read -p "Presione Enter para Continuar"

echo "Brillante! Eres una persona muy capaz de hacer este demo de BIG DATA!"

echo "Ahora ejecutaremos un comando para setear algunas variables de entorno"

echo "PATH=$PATH:/usr/local/share/google/google-cloud-sdk/bin/"
read -p "Presione Enter para Continuar"
PATH=$PATH:/usr/local/share/google/google-cloud-sdk/bin/
clear

echo "Ingresar el Nombre del Proyecto GCP:"
read PROYECTO_ID
read -p "Presione Enter para Continuar"
clear

echo "CREANDO MAQUINA VIRTUAL"
gcloud config set project $PROYECTO_ID
# gcloud compute instances create instance-name --scopes storage-rw,bigquery,compute-rw --image container-vm --zone europe-west1$
echo "TERMINO LA CREACION DE LA MAQUINA VIRTUAL"
read -p "Presione Enter para Continuar"
clear

echo "ACTUALIZANDO COMPONENTES DE GCLOUD"
echo "gcloud components update"
gcloud components update
echo "gcloud components install kubectl alpha beta"
gcloud components install kubectl alpha beta
echo $PATH
read -p "Presione Enter para Continuar"
clear

echo "CLONANDO EL REPOSITORIO"
echo "git clone https://github.com/GoogleCloudPlatform/kubernetes-bigquery-python.git kube-pubsub-bq"
git clone https://github.com/GoogleCloudPlatform/kubernetes-bigquery-python.git kube-pubsub-bq
read -p "Presione Enter para Continuar"
clear


echo "BAJANDO KUBERNETES"
echo "wget https://github.com/kubernetes/kubernetes/releases/download/v1.5.7/kubernetes.tar.gz"
wget https://github.com/kubernetes/kubernetes/releases/download/v1.5.7/kubernetes.tar.gz
echo "tar -zxvf kubernetes.tar.gz"
tar -zxvf kubernetes.tar.gz
read -p "Presione Enter para Continuar"
clear


echo "CREANDO DATASET Y TABLA DE BIGQUERY"
echo "bq mk rtda"
bq mk rtda
echo "bq mk -t rtda.tweets kube-pubsub-bq/bigquery-setup/schema.json"
bq mk -t rtda.tweets kube-pubsub-bq/bigquery-setup/schema.json
read -p "Presione Enter para Continuar"
clear


echo "REEMPLAZANDO DATOS DE CONFIGURACION"
echo "sed -i '25s/xxxx/'"$PROYECTO_ID"'/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml"
sed -i '25s/xxxx/'"$PROYECTO_ID"'/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml
echo "sed -i '28s/xxxx/rtda/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml"
sed -i '28s/xxxx/rtda/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml
echo "sed -i '30s/xxxx/tweets/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml"
sed -i '30s/xxxx/tweets/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml
read -p "Presione Enter para Continuar"
clear


echo "REEMPLAZANDO DATOS DE KUBERNETE"
echo "sed -i 's/storage-ro/storage-ro\,bigquery\,https\:\/\/www\.googleapis\.com\/auth\/pubsub/g' kubernetes/cluster/gce/config-common.sh"
sed -i 's/storage-ro/storage-ro\,bigquery\,https\:\/\/www\.googleapis\.com\/auth\/pubsub/g' kubernetes/cluster/gce/config-common.sh
read -p "Presione Enter para Continuar"
clear

echo "INICIALIZANDO KUBERNETE"
echo "Esto se va a demorar"
read -p "Presione Enter para Continuar"
echo "kubernetes/cluster/kube-up.sh"
kubernetes/cluster/kube-up.sh
read -p "Presione Enter para Continuar"
clear


echo "CONFIGURANDO TWITTER YAML"
sed -i '26s/xxxx/E4eJpgklAZmCTQioPFhILraCu/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
sed -i '28s/xxxx/KDDr7ivpJMB6YeTBDOtMoXASdLGUz4HgcqpcGZVEsFI2enspRR/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
sed -i '30s/xxxx/847877952322850819\-n3bMdBTeiGsUu3VysHrw5847CwYZIM2/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
sed -i '32s/xxxx/qpudOcNBJG28s6eL7JpyPks9M5bmDO58aVWKINSYJxer8/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
read -p "Presione Enter para Continuar"
clear

echo "REEMPLAZANDO PUBSUB TOPIC"
sed -i '22s/projects\/your-project\/topics\/your-topic/projects\/PROYECTO_ID\/topics\/new_tweets/g' kube-pubsub-bq/pubsub/twitter-stream.yaml
sed -i '22s/projects\/your-project\/topics\/your-topic/projects\/PROYECTO_ID\/topics\/new_tweets/g' kube-pubsub-bq/pubsub/bigquery-controller.yaml
read -p "Presione Enter para Continuar"
clear


echo "INICIANDO LOS CONTENEDORES"
kubectl create -f kube-pubsub-bq/pubsub/bigquery-controller.yaml
kubectl create -f kube-pubsub-bq/pubsub/twitter-stream.yaml
read -p "Presione Enter para Continuar"
clear

echo "DEPLOYMENT TERMINADO - Este ha sido un script de Miguel Acevedo para solucionesorion, con un aporte de Oliver Hartley "

exit
