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

protocol OffGameRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func set(score: Score)
}

protocol OffGameListener: class {
    func startTicTacToe()
    func showPlugin(id: String)
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {

    weak var router: OffGameRouting?

    weak var listener: OffGameListener?
    
    private let scoreStream: ScoreStream

    init(presenter: OffGamePresentable, scoreStream: ScoreStream) {
        self.scoreStream = scoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        updateScore()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    // MARK: - Private
    
    private func updateScore() {
    scoreStream.score
        .subscribe(
            onNext: { (score: Score) in
                self.presenter.set(score: score)
            }
        )
        .disposeOnDeactivate(interactor: self)
    }

    // MARK: - OffGamePresentableListener

    func startGame() {
        listener?.startTicTacToe()
    }
    
    func showPlugin(id: String) {
        listener?.showPlugin(id: id)
    }
}
