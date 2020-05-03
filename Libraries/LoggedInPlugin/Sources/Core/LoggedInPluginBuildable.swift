//
//  LoggedInPluginBuildable.swift
//  LoggedInPlugin
//
//  Created by Angel Cortez on 4/22/20.
//

import RIBs

public protocol LoggedInPluginBuildable: Buildable {
    func build(withListener listener: LoginPluginListener) -> ViewableRouting
}
