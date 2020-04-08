//
//  LoggedOutComponent.swift
//  TicTacToeApp
//
//  Created by Angel Cortez on 4/4/20.
//

import NeedleFoundation
import RIBs

protocol LoggedOutDependency: NeedleFoundation.Dependency {
    var mutablePlayersStream: MutablePlayersStream { get }
}

class LoggedOutComponent: NeedleFoundation.Component<LoggedOutDependency> {

    var loggedOutViewController:  LoggedOutViewController {
        return shared { LoggedOutViewController() } 
    }
    
    var loggedOutInteractor: LoggedOutInteractor {
        return shared { LoggedOutInteractor(presenter: loggedOutViewController) }
    }
}
