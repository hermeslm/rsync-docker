FROM alpine

MAINTAINER One Development Solution <hermeslm@gmail.com>

RUN apk add --no-cache rsync

COPY volume-backup.sh /

ENTRYPOINT [ "/bin/sh", "/volume-backup.sh" ]
