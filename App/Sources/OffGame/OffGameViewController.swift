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
import RxCocoa
import RxSwift
import SnapKit
import UIKit
import Models

protocol OffGamePresentableListener: class {
    func startGame()
    func showPlugin(id: String)
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    var uiviewController: UIViewController {
        return self
    }

    weak var listener: OffGamePresentableListener?

    init(player1Name: String, player2Name: String, pluginID: String, pluginDisplayName: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        self.pluginID = pluginID
        self.pluginDisplayName = pluginDisplayName
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - OffGamePresentable

    func set(score: Score) {
        self.score = score
    }

    // MARK: - Private

    private let player1Name: String
    private let player2Name: String
    private let pluginID: String
    private let pluginDisplayName: String

    private var player1Label: UILabel?
    private var player2Label: UILabel?
    private var drawLabel: UILabel?
    private var score: Score?
    
    private var btnStackView: UIStackView?
    private var startButton: UIButton?
    private var showPluginButton: UIButton?
    
    private func setupView() {
        view.backgroundColor = UIColor.yellow
        buildBtnStackView()
        buildStartButton()
        
        if !pluginID.isEmpty && !pluginDisplayName.isEmpty {
            buildShowPluginButton(title: pluginDisplayName)
        } else {
            // If showing ScoreSheet or other plugin buttons
            // we want to hide these UI elements
            buildPlayerLabels()
        }
    }
    
    private func buildBtnStackView()
    {
        btnStackView = UIStackView()
        guard let btnStackView = btnStackView else { return }
        view.addSubview(btnStackView)
        btnStackView.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.leading.trailing.equalTo(view).inset(40)
            maker.bottom.equalTo(view.snp_bottom).inset(30)
        }
        btnStackView.axis = .vertical
        btnStackView.alignment = .fill
        btnStackView.spacing = 20
    }

    private func buildStartButton() {
        startButton = UIButton()
        guard let startButton = startButton else { return }
        btnStackView?.addArrangedSubview(startButton)
        startButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.height.equalTo(50)
        }
        startButton.setTitle("Start Game", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.black
        startButton.rx.tap
            .subscribe(
                onNext: { [weak self] in
                    self?.listener?.startGame()
                }
            )
            .disposed(by: disposeBag)
    }

    private func buildShowPluginButton(title: String) {
        showPluginButton = UIButton()
        guard let showPluginButton = showPluginButton else { return }
        btnStackView?.addArrangedSubview(showPluginButton)
        showPluginButton.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.height.equalTo(50)
        }
        showPluginButton.setTitle(title, for: .normal)
        showPluginButton.setTitleColor(UIColor.white, for: .normal)
        showPluginButton.backgroundColor = UIColor.black
        showPluginButton.rx.tap
            .subscribe(
                onNext: { [weak self] in
                    self?.listener?.showPlugin(id: self?.pluginID ?? "")
                }
        )
            .disposed(by: disposeBag)
    }
    
    private func buildPlayerLabels() {
        let labelBuilder: (UIColor) -> UILabel = { (color: UIColor) in
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 35)
            label.backgroundColor = UIColor.clear
            label.textColor = color
            label.textAlignment = .center
            return label
        }

        let drawLabel = labelBuilder(PlayerType.draw.color)
        self.drawLabel = drawLabel
        view.addSubview(drawLabel)
        drawLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(70)
            maker.leading.trailing.equalTo(self.view).inset(20)
            maker.height.equalTo(40)
        }
        
        let player1Label = labelBuilder(PlayerType.player1.color)
        self.player1Label = player1Label
        view.addSubview(player1Label)
        player1Label.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(drawLabel.snp.bottom).offset(20)
            maker.height.leading.trailing.equalTo(drawLabel)
        }


        let vsLabel = UILabel()
        vsLabel.font = UIFont.systemFont(ofSize: 25)
        vsLabel.backgroundColor = UIColor.clear
        vsLabel.textColor = UIColor.darkGray
        vsLabel.textAlignment = .center
        vsLabel.text = "vs"
        view.addSubview(vsLabel)
        vsLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Label.snp.bottom).offset(10)
            maker.leading.trailing.equalTo(player1Label)
            maker.height.equalTo(20)
        }

        let player2Label = labelBuilder(PlayerType.player2.color)
        self.player2Label = player2Label
        view.addSubview(player2Label)
        player2Label.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(vsLabel.snp.bottom).offset(10)
            maker.height.leading.trailing.equalTo(player1Label)
        }

        updatePlayerLabels()
    }

    private func updatePlayerLabels() {
        let player1Score = score?.player1Score ?? 0
        player1Label?.text = "\(player1Name) (\(player1Score))"

        let player2Score = score?.player2Score ?? 0
        player2Label?.text = "\(player2Name) (\(player2Score))"
        
        let draws = score?.draws ?? 0
        drawLabel?.text = "Draws (\(draws))"
    }

    private let disposeBag = DisposeBag()
}

extension PlayerType {

    var color: UIColor {
        switch self {
        case .player1:
            return UIColor.red
        case .player2:
            return UIColor.blue
        case .draw:
            return UIColor.black
        }
    }
}
