//
//  LoggedInComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/4/20.
//

import NeedleFoundation
import LoggedInPlugin
import LoggedInPluginPoint
import Models

protocol LoggedInDependency: Dependency {
    var viewController: LoggedInViewControllable { get }
    var playersStream: PlayersStream { get }
    var configuration: [String:Any] { get }
}

protocol LoggedInPluginExtension: PluginExtension {
    var loggedInPluginFactory: ILoggedInPluginFactory { get }
}

enum LoggedIn {
    static let ribID = "com.tictactoe.loggedin"
    static let plugins = "\(ribID).plugins"
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

    var pluginID: String {
        let pluginID = plugins.keys.first { (plugins[$0] as? [String:Any])?["enabled"] as? Bool ?? false }
        return pluginID ?? ""
    }
    
    var pluginDisplayName: String {
        (plugins[pluginID] as? [String:Any])?["displayName"] as? String ?? ""
    }
    
    fileprivate var plugin: ILoggedInPlugin? {
        loggedInPluginFactory.getPlugin(id: pluginID)
    }
    
    fileprivate var plugins: [String:Any] {
        (dependency.configuration[LoggedIn.ribID] as? [String:Any])?[LoggedIn.plugins] as? [String : Any] ?? [:]
    }

    var configuration: [String:Any] {
        dependency.configuration[LoggedIn.ribID] as? [String:Any] ?? [:]
    }
    
    // TODO: Implement properties to provide for OffGame scope.
    var scoreStream: ScoreStream {
        return mutableScoreStream
    }
    
    let player1Name: String
    let player2Name: String

    // TODO: Replace this the dangerous force cast and explicit passing of dependencies
    // with PlayersStream. Thus, removing the need to create this constructor and
    // force unwrap.
    init(parent: LoggedInDependency, player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(parent: parent as! Scope)
    }
}
