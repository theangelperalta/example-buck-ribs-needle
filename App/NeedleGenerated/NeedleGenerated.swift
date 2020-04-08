// Copyright 2020-present, Angel Cortez.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.

import MissingNeedleCode
import NeedleFoundation
import RIBs
import UIKit

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->LoggedInComponent->OffGameComponent") { component in
        return OffGameDependency19a483c7a4199f31827fProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->LoggedInComponent->TicTacToeComponent") { component in
        return TicTacToeDependency116f7b2429d569089340Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->LoggedOutComponent") { component in
        return LoggedOutDependencyacada53ea78d270efa2fProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->LoggedInComponent") { component in
        return LoggedInDependency637c07bfce1b5ccf0a6eProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    
}

// MARK: - Providers

/// ^->RootComponent->LoggedInComponent->OffGameComponent
private class OffGameDependency19a483c7a4199f31827fProvider: OffGameDependency {
    var player1Name: String {
        return loggedInComponent.player1Name
    }
    var player2Name: String {
        return loggedInComponent.player2Name
    }
    var scoreStream: ScoreStream {
        return loggedInComponent.scoreStream
    }
    private let loggedInComponent: LoggedInComponent
    init(component: NeedleFoundation.Scope) {
        loggedInComponent = component.parent as! LoggedInComponent
    }
}
/// ^->RootComponent->LoggedInComponent->TicTacToeComponent
private class TicTacToeDependency116f7b2429d569089340Provider: TicTacToeDependency {
    var player1: String {
        return loggedInComponent.player1
    }
    var player2: String {
        return loggedInComponent.player2
    }
    private let loggedInComponent: LoggedInComponent
    init(component: NeedleFoundation.Scope) {
        loggedInComponent = component.parent as! LoggedInComponent
    }
}
/// ^->RootComponent->LoggedOutComponent
private class LoggedOutDependencyacada53ea78d270efa2fProvider: LoggedOutDependency {
    var mutablePlayersStream: MutablePlayersStream {
        return rootComponent.mutablePlayersStream
    }
    private let rootComponent: RootComponent
    init(component: NeedleFoundation.Scope) {
        rootComponent = component.parent as! RootComponent
    }
}
/// ^->RootComponent->LoggedInComponent
private class LoggedInDependency637c07bfce1b5ccf0a6eProvider: LoggedInDependency {
    var loggedInViewController: LoggedInViewControllable {
        return rootComponent.loggedInViewController
    }
    var playersStream: PlayersStream {
        return rootComponent.playersStream
    }
    private let rootComponent: RootComponent
    init(component: NeedleFoundation.Scope) {
        rootComponent = component.parent as! RootComponent
    }
}
