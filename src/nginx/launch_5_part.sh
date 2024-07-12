#!/usr/bin/env bash


export DOCKER_CONTENT_TRUST=1

docker build . -t server:v3 --load

printf "Dockle judges the server:v3 image.\n"
dockle -ae pem -ae ask server:v3
printf "Status code = %d.\n" "$?"
export DOCKER_CONTENT_TRUST=0

docker run --rm -it -d -p 80:81 --name server3 server:v3

printf "The sever is up. Press <Enter> to stop it.\n"
read -p "Time to stop? " -r

docker stop server3