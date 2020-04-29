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

protocol RootBuildable: Buildable {
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler)
}

final class RootBuilder: SimpleComponentizedBuilder<RootComponent, LaunchRouting>, RootBuildable {

    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler) {
        let (component, router) = build(withDynamicBuildDependency: (), dynamicComponentDependency: ())

        return (router, component.interactor)
    }
    
    override func build(with component: RootComponent) -> LaunchRouting {
        let configurationBuilder = ConfigurationBuilder { configuration in
            component.configurationComponent
        }
        let router = RootRouter(interactor: component.interactor,
                                viewController: component.rootViewController,
                                configurationBuilder: configurationBuilder)

        return router
    }
}
