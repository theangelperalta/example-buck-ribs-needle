//
//  OffGameComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/7/20.
//

import RIBs
import Models

protocol OffGameDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var player1Name: String { get }
    var player2Name: String { get }
    var scoreStream: ScoreStream { get }
    var pluginID: String { get }
    var pluginDisplayName: String { get }
    var configuration: [String:Any] { get }
}

final class OffGameComponent: Component<OffGameDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    fileprivate var player1Name: String {
        return dependency.player1Name
    }
    
    fileprivate var scoreStream: ScoreStream {
        return dependency.scoreStream
    }
    
    fileprivate var player2Name: String {
        return dependency.player2Name
    }
}
