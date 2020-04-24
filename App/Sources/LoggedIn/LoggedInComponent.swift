//
//  LoggedInComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/4/20.
//

import NeedleFoundation
import LoggedInPluginPoint
import Models

protocol LoggedInDependency: Dependency {
    var viewController: LoggedInViewControllable { get }
    var playersStream: PlayersStream { get }
}

protocol LoggedInPluginExtension: PluginExtension {
    var loggedInPluginFactory: ILoggedInPluginFactory { get }
    var mutableScoreStream: MutableScoreStream { get }
}

final class LoggedInComponent: PluginizedComponent<LoggedInDependency, LoggedInPluginExtension, LoggedInNonCoreComponent>, OffGameDependency, TicTacToeDependency {
    
    var interactor: LoggedInInteractor {
        shared { LoggedInInteractor(mutableScoreStream: mutableScoreStream) }
    }
    
    var ticTacToeComponent: TicTacToeComponent {
        return TicTacToeComponent(dependency: self)
    }
    
    var offGameComponent: OffGameComponent {
        return OffGameComponent(dependency: self)
    }

    var viewController: LoggedInViewControllable {
        return dependency.viewController
    }
    
    var mutableScoreStream: MutableScoreStream {
        return shared { ScoreStreamImpl() }
    }
    
    var loggedInPluginFactory: ILoggedInPluginFactory {
        pluginExtension.loggedInPluginFactory
    }
    
    // TODO: Implement properties to provide for OffGame scope.
    var scoreStream: ScoreStream {
        return mutableScoreStream
    }
    
    let player1Name: String
    let player2Name: String

    init(dependency: LoggedInDependency, player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(parent: dependency as! Scope)
    }
}
