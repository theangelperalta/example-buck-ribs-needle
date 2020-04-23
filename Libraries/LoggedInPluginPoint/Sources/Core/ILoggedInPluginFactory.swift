//
//  ILoggedInPluginFactory.swift
//  LoggedInPluginPoint
//
//  Created by Angel Cortez on 4/22/20.
//

import Foundation
import LoggedInPlugin

public protocol ILoggedInPluginFactory {
    init(plugins: [ILoggedInPlugin])
    func getPlugin(id: String) -> ILoggedInPlugin?
}
