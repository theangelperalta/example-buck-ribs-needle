//
//  LoggedOutComponent.swift
//  TicTacToeApp
//
//  Created by Angel Cortez on 4/4/20.
//

import RIBs
import Models

protocol LoggedOutDependency: Dependency {
    var mutablePlayersStream: MutablePlayersStream { get }
}

class LoggedOutComponent: Component<LoggedOutDependency> {

    var viewController:  LoggedOutViewController {
        return shared { LoggedOutViewController() } 
    }
    
    var interactor: LoggedOutInteractor {
        return shared { LoggedOutInteractor(presenter: viewController) }
    }
}
