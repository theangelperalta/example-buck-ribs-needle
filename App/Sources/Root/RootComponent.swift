//
//  RootComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/4/20.
//

import NeedleFoundation
import UIKit

class RootComponent: BootstrapComponent {
    
    var playersStream: PlayersStream {
        return mutablePlayersStream
    }

    var mutablePlayersStream: MutablePlayersStream {
        return shared { PlayersStreamImpl() }
    }

    var rootViewController: RootViewController {
        return RootViewController()
    }
    
    var loggedInViewController: LoggedInViewControllable {
        return rootViewController
    }
    
    var rootInteractor: RootInteractor {
        return RootInteractor(presenter: rootViewController)
    }

    var loggedOutComponent: LoggedOutComponent {
        return LoggedOutComponent(parent: self)
    }
    
    var loggedInComponent: LoggedInComponent {
        return LoggedInComponent(parent: self)
    }
}
