//
//  RootComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/4/20.
//

import RIBs
import UIKit

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

class RootComponent: Component<RootDependency>, LoggedOutDependency, LoggedInDependency {
    
    var playersStream: PlayersStream {
        return mutablePlayersStream
    }

    var mutablePlayersStream: MutablePlayersStream {
        return shared { PlayersStreamImpl() }
    }

    var rootViewController: RootViewController {
        return shared { RootViewController() }
    }
    
    var viewController: LoggedInViewControllable {
        return rootViewController
    }
    
    var interactor: RootInteractor {
        return shared { RootInteractor(presenter: rootViewController, mutablePlayersStream: mutablePlayersStream) }
    }

    var loggedOutComponent: LoggedOutComponent {
        return LoggedOutComponent(dependency: self)
    }
    
    func loggedInComponent(player1Name: String, player2Name: String) -> LoggedInComponent {
        LoggedInComponent(dependency: self, player1Name: player1Name, player2Name: player2Name)
    }
}
