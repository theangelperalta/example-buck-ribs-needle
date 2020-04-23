// Copyright 2020-present, Angel Cortez.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.
//
//  ILoggedInPlugin.swift
//  LoggedInPlugin
//
//  Created by Angel Cortez on 4/20/20.
//

import RIBs

public protocol ILoggedInPlugin {
    var id: String { get }
    var builder: LoggedInPluginBuildable { get }
}
