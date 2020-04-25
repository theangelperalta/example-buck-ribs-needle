#!/bin/bash
# This this vars need to be fixed to work also just on buck builds, not just xcode builds
ROOT=$(git rev-parse --show-toplevel)
SRCS=$ROOT/App/Sources
GEN_PATH=$ROOT/App/NeedleGenerated
FILENAME_EXT=""

if [ ! -z $1 ]; then
    FILENAME_EXT=$1
fi

export SOURCEKIT_LOGGING=0 && $ROOT/Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated$FILENAME_EXT.swift $SRCS $ROOT/Libraries/  --pluginized --header-doc $ROOT/copyright_header.txt
