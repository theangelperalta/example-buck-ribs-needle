#!/bin/bash          
SRCS=$(pwd)/Sources
GEN_PATH=$(pwd)/NeedleGenerated

# export SOURCEKIT_LOGGING=0 && ../Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated.swift $SRCS --header-doc ../copyright_header.txt
# ../Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated.swift $SRCS --header-doc ../copyright_header.txt --exclude-paths $SRCS/OffGame $SRCS/LoggedIn
../Carthage/Checkouts/needle/Generator/bin/needle generate $GEN_PATH/NeedleGenerated.swift $SRCS --header-doc ../copyright_header.txt
