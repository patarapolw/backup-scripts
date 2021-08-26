#!/bin/bash

DIRNAME=$(dirname $0)

TARGET="$(cd $(dirname $1); pwd)/$(basename $1)"
set -- $TARGET "${@:2}"

mkdir -p $TARGET

sudo $DIRNAME/system/rsync.sh $@
$DIRNAME/user/rsync.sh $@
