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
import Foundation
import Models

protocol RootRouting: ViewableRouting {
    func routeToConfiguration()
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener, UrlHandler {

    weak var router: RootRouting?

    weak var listener: RootListener?
    
    private let mutablePlayersStream: MutablePlayersStream

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: RootPresentable, mutablePlayersStream: MutablePlayersStream) {
        self.mutablePlayersStream = mutablePlayersStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - UrlHandler

    func handle(_ url: URL) {
//        let launchGameWorkflow = LaunchGameWorkflow(url: url)
//        launchGameWorkflow
//            .subscribe(self)
//            .disposeOnDeactivate(interactor: self)
    }

}
