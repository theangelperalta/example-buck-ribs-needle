//
//  ScoreSheetInteractor.swift
//  ScoreSheet
//
//  Created by Angel Cortez on 4/21/20.
//

import RIBs
import RxSwift
import LoggedInPlugin
import Models

public protocol ScoreSheetRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ScoreSheetPresentable: Presentable {
    var listener: ScoreSheetPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
    func set(score: Score)
}

public protocol ScoreSheetListener: LoginPluginListener {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ScoreSheetInteractor: PresentableInteractor<ScoreSheetPresentable>, ScoreSheetInteractable, ScoreSheetPresentableListener {

    weak var router: ScoreSheetRouting?
    weak var listener: LoginPluginListener?

    private let scoreStream: ScoreStream

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: ScoreSheetPresentable, scoreStream: ScoreStream) {
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

    // MARK: Private
    
    private func updateScore() {
    scoreStream.score
        .subscribe(
            onNext: { (score: Score) in
                self.presenter.set(score: score)
            }
        )
        .disposeOnDeactivate(interactor: self)
    }
    
    // MARK: ScoreSheetPresentableListener
    func close() {
        listener?.done()
    }
}
