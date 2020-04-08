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
import NeedleFoundation
import MissingNeedleCode

//protocol RootDependency: Dependency {
//    // TODO: Declare the set of dependencies required by this RIB, but cannot be
//    // created by this RIB.
//}

// MARK: - Builder

//protocol RootBuildable: Buildable {
//    func build() -> LaunchRouting
//}

final class RootBuilder: NeedleBuilder<RootComponent> {

    func build() -> LaunchRouting {
        let component = RootComponent()
        
        

//        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
//        let loggedOutBuilder = component.loggedOutComponent
        let loggedOutBuilder = LoggedOutBuilder {
            component.loggedOutComponent
        }
//        let loggedInBuilder = LoggedInBuilder(dependency: component)
        let loggedInBuilder = LoggedInBuilder {
            component.loggedInComponent
        }
//        let loggedInBuilder = component.loggedInComponent
        return RootRouter(interactor: component.rootInteractor,
                          viewController: component.rootViewController,
                          loggedOutBuilder: loggedOutBuilder,
                          loggedInBuilder: loggedInBuilder)
    }
}
