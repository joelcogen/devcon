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
  -e REDIS_URL=redis://redis:6379 \
  -e REDIS_HOST=redis \
  -e MONGODB_URI=mongodb://mongo:27017 \
  -p 8080:80 \
  perso 

./start
