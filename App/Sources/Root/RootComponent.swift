//
//  RootComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/4/20.
//

import NeedleFoundation
import UIKit
import Models

protocol RootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

class RootComponent: Component<RootDependency>, ConfigurationDependency {
    
    var playersStream: PlayersStream {
        return mutablePlayersStream
    }

    var mutablePlayersStream: MutablePlayersStream {
        return shared { PlayersStreamImpl() }
    }

    var rootViewController: RootViewController {
        return shared { RootViewController() }
    }
    
    var viewController: ConfigurationViewControllable {
        return rootViewController
    }
    
    var interactor: RootInteractor {
        return shared { RootInteractor(presenter: rootViewController, mutablePlayersStream: mutablePlayersStream) }
    }
    
    var configurationComponent: ConfigurationComponent {
        return ConfigurationComponent(parent: self)
    }
}
