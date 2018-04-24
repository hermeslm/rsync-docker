#!/usr/bin/env bash

# This script allows you to backup a single volume from a container

usage() {
  echo "Usage: $0 [Container Name] [output path]"
  exit 1
}

if [ "$#" -ne 2 ]; then
  echo "Two params are expected" >&2
  usage
  exit 1
fi

VOLUME_NAME="some_volume"
OUTPUT_PATH="/backup/tmp"

now=$(date +"%Y-%m-%d-%H:%M:%S")
#file="$now.CONTAINER_NAME.tar.bz2"
folder="$(date +"%Y-%m-%d")"
mkdir ${OUTPUT_PATH}/${folder}

echo "Making $VOLUME_NAME backup..."

#rsync -avz --backup --info=progress2 /var/lib/docker/volumes/some_volume/ /backup/test/
docker run --volumes-from=jasperserver_mariadb_1 -v ${OUTPUT_PATH}/${folder}:/backup onedsol/rsync rsync -avz --backup --info=progress2 /bitnami /backup

echo "Done $VOLUME_NAME backup in ./$folder/$file"

#docker run --volumes-from=some_mysql -v $(pwd)/db/data:/backup rsync:alpine rsync -a --info=progress2 /var/lib/mysql/ /backup
