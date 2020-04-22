// Copyright 2020-present, Angel Cortez.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.

import Models
import NeedleFoundation
import RIBs
import UIKit

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent->LoggedInComponent->OffGameComponent") { component in
        return OffGameDependencyd53a6d8de337faf82051Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent->LoggedInComponent->TicTacToeComponent") { component in
        return TicTacToeDependencyc1962481786e7e2d50d7Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent->LoggedOutComponent") { component in
        return LoggedOutDependency615895bced3f6b602f11Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent->LoggedInComponent") { component in
        return LoggedInDependency236aeab04e438dce1453Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent") { component in
        return RootDependency3944cc797a4a88956fb5Provider(component: component)
    }
    
}

// MARK: - Providers

/// ^->AppComponent->RootComponent->LoggedInComponent->OffGameComponent
private class OffGameDependencyd53a6d8de337faf82051Provider: OffGameDependency {
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
/// ^->AppComponent->RootComponent->LoggedInComponent->TicTacToeComponent
private class TicTacToeDependencyc1962481786e7e2d50d7Provider: TicTacToeDependency {
    var player1Name: String {
        return loggedInComponent.player1Name
    }
    var player2Name: String {
        return loggedInComponent.player2Name
    }
    private let loggedInComponent: LoggedInComponent
    init(component: NeedleFoundation.Scope) {
        loggedInComponent = component.parent as! LoggedInComponent
    }
}
/// ^->AppComponent->RootComponent->LoggedOutComponent
private class LoggedOutDependency615895bced3f6b602f11Provider: LoggedOutDependency {
    var mutablePlayersStream: MutablePlayersStream {
        return rootComponent.mutablePlayersStream
    }
    private let rootComponent: RootComponent
    init(component: NeedleFoundation.Scope) {
        rootComponent = component.parent as! RootComponent
    }
}
/// ^->AppComponent->RootComponent->LoggedInComponent
private class LoggedInDependency236aeab04e438dce1453Provider: LoggedInDependency {
    var viewController: LoggedInViewControllable {
        return rootComponent.viewController
    }
    var playersStream: PlayersStream {
        return rootComponent.playersStream
    }
    private let rootComponent: RootComponent
    init(component: NeedleFoundation.Scope) {
        rootComponent = component.parent as! RootComponent
    }
}
/// ^->AppComponent->RootComponent
private class RootDependency3944cc797a4a88956fb5Provider: RootDependency {


    init(component: NeedleFoundation.Scope) {

    }
}
