// Copyright 2020-present, Angel Cortez.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.
//
//  LoggedInPluginBuilder.swift
//  LoggedInPlugin
//
//  Created by Angel Cortez on 4/20/20.
//

import RIBs

public protocol LoggedInPluginBuilder {
    func build() -> ViewableRouting
}