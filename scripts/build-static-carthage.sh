#!/bin/sh -e

#  Created by Mark Jarecki on 10/7/19.
#
# Usage:
#
# Basic.
# bash ./path/to/build-static-carthage -d realm-cocoa RxSwift RxSwiftExt -p ios
#
# Custom framework search path, relative to the project
# bash ./path/to/build-static-carthage -d realm-cocoa RxSwift RxSwiftExt -p ios -f ./path/to/Carthage/SomeOtherBuildDir/iOS/**
#

# Function: Validate the given platform name argument against valid platform names
function ValidatePlatformName() {

    case "$1" in

        "ios" | "macos" | "tvos" | "watchos")
            echo "$1";;

        *)
            echo "$1"

            # Return error code
            return 1;;

    esac

}

# Function: Assign default framework search paths for a valid platform name
function DefaultFrameworkSearchPathsForPlatform() {

    case "$1" in

        "ios")
            echo "./Carthage/Build/iOS/**";;

        "macos")
            echo "./Carthage/Build/Mac/**";;

        "tvos")
            echo "./Carthage/Build/tvOS/**";;

        "watchos")
            echo "./Carthage/Build/watchOS/**";;

        *)
            # Echo the exit code
            echo 1;;

    esac

}

# Make a unique temporary file with mktemp
XCCONFIG=$(mktemp /tmp/static.xcconfig.XXXXXX)

# Perform clean-up on Interrupt, Hang Up, Terminate, Exit signals
trap 'rm -f "$XCCONFIG"' INT TERM HUP EXIT

# Platform name
PLATFORM_NAME=""

# Base framework search path
FMWK_SEARCH_PATHS="\$(inherited) "

# Dependencies
DEPENDENCIES=""

# Current flag cursor
CURRENT_FLAG=""

# Extract arguments from commandline
while [ ! $# -eq 0 ]; do

    case "$1" in

        --platform | -p)

            CURRENT_FLAG="p";;

        --framework-search-path | -f)

            CURRENT_FLAG="f";;

        --dependencies | -d)

            CURRENT_FLAG="d";;

        *)

            if [[ $CURRENT_FLAG == "p" ]]; then

                # Ensure that no platform has already been recorded
                if [[ $PLATFORM_NAME == "" ]]; then

                    PLATFORM_NAME+=$(ValidatePlatformName $1)

                    # If return code 1, throw an error
                    if [ $? -eq 1 ]; then

                        # To stderr
                        echo "'$PLATFORM_NAME' is an invalid platform name.">&2

                        # Exit the script
                        exit $?

                    fi

                    FMWK_SEARCH_PATHS+="$(DefaultFrameworkSearchPathsForPlatform $1) "

                # Otherwise throw an error
                else

                    # To stderr
                    echo "Too many platform arguments. Limited to one.">&2

                    # Exit the script
                    exit 1

                fi

            elif [[ $CURRENT_FLAG == "f" ]]; then

                FMWK_SEARCH_PATHS+="$1 "

            elif [[ $CURRENT_FLAG == "d" ]]; then

                DEPENDENCIES+="$1 "

            else

                # To stderr
                echo "'$1' not a valid argument.">&2

                # Exit the script
                exit 1

            fi;;
    esac
    shift
done

# If there are no dependency arguments, exit the script
if [[ $DEPENDENCIES == "" ]]; then

    # To stderr
    echo "Missing dependency arguments.">&2

    # Exit the script
    exit 1

fi

# If there is no platform argument, exit the script
if [[ $PLATFORM_NAME == "" ]]; then

    # To stderr
    echo "Missing platform argument.">&2

    # Exit the script
    exit 1

fi

# Write properties to the temp xconfig file
echo "MACH_O_TYPE = staticlib" >> $XCCONFIG
echo "DEBUG_INFORMATION_FORMAT = dwarf" >> $XCCONFIG
echo "FRAMEWORK_SEARCH_PATHS = $FMWK_SEARCH_PATHS" >> $XCCONFIG

# Export temporary xcconfig file to all current shell child processes
export XCODE_XCCONFIG_FILE="$XCCONFIG"

# Echo outcome
echo
echo "Building static frameworks with Xcode temporary xconfig file:"
echo $XCCONFIG
echo
echo "With contents:"
while read line; do
echo "$line"
done < $XCCONFIG
echo
echo "Building with command:"
echo "carthage build --no-use-binaries --platform $PLATFORM_NAME $DEPENDENCIES"
echo

# Build Carthage
carthage build --no-use-binaries --platform $PLATFORM_NAME $DEPENDENCIES
