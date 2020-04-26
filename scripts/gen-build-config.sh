#!/bin/bash

set -e
# set the location of Info.plist
BUILD_CONFIG_OUTPUT=$1

# set the buildNumber to the total number of commits on current branch plus a constant 
commitCount=$(git rev-list HEAD --count)
buildNumber=$(($commitCount + 2300000))

# 
productName=$2
bundleIdentifier=$3
version=$4


cat > $BUILD_CONFIG_OUTPUT <<EOF
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