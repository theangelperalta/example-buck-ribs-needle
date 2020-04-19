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

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: ComponentizedBuilder<LoggedOutComponent, LoggedOutRouting, LoggedOutListener, Void>, LoggedOutBuildable {

    override func build(with component: LoggedOutComponent, _ listener: LoggedOutListener) -> LoggedOutRouting {
        let interactor = component.interactor
        interactor.listener = listener
        return LoggedOutRouter(interactor: interactor,
                               viewController: component.viewController)
    }

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        build(withDynamicBuildDependency: listener, dynamicComponentDependency: ())
    }
}
