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
sudo -s
apt-get update && apt-get upgrade -y
clear

echo "El servidor ya esta updateado!"
echo "Ahora instalaremos Docker."
echo "Docker es lo que permite que los containers funcionen"
echo "El comando es:"
echo "apt-get install -y docker.io"
