// Copyright 2020-present, Angel Cortez.
// All rights reserved.
//
// This source code is licensed under the license found in the
// LICENSE file in the root directory of this source tree.

import Foundation
import LoggedInPlugin
import LoggedInPluginPoint
import Models
import NeedleFoundation
import RIBs
import ScoreSheet
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
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent") { component in
        return RootDependency3944cc797a4a88956fb5Provider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent->LoggedInComponent->LoggedInNonCoreComponent->ScoreSheetComponent") { component in
        return ScoreSheetDependency3718cb0acf53d0000f6bProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent->LoggedInComponent->LoggedInNonCoreComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->AppComponent->RootComponent->LoggedInComponent") { component in
        return LoggedInDependency236aeab04e438dce1453Provider(component: component)
    }
    __PluginExtensionProviderRegistry.instance.registerPluginExtensionProviderFactory(for: "LoggedInComponent") { component in
        return LoggedInPluginExtensionProvider(component: component)
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
/// ^->AppComponent->RootComponent
private class RootDependency3944cc797a4a88956fb5Provider: RootDependency {


    init(component: NeedleFoundation.Scope) {

    }
}
/// ^->AppComponent->RootComponent->LoggedInComponent->LoggedInNonCoreComponent->ScoreSheetComponent
private class ScoreSheetDependency3718cb0acf53d0000f6bProvider: ScoreSheetDependency {
    var scoreStream: ScoreStream {
        return loggedInNonCoreComponent.scoreStream
    }
    private let loggedInNonCoreComponent: LoggedInNonCoreComponent
    init(component: NeedleFoundation.Scope) {
        loggedInNonCoreComponent = component.parent as! LoggedInNonCoreComponent
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
/// LoggedInComponent plugin extension
private class LoggedInPluginExtensionProvider: LoggedInPluginExtension {
    var loggedInPluginFactory: ILoggedInPluginFactory {
        return loggedInNonCoreComponent.loggedInPluginFactory
    }
    var mutableScoreStream: MutableScoreStream {
        return loggedInNonCoreComponent.mutableScoreStream
    }
    private unowned let loggedInNonCoreComponent: LoggedInNonCoreComponent
    init(component: NeedleFoundation.Scope) {
        let loggedInComponent = component as! LoggedInComponent
        loggedInNonCoreComponent = loggedInComponent.nonCoreComponent as! LoggedInNonCoreComponent
    }
}
