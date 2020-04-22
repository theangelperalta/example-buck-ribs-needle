// Copyright 2020-present, Angel Cortez.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.

import Foundation
import RxSwift

public protocol PlayersStream {
    var names: Observable<(String, String)?> { get }
}

public protocol MutablePlayersStream: PlayersStream {
    func update(player1: String?, player2: String?)
}

public class PlayersStreamImpl: MutablePlayersStream {
    
    public init() {}

    private let subject = BehaviorSubject<(String, String)?>(value: nil)

    public var names: Observable<(String, String)?> {
        return subject.asObservable()
    }

    public func update(player1: String?, player2: String?) {
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
