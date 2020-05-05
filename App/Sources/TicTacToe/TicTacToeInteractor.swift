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

protocol TicTacToeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TicTacToePresentable: Presentable {
    var listener: TicTacToePresentableListener? { get set }
    func setCell(atRow row: Int, col: Int, withPlayerType playerType: PlayerType)
    func announce(winner: Player?, withCompletionHandler handler: @escaping () -> ())
}

protocol TicTacToeListener: class {
    func gameDidEnd(withWinner winner: Player?)
    func showPlugin(id: String)
}

final class TicTacToeInteractor: PresentableInteractor<TicTacToePresentable>, TicTacToeInteractable, TicTacToePresentableListener {

    weak var router: TicTacToeRouting?

    weak var listener: TicTacToeListener?
    
    private var player1Name: String
    
    private var player2Name: String

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(presenter: TicTacToePresentable, player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        self.maxBoardCount = GameConstants.rowCount * GameConstants.colCount
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()

        initBoard()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    // MARK: - TicTacToePresentableListener

    func placeCurrentPlayerMark(atRow row: Int, col: Int) {
        guard board[row][col] == nil else {
            return
        }

        let currentPlayer = getAndFlipCurrentPlayer()
        board[row][col] = currentPlayer
        presenter.setCell(atRow: row, col: col, withPlayerType: currentPlayer)

        if let winner = checkWinner() {
            var playerWinner: Player? = nil
            switch winner {
            case .player1:
                playerWinner = Player(type: winner, name: self.player1Name)
            case .player2:
                playerWinner = Player(type: winner, name: self.player2Name)
            default: break
            }
            presenter.announce(winner: playerWinner) {
                self.listener?.gameDidEnd(withWinner: playerWinner)
            }
        }
        
    }
    
    func showPlugin(id: String) {
        listener?.showPlugin(id: id)
    }

    func closeGame() {
//        listener?.gameDidEnd(withWinner: )
    }

    // MARK: - Private

    private var currentPlayer = PlayerType.player1
    private var board = [[PlayerType?]]()
    private var maxBoardCount: Int

    private func initBoard() {
        for _ in 0..<GameConstants.rowCount {
            board.append([nil, nil, nil])
        }
    }

    private func getAndFlipCurrentPlayer() -> PlayerType {
        let currentPlayer = self.currentPlayer
        self.currentPlayer = currentPlayer == .player1 ? .player2 : .player1
        return currentPlayer
    }

    private func checkWinner() -> PlayerType? {
        // Rows.
        for row in 0..<GameConstants.rowCount {
            guard let assumedWinner = board[row][0] else {
                continue
            }
            var winner: PlayerType? = assumedWinner
            for col in 1..<GameConstants.colCount {
                if assumedWinner.rawValue != board[row][col]?.rawValue {
                    winner = nil
                    break
                }
            }
            if let winner = winner {
                return winner
            }
        }

        // Cols.
        for col in 0..<GameConstants.colCount {
            guard let assumedWinner = board[0][col] else {
                continue
            }
            var winner: PlayerType? = assumedWinner
            for row in 1..<GameConstants.rowCount {
                if assumedWinner.rawValue != board[row][col]?.rawValue {
                    winner = nil
                    break
                }
            }
            if let winner = winner {
                return winner
            }
        }

        // Diagnals.
        guard let p11 = board[1][1] else {
            return nil
        }
        if let p00 = board[0][0], let p22 = board[2][2] {
            if p00.rawValue == p11.rawValue && p11.rawValue == p22.rawValue {
                return p11
            }
        }

        if let p02 = board[0][2], let p20 = board[2][0] {
            if p02.rawValue == p11.rawValue && p11.rawValue == p20.rawValue {
                return p11
            }
        }
        
        // Draws.
        var count: Int = 0
        for row in 0..<GameConstants.rowCount {
            for col in 0..<GameConstants.colCount {
                if (board[row][col] != nil) {
                    count += 1
                }
            }
        }
        
        if (count == maxBoardCount) {
            return .draw
        }

        return nil
    }
}

struct GameConstants {
    static let rowCount = 3
    static let colCount = 3
}
