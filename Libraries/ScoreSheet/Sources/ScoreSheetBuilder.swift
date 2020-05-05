//
//  ScoreSheetBuilder.swift
//  ScoreSheet
//
//  Created by Angel Cortez on 4/21/20.
//

import RIBs
import Models
import LoggedInPlugin
import Foundation


public protocol ScoreSheetDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
    var scoreStream: ScoreStream { get }
    var player1Name: String { get }
    var player2Name: String { get }
}

public final class ScoreSheetComponent: Component<ScoreSheetDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ScoreSheetBuildable: Buildable {
}

public final class ScoreSheetBuilder: ComponentizedBuilder<ScoreSheetComponent, ScoreSheetRouting, LoginPluginListener, Void>, ScoreSheetBuildable, ILoggedInPlugin, LoggedInPluginBuildable {
    
    private let bundle = Bundle(for: ScoreSheetBuilder.self)
    
    public var id: String {
        !BuildConfig.bundleIdentifier.isEmpty ? BuildConfig.bundleIdentifier : "com.tictactoe.core.loggedin.plugin.scoresheet"
    }
    
    public var builder: LoggedInPluginBuildable {
        self
    }
    
    public override func build(with component: ScoreSheetComponent, _ listener: LoginPluginListener) -> ScoreSheetRouting {
        let viewController = ScoreSheetViewController(player1Name: component.dependency.player1Name, player2Name: component.dependency.player2Name)
        let interactor = ScoreSheetInteractor(presenter: viewController, scoreStream: component.dependency.scoreStream)
        interactor.listener = listener
        return ScoreSheetRouter(interactor: interactor, viewController: viewController)
    }
    
    
    
    public func build(withListener listener: LoginPluginListener) -> ViewableRouting {
        return build(withDynamicBuildDependency: listener,
        dynamicComponentDependency: ())
    }
}
