#!/bin/bash

container="goldenheart"
image="goldenheart"
version="1.0.0"

port_ijulia="9999"

alreadyBuilt=$(docker ps -a | grep ${container} | wc -l)
if [ $alreadyBuilt -eq 0 ]
then
  # If hasn't, create a new one
  docker run -d -it -p ${port_ijulia}:9999 --name ${container} ${image}:${version}
  docker cp ~/.ssh ${container}:/root/
  docker attach ${container}
  echo "All done."
else
  # If already has ont, re start it
  docker start -i ${container}
fi
