//
//  ScoreSheetViewController.swift
//  ScoreSheet
//
//  Created by Angel Cortez on 4/21/20.
//

import RIBs
import RxSwift
import UIKit

protocol ScoreSheetPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ScoreSheetViewController: UIViewController, ScoreSheetPresentable, ScoreSheetViewControllable {

    weak var listener: ScoreSheetPresentableListener?
}
