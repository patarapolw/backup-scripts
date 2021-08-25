#!/bin/bash

if [ -z "$1" ]; then
    exit 1
fi

if [ -z "$TIMESTAMP" ]; then
    TIMESTAMP=$(date +"%Y-%m-%d")
fi

DIRNAME=$(dirname $0)
TARGET="$1/$TIMESTAMP/"

set -- $TARGET "${@:2}"

# # https://ostechnix.com/backup-entire-linux-system-using-rsync/
rsync -axXv \
    --exclude-from="$DIRNAME/excluded.txt" \
    --exclude={"/.cache/"} \
    /home/$USER/ $@
