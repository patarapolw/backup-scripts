#!/bin/bash

if [[ $(whoami) != root ]]; then
    exit 1
fi

if [ -z "$1" ]; then
    exit 1
fi

if [ -z "$TIMESTAMP" ]; then
    TIMESTAMP=$(date -Is)
fi

TARGET="$1/system/$TIMESTAMP/system"
set -- $TARGET "${@:2}"

mkdir -p $TARGET

# https://ostechnix.com/backup-entire-linux-system-using-rsync/
rsync -axX --info=progress2 \
    --exclude-from="$(dirname $0)/excluded.txt" \
    --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
    --exclude="/home" \
    / $@

# summary() {
#     printf '%s %s\n' $(stat -c '%y' "$1") $(md5sum "$1")
# }
# export -f summary

# find $TARGET -type f -exec bash -c 'summary "$0"' {} \; | LC_ALL=C sort | md5sum > "$TARGET/../md5sum.txt"
