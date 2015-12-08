#!/bin/bash

container="ijulia"
image="goldenheart"

port_ijulia="9999"
port_ssh="9990"

alreadyBuilt=$(docker ps -a | grep ${container} | wc -l)
if [ $alreadyBuilt -eq 0 ] 
then
  # If hasn't, create a new one
  docker run -it -p ${port_ijulia}:9999 --name ${container} ${image}
else
  # If already has ont, re start it
  docker start -i ${container} 
fi
