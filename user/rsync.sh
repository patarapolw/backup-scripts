#!/bin/bash

if [ -z "$1" ]; then
    exit 1
fi

if [ -z "$TIMESTAMP" ]; then
    TIMESTAMP=$(date -Is)
fi

TARGET="$1/$USER"
set -- $TARGET "${@:2}"

if [ -z "$NO_BTRFS" ]; then
    btrfs sub cr $TARGET
fi

# # https://ostechnix.com/backup-entire-linux-system-using-rsync/
rsync -axXv \
    --exclude-from="$(dirname $0)/excluded.txt" \
    --exclude={"/.cache/"} \
    /home/$USER/ $@

if [ -z "$NO_BTRFS" ]; then
    btrfs sub snapshot -r $TARGET "$TARGET-$TIMESTAMP"
fi
