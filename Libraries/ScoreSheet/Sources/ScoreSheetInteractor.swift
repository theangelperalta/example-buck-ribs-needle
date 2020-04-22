//
//  ScoreSheetInteractor.swift
//  ScoreSheet
//
//  Created by Angel Cortez on 4/21/20.
//

import RIBs
import RxSwift

protocol ScoreSheetRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol ScoreSheetPresentable: Presentable {
    var listener: ScoreSheetPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol ScoreSheetListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ScoreSheetInteractor: PresentableInteractor<ScoreSheetPresentable>, ScoreSheetInteractable, ScoreSheetPresentableListener {

    weak var router: ScoreSheetRouting?
    weak var listener: ScoreSheetListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: ScoreSheetPresentable) {
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
}
