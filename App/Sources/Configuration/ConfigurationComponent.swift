//
//  ConfigurationComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/28/20.
//

import NeedleFoundation
import UIKit
import Models

protocol ConfigurationDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but won't be
    // created by this RIB.
    var viewController: ConfigurationViewControllable { get }
    var playersStream: PlayersStream { get }
    var mutablePlayersStream: MutablePlayersStream { get }
}

final class ConfigurationComponent: Component<ConfigurationDependency>, LoggedOutDependency, LoggedInDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
    
    var interactor: ConfigurationInteractor {
        return shared { ConfigurationInteractor(mutablePlayersStream: mutablePlayersStream) }
    }
    
    var viewController: LoggedInViewControllable {
        return dependency.viewController as! LoggedInViewControllable
    }
    
    var mutablePlayersStream: MutablePlayersStream {
        return dependency.mutablePlayersStream
    }
    
    var playersStream: PlayersStream {
        return dependency.playersStream
    }
    
    var configuration: [String:Any] {
        [
            LoggedIn.ribID: [
                LoggedIn.plugins: [
                    "com.loggedin.plugin.ScoreSheet": [
                        "enabled": false,
                        "displayName" : "Leader Board"
                    ]
                ]
            ]
        ]
    }
    
    var loggedOutComponent: LoggedOutComponent {
        return LoggedOutComponent(dependency: self)
    }
    
    func loggedInComponent(player1Name: String, player2Name: String) -> LoggedInComponent {
        LoggedInComponent(parent: self, player1Name: player1Name, player2Name: player2Name)
    }
}
