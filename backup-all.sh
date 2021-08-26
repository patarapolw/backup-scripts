#!/bin/bash

DIRNAME=$(dirname $0)
$DIRNAME/system/rsync.sh $@
$DIRNAME/user/rsync.sh $@
