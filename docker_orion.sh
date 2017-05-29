#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#source sourcefile

clear
echo "Este script tiene como fin automatizar la implementacion de un ambiente"
echo "Docker, con el fin de mostrar lo rapido y sencillo que es la tecnologia de Container"
echo "En vez de solicitar que uds hagan copy paste, este script hace la pega por uds. La idea principal"
echo "es que se entienda lo que esta haciendo."
echo "De todas maneras ustedes tendran una presentacion con los mismos comandos para que despues puedan hacer lo mismo en sus oficinas"
echo "lo que haremos es:"
echo "1. Actualizar Ubuntu."
echo "2. Instalar Docker"
echo "3. Crear un container con MariaDB"
echo "4. Crear un contauner con Wordpress"
echo "5. Instalar el servidor web NGINX, pero no en container, sino que localmente"
echo "6. Ingresar a nuestro wordpress Containerizado"
echo ""
read -p "Precione enter para continuar"
clear

echo "Ahora vamos a hacer un update Ubuntu para tener todas las librerias al dia"
echo "apt-get update && apt-get upgrade -y"
read -p "Precione enter para continuar"
apt-get update && apt-get upgrade -y
clear

echo "El servidor ya esta updateado!"
echo "Ahora instalaremos Docker."
echo "Docker es lo que permite que los containers funcionen"
echo "El comando es:"
echo "apt-get install -y docker.io"
echo ""
read -p "Precione enter para continuar"
apt-get install -y docker.io
clear

echo "Listo instalamos Docker, ahora vamos a verificar que el servicio Docker este Funcionando:"
echo "Para eso usaremos los siguientes comandos"
echo "systemctl start docker"
echo "systemctl enable docker"
echo ""
read -p "Precione enter para continuar"
systemctl start docker
systemctl enable docker
echo ""
echo "Listo ahora verificaremos que Docker esta corriendo preguntando al systema por la version de 
docker"
echo "con el comando:"
echo "docker version"
echo ""
read -p "Precione enter para continuar"
docker version
echo ""
read -p "Precione enter para continuar"
clear

echo "Ahora vamos a correr nuestro primer container"
echo "Este container es una aplicacion muy sencilla que lo unico que hace es escribir 'Hello World' en pantalla, ademas de un texto explicativo."
echo "El comando para correr un Container es docker run [nombre del container]"
echo "En ese caso"
echo "docker run hello-world"
read -p "Precione enter para continuar"
clear
docker run hello-world
read -p "Precione enter para continuar"
clear

echo "Ahora instalaremos MariaDB en un container"
echo "Para lo cual primero traeremos a este servidor la imagen de un container de MariaDB, con el comando"
echo "docker pull mariadb"
read -p "Precione enter para continuar"
docker pull mariadb
echo ""
read -p "Precione enter para continuar"
clear

echo "Veamos con el comando docker images, las imagenes de containers que tenemos localmente"
echo "docker images"
read -p "Precione enter para continuar"
docker images
echo ""
read -p "Precione enter para continuar"
clear

echo "Ahora que ya tenenmos la imagen de MariaDB, deberiamos ejecutar el container, sin embargo antes vamos a crear los directorios que van a alojar nuestro wordpress"
echo "mkdir ~/wordpress"
echo "mkdir -p ~/wordpress/database"
echo "mkdir -p ~/wordpress/html"
read -p "Precione enter para continuar"
mkdir ~/wordpress
mkdir -p ~/wordpress/database
mkdir -p ~/wordpress/html
clear

echo "Ahora vamos a correr el container de MariaDB. Si bien el comando se ve complejo es bien facil de entender. El comando parte con docker run -e, luego saltense todo y vayan a la ultima palabra, la cual es mariadb."
echo "O sea estamos diciendo docker hecha a correr el container de mariadb, lo que esta entremedio son una serie de comandos a ejecutarse dentro de mariadb, para:"
echo "1. crear la password de Root"
echo "2. crear un usuario nuevo y que este se llame wpuser"
echo "3. Asignar a ese nuevo usuario la password: wpuser@"
echo "4. Crear una base de datos nueva que se llame wordpressdb en un directorio especifico."
echo "el comando para hacer todo eso es:"
echo "docker run -e MYSQL_ROOT_PASSWORD=aqwe123 -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wpuser@ -e MYSQL_DATABASE=wordpress_db -v /root/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb"
echo ""
read -p "Precione enter para continuar"
docker run -e MYSQL_ROOT_PASSWORD=aqwe123 -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wpuser@ -e MYSQL_DATABASE=wordpress_db -v /root/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb
echo ""
read -p "Precione enter para continuar"
clear

echo "Ahora usaremos el comando docker ps, para ver los containers que se estan ejecutando en la maquina"
echo "docker ps"
echo ""
read -p "Precione enter para continuar"
docker ps
echo ""
read -p "Precione enter para continuar"
clear

echo "ahora comprobemos que la base de dato este ahi y metamonos en ella"
echo "Para ellos primero debemos saber en que IP esta corriendo la base de datos, eso lo obtenemos con el siguiente comando"
echo "docker inspect -f '{{ .NetworkSettings.IPAddress }}' wordpressdb"
echo ""
read -p "Precione enter para continuar"
docker inspect -f '{{ .NetworkSettings.IPAddress }}' wordpressdb
echo ""
read -p "Precione enter para continuar"
echo "vamos a guardar esa ip"
echo "puedes tipear la ip denuevo ahora?:"
read IP
echo ""
echo "Gracias!"
read -p "Precione enter para continuar"
clear

#echo "Para conectarnos a mariadb, necesitamos el cliente de mariadb para poder conectarnos, para ello ejecutaremos el siguiente comando"
#echo "apt-get install -y mariadb-client-core-10.0"
#apt-get install -y mariadb-client-core-10.0
#echo ""
#read -p "Precione enter para continuar"
#clear

#mysql -u wpuser -h 172.17.0.2 -p 
#Show databases;
#exit

#echo "Funcionando"

echo "Ahora instalaremos el container de Wordpress!"
echo "El container de mariadb, lo que hicimos fue bajarlo y luego ejecutarlo"
echo "En el caso de wordpress haremos algo distinto. Simplemete le diremos que ejecute el container"
echo "Docker siempre primero verificara si tiene el container en local, si no lo tiene lo baja. Por ende,"
echo "el comando pull que dicimos con mariadb no es estrictamete necesario."
echo "Denuevo, la manera de leer el comando es docker run -e, luedo salta al la ultima palabra del comando, y te daras cuenta que vamos por el buen camino"
echo "entremedio le estamos diciendo a wordpress los siguiete:"
echo "1. el usuario de la base de datos es wpuser"
echo "2. la contraseña para la base de datos es wpuser@"
echo "3. la base de datos se llama wordpress_db, y luego le entrega parametros de donde esta la base de datos"
echo ""
echo "el comando es:"
echo "docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wpuser@ -e WORDPRESS_DB_NAME=wordpress_db -p 8081:80 -v /root/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress"
docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wpuser@ -e WORDPRESS_DB_NAME=wordpress_db -p 8081:80 -v /root/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress
echo ""
read -p "Precione enter para continuar"
clear

echo "Veamos ahora los containers que se estan ejecutando con el comando docker ps"
echo "docker ps"
docker ps
echo ""
read -p "Precione enter para continuar"
clear

echo "Ya estamos casi listos."
echo "Tenemos wordpress y la base de datos, solo nos falta instalar el servidor web y estamos listos"
echo "El servidor web va a ser NGINX, es el que esta de moda ahora :)"
echo "Lo instalaremos localmente en este servidor y abriremos el puerto 80 para que puedan acceder a el."
echo "para instalar ejecutaremos el siguiente comando"
echo "apt-get install -y nginx"
echo ""
read -p "Precione enter para continuar"
apt-get install -y nginx
echo ""
read -p "Precione enter para continuar"
clear

echo "Ahora configuraremos el servidor web"
echo "No explicaremos lo que se hara en detalle ya que no es el objetivo de este tutorial"
echo "cd container/"
echo "mv wordpress /etc/nginx/sites-available/"
echo "cd .."
echo ""
read -p "Precione enter para continuar"
cd container/
mv wordpress /etc/nginx/sites-available/
cd ..
ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-available/default
rm -f /etc/nginx/sites-enabled/default
systemctl restart nginx
clear




