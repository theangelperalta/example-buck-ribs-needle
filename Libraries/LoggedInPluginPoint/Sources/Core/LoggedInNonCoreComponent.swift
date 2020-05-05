//
//  LoggedInNonCoreComponent.swift
//  LoggedInPluginPoint
//
//  Created by Angel Cortez on 4/22/20.
//

import Models
import NeedleFoundation
import ScoreSheet

public protocol LoggedInNonCoreDependency: Dependency {
    var playersStream: PlayersStream { get }
    var configuration: [String:Any] { get }
    var scoreStream: ScoreStream { get }
    var player1Name: String { get }
    var player2Name: String { get }
}

/// Component for the LoggedIn non core scope.
public class LoggedInNonCoreComponent: NonCoreComponent<LoggedInNonCoreDependency>, ScoreSheetDependency {
    
    var scoreSheetComponent: ScoreSheetComponent {
        return ScoreSheetComponent(dependency: self)
    }

    fileprivate var scoreSheetBuilder: ScoreSheetBuilder {
        return ScoreSheetBuilder { [weak self] in
            self!.scoreSheetComponent
        }
    }

    public var scoreStream: ScoreStream {
        return dependency.scoreStream
    }
    
    public var player1Name: String {
        dependency.player1Name
    }
    
    public var player2Name: String {
        dependency.player2Name
    }
    
    public var loggedInPluginFactory: ILoggedInPluginFactory {
        return LoggedInPluginFactory(plugins: [
            scoreSheetBuilder
        ])
    }
}
