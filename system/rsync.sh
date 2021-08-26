#!/bin/bash

if [ -z "$1" ]; then
    exit 1
fi

if [ -z "$TIMESTAMP" ]; then
    TIMESTAMP=$(date -Is)
fi

TARGET="$1/system"
set -- $TARGET "${@:2}"

if [ -z "$NO_BTRFS" ]; then
    btrfs sub cr $TARGET
fi

# https://ostechnix.com/backup-entire-linux-system-using-rsync/
sudo rsync -axXv \
    --exclude-from="$(dirname $0)/excluded.txt" \
    --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
    --exclude="/home" \
    / $@

if [ -z "$NO_BTRFS" ]; then
    sudo btrfs sub snapshot -r $TARGET "$TARGET-$TIMESTAMP"
fi
