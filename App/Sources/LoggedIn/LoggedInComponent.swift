//
//  LoggedInComponent.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/4/20.
//

import NeedleFoundation

protocol LoggedInDependency: Dependency {
    var loggedInViewController: LoggedInViewControllable { get }
    var playersStream: PlayersStream { get }
}

final class LoggedInComponent: NeedleFoundation.Component<LoggedInDependency> {
    
    var ticTacToeComponent: TicTacToeComponent {
        return TicTacToeComponent(parent: self)
    }
    
    var offGameComponent: OffGameComponent {
        return OffGameComponent(parent: self)
    }

    var loggedInViewController: LoggedInViewControllable {
        return dependency.loggedInViewController
    }
    
    var mutableScoreStream: MutableScoreStream {
        return shared { ScoreStreamImpl() }
    }
    
    // TODO: Implement properties to provide for OffGame scope.
    var scoreStream: ScoreStream {
        return mutableScoreStream
    }
    
    var player1: String { return player1Name }
    
    var player2: String { return player2Name }
    
    var player1Name: String
    var player2Name: String
    
    override init(parent: Scope) {
        player1Name = ""
        player2Name = ""
        super.init(parent: parent)
        
        
        _ = dependency.playersStream.names.subscribe { (playerNames) in
            if (playerNames.element != nil) {
                self.player1Name = playerNames.element.unsafelyUnwrapped?.0 ?? ""
                self.player2Name = playerNames.element.unsafelyUnwrapped?.1 ?? ""
            }
        }
    }
}
