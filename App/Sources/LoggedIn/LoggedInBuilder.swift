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

// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener,
               player1Name: String,
               player2Name: String) -> LoggedInRouting
}

final class LoggedInBuilder: ComponentizedBuilder<LoggedInComponent, LoggedInRouting, LoggedInListener, (String, String)>, LoggedInBuildable {

    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> LoggedInRouting {
        let (component, router) = build(withDynamicBuildDependency: listener, dynamicComponentDependency: (player1Name, player2Name))
//        return (router, component.interactor)
        return router
    }
    
    override func build(with component: LoggedInComponent, _ listener: LoggedInListener) -> LoggedInRouting {
        let interactor = component.interactor
        interactor.listener = listener
        let offGameBuilder = OffGameBuilder {
            component.offGameComponent
        }
        let ticTacBuilder = TicTacToeBuilder {
            component.ticTacToeComponent
        }
        
        let loggedInPluginFactory = component.loggedInPluginFactory
        
        let router = LoggedInRouter(interactor: interactor,
                                    viewController: component.viewController,
                                    loggedInPluginFactory: loggedInPluginFactory,
                                    offGameBuilder: offGameBuilder,
                                    ticTacToeBuilder: ticTacBuilder
        )
        return router
    }
}
