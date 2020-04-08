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

import NeedleFoundation
import MissingNeedleCode
// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener,
               player1Name: String,
               player2Name: String) -> LoggedInRouting
}

final class LoggedInBuilder: NeedleBuilder<LoggedInComponent>, LoggedInBuildable {

    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> LoggedInRouting {
        let component = componentBuilder()
        let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream)
        interactor.listener = listener

        let offGameBuilder = OffGameBuilder {
            return component.offGameComponent
        }
        let ticTacToeBuilder = TicTacToeBuilder {
            component.ticTacToeComponent
        }
        return LoggedInRouter(interactor: interactor,
                              viewController: component.loggedInViewController,
                              offGameBuilder: offGameBuilder,
                              ticTacToeBuilder: ticTacToeBuilder)
    }
}
