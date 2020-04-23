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
}

public final class ScoreSheetComponent: Component<ScoreSheetDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ScoreSheetBuildable: LoggedInPluginBuildable {
}

public final class ScoreSheetBuilder: ComponentizedBuilder<ScoreSheetComponent, ScoreSheetRouting, ScoreSheetListener, Void>, ScoreSheetBuildable, ILoggedInPlugin {
    
    private let bundle = Bundle(for: ScoreSheetBuildable.self as! AnyClass)
    
    public var id: String {
        bundle.bundleIdentifier ?? ""
    }
    
    public var builder: LoggedInPluginBuildable {
        self
    }
    
    
    public func build(withListener listener: LoginPluginListener) -> ViewableRouting {
//        let component = ScoreSheetComponent(dependency: dependency)
        let viewController = ScoreSheetViewController()
        let interactor = ScoreSheetInteractor(presenter: viewController)
        interactor.listener = listener
        return ScoreSheetRouter(interactor: interactor, viewController: viewController)
    }
    
    func build(withListener listener: ScoreSheetListener) -> ScoreSheetRouting {
        return build(withDynamicBuildDependency: listener,
        dynamicComponentDependency: ())
    }
}
