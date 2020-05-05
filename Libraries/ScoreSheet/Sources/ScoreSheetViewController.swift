//
//  ScoreSheetViewController.swift
//  ScoreSheet
//
//  Created by Angel Cortez on 4/21/20.
//

import RIBs
import RxSwift
import RxCocoa
import UIKit
import Models
import SnapKit

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
    
    private var playerStackView: UIStackView?
    private var doneButton: UIButton?
    private var showPluginButton: UIButton?
    private let disposeBag = DisposeBag()
    
    private func setupView() {
        view.backgroundColor = .blue
        buildPlayerStackView()
        buildFinishBtn()
    }
    
    private func buildPlayerStackView()
    {
        playerStackView = UIStackView()
        guard let playerStackView = playerStackView else { return }
        view.addSubview(playerStackView)
        playerStackView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(view.snp_top).inset(50)
            maker.leading.trailing.equalTo(view).inset(40)
        }
        playerStackView.axis = .vertical
        playerStackView.alignment = .fill
        playerStackView.spacing = 20

        
        drawLabel = buildLabel(text: "Draw", color: .brown)
        player1Label = buildLabel(text: player1Name, color: .red)
        player2Label = buildLabel(text: player2Name, color: .yellow)
        
        guard let drawLabel = drawLabel, let player1Label = player1Label, let player2Label = player2Label else { return }
        
        [drawLabel, player1Label, player2Label].forEach {
            playerStackView.addArrangedSubview($0)
        }
        
        updatePlayerLabels()
    }
    
    private func buildLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 35)
        label.backgroundColor = UIColor.clear
        label.textColor = color
        label.textAlignment = .center
        label.text = text
        return label
    }
    
    private func updatePlayerLabels() {
        let player1Score = score?.player1Score ?? 0
        player1Label?.text = "\(player1Name) (\(player1Score))"

        let player2Score = score?.player2Score ?? 0
        player2Label?.text = "\(player2Name) (\(player2Score))"
        
        let draws = score?.draws ?? 0
        drawLabel?.text = "Draws (\(draws))"
    }
    
    private func buildFinishBtn() {
        doneButton = UIButton()
        guard let doneButton = doneButton else { return }
        view.addSubview(doneButton)
        doneButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.leading.trailing.equalTo(view).inset(40)
            maker.bottom.equalTo(view.snp_bottom).inset(30)
            maker.height.equalTo(50)
        }
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.backgroundColor = UIColor.black
        doneButton.rx.tap
            .subscribe(
                onNext: { [weak self] in
                    self?.listener?.close()
                }
        )
            .disposed(by: disposeBag)
    }
    
}
