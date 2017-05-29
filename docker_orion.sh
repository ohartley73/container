#!/bin/bash
# -*- ENCODING: UTF-8 -*-
#source sourcefile

RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color


clear
echo -e "${GREEN}Este script tiene como fin automatizar la implementacion de un ambiente"
echo -e "${GREEN}Docker, con el fin de mostrar lo rapido y sencillo que es la tecnologia de Container"
echo -e "${GREEN}En vez de solicitar que uds hagan copy paste, este script hace la pega por uds. La idea principal"
echo -e "${GREEN}es que se entienda lo que esta haciendo."
echo -e "${GREEN}De todas maneras ustedes tendran una presentacion con los mismos comandos para que despues puedan hacer lo mismo en sus oficinas"
echo -e "${GREEN}lo que haremos es:"
echo -e "${GREEN}1. Actualizar Ubuntu."
echo -e "${GREEN}2. Instalar Docker"
echo -e "${GREEN}3. Crear un container con MariaDB"
echo -e "${GREEN}4. Crear un contauner con Wordpress"
echo -e "${GREEN}5. Instalar el servidor web NGINX, pero no en container, sino que localmente"
echo -e "${GREEN}6. Ingresar a nuestro wordpress Containerizado"
echo -e ""
read -p "${RED}Precione enter para continuar"
clear

echo -e "${GREEN}Primero lo primero, para que despues no digan que venia todo cocinado :)"
echo -e "${GREEN}Obtengamos la ip publica de este servidor:"
echo -e ""
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
echo -e "${GREEN}La ip publica es: ${myip}"
echo -e ""
echo -e "${GREEN}Tome nota de esa IP y abra el browser que mas le guste y en la direcion web ponga la IP que anotaste."
echo -e "${GREEN}Deberia verse asi http://xxx.xxx.xxx.xxx/"
echo -e "${GREEN}dale enter, y...... No va a cargar nada y terminara dando un error!"
echo -e "${GREEN}Eso es lo que queremos, estoy demostrando que en este servidor no hay nada y al final de este ejercicio, al cargar la misma IP,"
echo -e "${GREEN}deberia aparacer WordPress CHAN!"
echo -e ""
read -p "${GREEN}Precione enter para continuar"
clear


echo -e "Ahora vamos a hacer un update Ubuntu para tener todas las librerias al dia"
echo -e "apt-get update && apt-get upgrade -y"
echo -e ""
read -p "Precione enter para continuar"
apt-get update && apt-get upgrade -y
clear

echo -e "El servidor ya esta updateado!"
echo -e "Ahora instalaremos Docker."
echo -e "Docker es lo que permite que los containers funcionen"
echo -e "El comando es:"
echo -e "apt-get install -y docker.io"
echo -e ""
read -p "Precione enter para continuar"
apt-get install -y docker.io
clear

echo -e "Listo instalamos Docker, ahora vamos a verificar que el servicio Docker este Funcionando:"
echo -e "Para eso usaremos los siguientes comandos"
echo -e "systemctl start docker"
echo -e "systemctl enable docker"
echo -e ""
read -p "Precione enter para continuar"
systemctl start docker
systemctl enable docker
echo -e ""
echo -e "Listo ahora verificaremos que Docker esta corriendo preguntando al systema por la version de 
docker"
echo -e "con el comando:"
echo -e "docker version"
echo -e ""
read -p "Precione enter para continuar"
clear
docker version
echo -e ""
read -p "Precione enter para continuar"
clear

echo -e "Ahora vamos a correr nuestro primer container"
echo -e "Este container es una aplicacion muy sencilla que lo unico que hace es escribir 'Hello World' en pantalla, ademas de un texto explicativo."
echo -e "El comando para correr un Container es docker run [nombre del container]"
echo -e "En ese caso"
echo -e "docker run hello-world"
read -p "Precione enter para continuar"
clear
docker run hello-world
read -p "Precione enter para continuar"
clear

echo -e "Ahora instalaremos MariaDB en un container"
echo -e "Para lo cual primero traeremos a este servidor la imagen de un container de MariaDB, con el comando"
echo -e "docker pull mariadb"
read -p "Precione enter para continuar"
docker pull mariadb
echo -e ""
read -p "Precione enter para continuar"
clear

echo -e "Veamos con el comando docker images, las imagenes de containers que tenemos localmente"
echo -e "docker images"
read -p "Precione enter para continuar"
docker images
echo -e ""
read -p "Precione enter para continuar"
clear

echo -e "Ahora que ya tenenmos la imagen de MariaDB, deberiamos ejecutar el container, sin embargo antes vamos a crear los directorios que van a alojar nuestro wordpress"
echo -e "mkdir ~/wordpress"
echo -e "mkdir -p ~/wordpress/database"
echo -e "mkdir -p ~/wordpress/html"
read -p "Precione enter para continuar"
mkdir ~/wordpress
mkdir -p ~/wordpress/database
mkdir -p ~/wordpress/html
clear

echo -e "Ahora vamos a correr el container de MariaDB. Si bien el comando se ve complejo es bien facil de entender. El comando parte con docker run -e, luego saltense todo y vayan a la ultima palabra, la cual es mariadb."
echo -e "O sea estamos diciendo docker hecha a correr el container de mariadb, lo que esta entremedio son una serie de comandos a ejecutarse dentro de mariadb, para:"
echo -e "1. crear la password de Root"
echo -e "2. crear un usuario nuevo y que este se llame wpuser"
echo -e "3. Asignar a ese nuevo usuario la password: wpuser@"
echo -e "4. Crear una base de datos nueva que se llame wordpressdb en un directorio especifico."
echo -e "el comando para hacer todo eso es:"
echo -e "docker run -e MYSQL_ROOT_PASSWORD=aqwe123 -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wpuser@ -e MYSQL_DATABASE=wordpress_db -v /root/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb"
echo -e ""
read -p "Precione enter para continuar"
docker run -e MYSQL_ROOT_PASSWORD=aqwe123 -e MYSQL_USER=wpuser -e MYSQL_PASSWORD=wpuser@ -e MYSQL_DATABASE=wordpress_db -v /root/wordpress/database:/var/lib/mysql --name wordpressdb -d mariadb
echo -e ""
read -p "Precione enter para continuar"
clear

echo -e "Ahora usaremos el comando docker ps, para ver los containers que se estan ejecutando en la maquina"
echo -e "docker ps"
echo -e ""
read -p "Precione enter para continuar"
docker ps
echo -e ""
read -p "Precione enter para continuar"
clear

echo -e "ahora comprobemos que la base de dato este ahi y metamonos en ella"
echo -e "Para ellos primero debemos saber en que IP esta corriendo la base de datos, eso lo obtenemos con el siguiente comando"
echo -e "docker inspect -f '{{ .NetworkSettings.IPAddress }}' wordpressdb"
echo -e ""
read -p "Precione enter para continuar"
docker inspect -f '{{ .NetworkSettings.IPAddress }}' wordpressdb
echo -e ""
read -p "Precione enter para continuar"
echo -e "vamos a guardar esa ip"
echo -e "puedes tipear la ip denuevo ahora?:"
read IP
echo -e ""
echo -e "Gracias!"
read -p "Precione enter para continuar"
clear

#echo -e "Para conectarnos a mariadb, necesitamos el cliente de mariadb para poder conectarnos, para ello ejecutaremos el siguiente comando"
#echo -e "apt-get install -y mariadb-client-core-10.0"
#apt-get install -y mariadb-client-core-10.0
#echo -e ""
#read -p "Precione enter para continuar"
#clear

#mysql -u wpuser -h 172.17.0.2 -p 
#Show databases;
#exit

#echo -e "Funcionando"

echo -e "Ahora instalaremos el container de Wordpress!"
echo -e "El container de mariadb, lo que hicimos fue bajarlo y luego ejecutarlo"
echo -e "En el caso de wordpress haremos algo distinto. Simplemete le diremos que ejecute el container"
echo -e "Docker siempre primero verificara si tiene el container en local, si no lo tiene lo baja. Por ende,"
echo -e "el comando pull que dicimos con mariadb no es estrictamete necesario."
echo -e "Denuevo, la manera de leer el comando es docker run -e, luedo salta al la ultima palabra del comando, y te daras cuenta que vamos por el buen camino"
echo -e "entremedio le estamos diciendo a wordpress los siguiete:"
echo -e "1. el usuario de la base de datos es wpuser"
echo -e "2. la contraseña para la base de datos es wpuser@"
echo -e "3. la base de datos se llama wordpress_db, y luego le entrega parametros de donde esta la base de datos"
echo -e ""
echo -e "el comando es:"
echo -e "docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wpuser@ -e WORDPRESS_DB_NAME=wordpress_db -p 8081:80 -v /root/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress"
docker run -e WORDPRESS_DB_USER=wpuser -e WORDPRESS_DB_PASSWORD=wpuser@ -e WORDPRESS_DB_NAME=wordpress_db -p 8081:80 -v /root/wordpress/html:/var/www/html --link wordpressdb:mysql --name wpcontainer -d wordpress
echo -e ""
read -p "Precione enter para continuar"
clear

echo -e "Veamos ahora los containers que se estan ejecutando con el comando docker ps"
echo -e "docker ps"
docker ps
echo -e ""
read -p "Precione enter para continuar"
clear

echo -e "Ya estamos casi listos."
echo -e "Tenemos wordpress y la base de datos, solo nos falta instalar el servidor web y estamos listos"
echo -e "El servidor web va a ser NGINX, es el que esta de moda ahora :)"
echo -e "Lo instalaremos localmente en este servidor y abriremos el puerto 80 para que puedan acceder a el."
echo -e "para instalar ejecutaremos el siguiente comando"
echo -e "apt-get install -y nginx"
echo -e ""
read -p "Precione enter para continuar"
apt-get install -y nginx
echo -e ""
read -p "Precione enter para continuar"
clear

echo -e "Ahora configuraremos el servidor web"
echo -e "No explicaremos lo que se hara en detalle ya que no es el objetivo de este tutorial"
echo -e "cd container/"
echo -e "mv wordpress /etc/nginx/sites-available/"
echo -e "cd .."
echo -e ""
read -p "Precione enter para continuar"
cd container/
mv wordpress /etc/nginx/sites-available/
cd ..
ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-available/default
rm -f /etc/nginx/sites-enabled/default
systemctl restart nginx
clear




