#!/usr/bin/env bash

usage() {
  echo "Usage: volume-backup <backup|restore>"
  exit
}

backup() {
#    docker run -v [volume-name]:/volume -v [output-dir]:/backup --rm onedsol/rsync backup
    rsync -avz --backup --info=progress2 /volume/./ /backup
}

restore() {
#    docker run -v [volume-name]:/volume -v [output-dir]:/backup --rm onedsol/rsync restore
    rm -rf /volume/* /volume/..?* /volume/.[!.]*
    rsync -avz --backup --info=progress2 /backup/./ /volume
}

# Needed because sometimes pty is not ready when executing docker-compose run
# See https://github.com/docker/compose/pull/4738 for more details
# TODO: remove after above pull request or equivalent is merged
sleep 1

if [ $# -ne 1 ]; then
    usage
fi

OPERATION=$1

case "$OPERATION" in
"backup" )
backup
;;
"restore" )
restore
;;
* )
usage
;;
esac