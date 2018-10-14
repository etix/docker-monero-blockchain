#!/bin/sh
TARGET="etix/monero-blockchain"

docker build -t $TARGET:latest .
TAG="$(docker run --rm $TARGET:latest version | tr -d '\n' | awk -F'[()]' '{print $2}')"
docker tag $TARGET:latest $TARGET:$TAG

echo -n "Push $TARGET with tags 'latest' and '$TAG'?"
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    docker push $TARGET:latest
    docker push $TARGET:$TAG
else
    echo "Aborted"
    exit 1
fi
