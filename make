#!/bin/bash -e

echo "WILL DESTROY EXISTING CONTAINER"
echo "Press enter"
read

docker stop perso || true
docker rm -f perso || true
docker build -t perso .
docker create --name=perso \
  --network=devcon_devcon \
  -v ~/dev:/home/jole/dev \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -p 8080:8080 \
  -p 3000:3000 \
  perso

./start
