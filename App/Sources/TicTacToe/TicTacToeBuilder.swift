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

protocol TicTacToeBuildable: Buildable {
    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting
}

final class TicTacToeBuilder: ComponentizedBuilder<TicTacToeComponent, TicTacToeRouting, TicTacToeListener, Void>, TicTacToeBuildable {
    
    override func build(with component: TicTacToeComponent, _ listener: TicTacToeListener) -> TicTacToeRouting {
        let viewController = TicTacToeViewController(pluginID: component.dependency.pluginID, pluginDisplayName: component.dependency.pluginDisplayName)
        let interactor = TicTacToeInteractor(presenter: viewController, player1Name: component.dependency.player1Name, player2Name: component.dependency.player2Name)
        interactor.listener = listener
        return TicTacToeRouter(interactor: interactor, viewController: viewController)
    }
    
    func build(withListener listener: TicTacToeListener) -> TicTacToeRouting {
        build(withDynamicBuildDependency: listener, dynamicComponentDependency: ())
    }
}
