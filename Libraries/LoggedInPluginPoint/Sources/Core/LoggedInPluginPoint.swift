// Copyright 2020-present, Angel Cortez.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.
//
//  LoggedInPluginPoint.swift
//  LoggedInPluginPoint
//
//  Created by Angel Cortez on 4/20/20.
//

import RIBs
import LoggedInPlugin

class LoggedInPluginFactory: ILoggedInPluginFactory {
    private let plugins: [ILoggedInPlugin]
    required init(plugins: [ILoggedInPlugin]) {
        self.plugins = plugins
    }
    
    
    func getPlugin(id: String) -> ILoggedInPlugin? {
        return plugins.first { $0.id == id }
    }
}
