//
//  LoggedInComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/4/20.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var viewController: LoggedInViewControllable { get }
    var playersStream: PlayersStream { get }
}

final class LoggedInComponent: Component<LoggedInDependency>, OffGameDependency, TicTacToeDependency {
    
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
    
    // TODO: Implement properties to provide for OffGame scope.
    var scoreStream: ScoreStream {
        return mutableScoreStream
    }
    
    let player1Name: String
    let player2Name: String

    init(dependency: LoggedInDependency, player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(dependency: dependency)
    }
}
