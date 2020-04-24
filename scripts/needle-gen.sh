#!/bin/bash          
SRCS=$(pwd)/Sources
GEN_PATH=$(pwd)/NeedleGenerated
FILENAME_EXT=""

if [ ! -z $1 ]; then
    FILENAME_EXT=$1
fi

# export SOURCEKIT_LOGGING=0 && $REPO_ROOT/Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated$FILENAME_EXT.swift $SRCS --header-doc $REPO_ROOT/copyright_header.txt
export SOURCEKIT_LOGGING=1 && $REPO_ROOT/Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated$FILENAME_EXT.swift $SRCS $REPO_ROOT/Libraries/LoggedInPlugin/Sources $REPO_ROOT/Libraries/LoggedInPluginPoint/Sources $REPO_ROOT/Libraries/ScoreSheet/Sources  --pluginized --header-doc $REPO_ROOT/copyright_header.txt
