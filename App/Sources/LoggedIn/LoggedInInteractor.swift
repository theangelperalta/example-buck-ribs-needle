//
//  Copyright (c) 2017. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import RIBs
import RxSwift
import Models

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToTicTacToe()
    func routeToOffGame()
    func routeToPlugin(id: String)
}

protocol LoggedInListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor, LoggedInInteractable {

    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?
    
    private let mutableScoreStream: MutableScoreStream
       
    init(mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }

    // MARK: - OffGameListener

    func startTicTacToe() {
        router?.routeToTicTacToe()
    }
    
    func showPlugin(id: String) {
        router?.routeToPlugin(id: id)
    }

    // MARK: - TicTacToeListener

    func gameDidEnd(withWinner winner: Player?) {
        if let winner = winner {
            mutableScoreStream.updateScore(withWinner: winner.type)
        } else {
            mutableScoreStream.updateScore(withWinner: .draw)
        }
        
        router?.routeToOffGame()
    }
    
    // MARK: - LoggedInPluginListener
    func done() {
        router?.routeToOffGame()
    }
}
