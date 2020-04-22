#!/bin/bash          
SRCS=$(pwd)/Sources
GEN_PATH=$(pwd)/NeedleGenerated
FILENAME_EXT=""

if [ ! -z $1 ]; then
    FILENAME_EXT=$1
fi

# export SOURCEKIT_LOGGING=0 && ../Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated.swift $SRCS --header-doc ../copyright_header.txt
# ../Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated.swift $SRCS --header-doc ../copyright_header.txt --exclude-paths $SRCS/OffGame $SRCS/LoggedIn
export SOURCEKIT_LOGGING=0 && ../Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated$FILENAME_EXT.swift $SRCS --header-doc ../copyright_header.txt
