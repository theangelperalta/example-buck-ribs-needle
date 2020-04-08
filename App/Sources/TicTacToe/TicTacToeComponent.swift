//
//  TicTacToeComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/7/20.
//

import NeedleFoundation

protocol TicTacToeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var player1: String { get }
    var player2: String { get }
}

final class TicTacToeComponent: Component<TicTacToeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}
