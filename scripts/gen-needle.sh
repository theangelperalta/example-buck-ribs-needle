#!/bin/bash
# This this vars need to be fixed to work also just on buck builds, not just xcode builds
# Checkout Buck genrule() documentation for env vars
# $buck_root is in the Makefile

ROOT=$buck_root
SRCS=$ROOT/App/Sources
GEN_FILE=$1

export SOURCEKIT_LOGGING=0 && $ROOT/Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_FILE $SRCS $ROOT/Libraries/  --pluginized --header-doc $ROOT/copyright_header.txt
