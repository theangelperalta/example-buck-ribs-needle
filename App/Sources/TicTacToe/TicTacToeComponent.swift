//
//  TicTacToeComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/7/20.
//

import RIBs

protocol TicTacToeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var player1Name: String { get }
    var player2Name: String { get }
    var pluginID: String { get }
    var pluginDisplayName: String { get }
}

final class TicTacToeComponent: Component<TicTacToeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}
