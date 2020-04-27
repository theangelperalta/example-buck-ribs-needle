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

protocol OffGameBuildable: Buildable {
    func build(withListener listener: OffGameListener) -> OffGameRouting
}

final class OffGameBuilder: ComponentizedBuilder<OffGameComponent, OffGameRouting, OffGameListener, Void>, OffGameBuildable {
    
    override func build(with component: OffGameComponent, _ listener: OffGameListener) -> OffGameRouting {
        let viewController = OffGameViewController(
            player1Name: component.dependency.player1Name,
            player2Name: component.dependency.player2Name,
            pluginID: component.dependency.pluginID,
            pluginDisplayName: component.dependency.pluginDisplayName
        )
        let interactor = OffGameInteractor(presenter: viewController, scoreStream: component.dependency.scoreStream)
        interactor.listener = listener

        let router = OffGameRouter(interactor: interactor, viewController: viewController)
        return router
    }

    func build(withListener listener: OffGameListener) -> OffGameRouting {
        return build(withDynamicBuildDependency: listener,
        dynamicComponentDependency: ())
    }
}
