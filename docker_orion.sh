#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#source sourcefile

clear
echo "Este script tiene como fin automatizar la implementacion de un ambiente"
echo "Docker, con el fin de mostrar lo rapido y sencillo que es la tecnologia de Container"
echo "La automatizacion solo tiene como fin evitar errores de escritura y la idea principal"
echo "es que se entienda lo que esta haciendo"
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
echo "sudo -s"
echo "apt-get update && apt-get upgrade -y"
read -p "Precione enter para continuar"
apt-get update && apt-get upgrade -y
clear

echo "El servidor ya esta updateado!"
echo "Ahora instalaremos Docker."
echo "Docker es lo que permite que los containers funcionen"
echo "El comando es:"
echo "apt-get install -y docker.io"
read -p "Precione enter para continuar"
apt-get install -y docker.io
clear

echo "Listo instalamos Docker, ahora vamos a verificar que el servicio Docker este Funcionando:"
echo "Para eso usaremos los siguientes comandos"
echo "systemctl start docker"
echo "systemctl enable docker"
systemctl start docker
systemctl enable docker
echo " Listo ahora verificaremos que Docker esta corriendo preguntando al systema por la version de 
docker"
echo "con el comando:"
echo "docker version"
read -p "Precione enter para continuar"
docker version
read -p "Precione enter para continuar"
clear

echo "Ahora vamos a correr nuestro primer container"
echo "Este container es una aplicacion muy sencilla que lo unico que hace es escribir 'Hello World' en pantalla, y ademas de otro texto."
echo "El comando para correr un Container es docker run [nombre del container]"
echo "En ese caso"
echo "docker run hello-world"
read -p "Precione enter para continuar"
docker run hello-world
read -p "Precione enter para continuar"
clear

echo "Ahora instalaremos MariaDB en un container"
echo "Para lo cual primero traeremos a este servidor la imagen de un container de MariaDB, con el comando"
echo "docker pull mariadb"
read -p "Precione enter para continuar"
docker pull mariadb
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

echo "Para conectarnos a mariadb, necesitamos el cliente de mariadb para poder conectarnos, para ello ejecutaremos el siguiente comando"
echo "apt-get install -y mariadb-client-core-10.0"
apt-get install -y mariadb-client-core-10.0
echo ""
read -p "Precione enter para continuar"
clear

mysql -u wpuser -h 172.17.0.2 -p 
Show databases;
exit

echo "Funcionando"
