#!/usr/bin/env bash

# This script allows you to backup a single volume from a container

usage() {
  echo "Usage: $0 [Container Name] [Volume Path] [output path]"
  exit 1
}

if [ "$#" -ne 3 ]; then
  echo "Three params are expected" >&2
  usage
  exit 1
fi

CONTAINER_NAME=$1
VOLUME_PATH=$2
OUTPUT_PATH=$3

now=$(date +"%Y-%m-%d-%H:%M:%S")
folder="$(date +"%Y-%m-%d")"
mkdir ${OUTPUT_PATH}/${folder}

echo "Making $CONTAINER_NAME backup..."

#rsync -avz --backup --info=progress2 /var/lib/docker/volumes/some_volume/ /backup/test/
docker run --volumes-from=${CONTAINER_NAME} -v ${OUTPUT_PATH}/${folder}:/backup onedsol/rsync rsync -avz --backup --info=progress2 ${VOLUME_PATH} /backup

echo "Done $CONTAINER_NAME backup in $OUTPUT_PATH/$folder"

#docker run --volumes-from=some_mysql -v $(pwd)/db/data:/backup rsync:alpine rsync -a --info=progress2 /var/lib/mysql/ /backup
