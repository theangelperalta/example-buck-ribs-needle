//
//  ScoreSheetRouter.swift
//  ScoreSheet
//
//  Created by Angel Cortez on 4/21/20.
//

import RIBs
import LoggedInPlugin

protocol ScoreSheetInteractable: Interactable {
    var router: ScoreSheetRouting? { get set }
    var listener: LoginPluginListener? { get set }
}

protocol ScoreSheetViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class ScoreSheetRouter: ViewableRouter<ScoreSheetInteractable, ScoreSheetViewControllable>, ScoreSheetRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: ScoreSheetInteractable, viewController: ScoreSheetViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
