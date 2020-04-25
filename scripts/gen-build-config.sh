#!/bin/bash

set -e
# set the location of Info.plist
BUILD_CONFIG_OUTPUT=$(pwd)/Sources/Generated/

# Make directory and or sub directorys if they don't exist yet.
mkdir -p $BUILD_CONFIG_OUTPUT

# set the buildNumber to the total number of commits on current branch plus a constant 
commitCount=$(git rev-list HEAD --count)
buildNumber=$(($commitCount + 2300000))

# 
productName=$1
bundleIdentifier=$2
version=$3


cat > "$BUILD_CONFIG_OUTPUT/BuildConfig.swift" <<EOF
//
//  BuildConfig.swift
//  $productName
//

// DO NOT EDIT - This code is generated build metadata

enum BuildConfig {
    static let version = "$version"
    static let buildNumber  = "$buildNumber"
    static let bundleIdentifier = "$bundleIdentifier"
}
EOF