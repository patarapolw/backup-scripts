#!/bin/bash

if [ -z "$1" ]; then
    exit 1
fi

TARGET=$1

summary() {
    printf '%s %s\n' $(stat -c '%y' "$1") $(md5sum "$1")
}
export -f summary

if [[ $(find $TARGET -type f -exec bash -c 'summary "$0"' {} \; | LC_ALL=C sort | md5sum) != $(cat "$TARGET/../md5sum.txt") ]]; then
    echo "not OK"
    exit 1
fi
