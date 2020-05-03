//
//  ScoreSheetViewController.swift
//  ScoreSheet
//
//  Created by Angel Cortez on 4/21/20.
//

import RIBs
import RxSwift
import UIKit
import Models

protocol ScoreSheetPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
    func close()
}

final class ScoreSheetViewController: UIViewController, ScoreSheetPresentable, ScoreSheetViewControllable {

    weak var listener: ScoreSheetPresentableListener?
    
    init(player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        print("Scoresheet - Player 1: \(player1Name), Player 2: \(player2Name)")
    }
    
    // MARK: - ScoreSheetPresentable

    func set(score: Score) {
        self.score = score
    }

    // MARK: - Private

    private let player1Name: String
    private let player2Name: String

    private var player1Label: UILabel?
    private var player2Label: UILabel?
    private var drawLabel: UILabel?
    private var score: Score?
    
    private var btnStackView: UIStackView?
    private var startButton: UIButton?
    private var showPluginButton: UIButton?
    
    private func setupView() {
        view.backgroundColor = .blue
        
    }
    
}
