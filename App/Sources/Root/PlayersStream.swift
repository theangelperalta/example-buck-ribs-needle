// Copyright 2020-present, Angel Cortez.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.

import Foundation
import RxSwift

protocol PlayersStream {
    var names: Observable<(String, String)?> { get }
}

protocol MutablePlayersStream: PlayersStream {
    func update(player1: String?, player2: String?)
}

class PlayersStreamImpl: MutablePlayersStream {

    private let subject = BehaviorSubject<(String, String)?>(value: nil)

    var names: Observable<(String, String)?> {
        return subject.asObservable()
    }

    func update(player1: String?, player2: String?) {
        let player1Name: String
        if let player1 = player1, !player1.isEmpty {
            player1Name = player1
        } else {
            player1Name = "Player 1"
        }
        let player2Name: String
        if let player2 = player2, !player2.isEmpty {
            player2Name = player2
        } else {
            player2Name = "Player 2"
        }
        subject.onNext((player1Name, player2Name))
    }
}
