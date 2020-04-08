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
import MissingNeedleCode
//protocol LoggedOutDependency: Dependency {
//    // TODO: Declare the set of dependencies required by this RIB, but cannot be
//    // created by this RIB.
//}
//
//final class LoggedOutComponent: Component<LoggedOutDependency> {
//
//    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
//}

// MARK: - Builder

protocol LoggedOutBuildable: MissingNeedleCode.Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: NeedleBuilder<LoggedOutComponent>, LoggedOutBuildable {

    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
        let component = componentBuilder()
        component.loggedOutInteractor.listener = listener
        return LoggedOutRouter(interactor: component.loggedOutInteractor, viewController: component.loggedOutViewController)
    }
}
