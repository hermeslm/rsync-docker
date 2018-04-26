#!/usr/bin/env bash

echo ""
echo "***** Building a new rsync image *****"

if [ "$#" -ne 1 ]
then
  echo "Usage: $0 [TAG]"
  exit 1
fi

TAG=$1

docker build --rm=true --no-cache=true  --force-rm=true -t onedsol/rsync:${TAG} .
cat ./password.txt | docker login --username onedsol --password-stdin
docker push onedsol/rsync
docker push onedsol/rsync:latest
docker push onedsol/rsync:${TAG}