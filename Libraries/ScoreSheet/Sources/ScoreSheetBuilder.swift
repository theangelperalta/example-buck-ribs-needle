//
//  ScoreSheetBuilder.swift
//  ScoreSheet
//
//  Created by Angel Cortez on 4/21/20.
//

import RIBs

protocol ScoreSheetDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class ScoreSheetComponent: Component<ScoreSheetDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol ScoreSheetBuildable: Buildable {
    func build(withListener listener: ScoreSheetListener) -> ScoreSheetRouting
}

final class ScoreSheetBuilder: Builder<ScoreSheetDependency>, ScoreSheetBuildable {

    override init(dependency: ScoreSheetDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: ScoreSheetListener) -> ScoreSheetRouting {
//        let component = ScoreSheetComponent(dependency: dependency)
        let viewController = ScoreSheetViewController()
        let interactor = ScoreSheetInteractor(presenter: viewController)
        interactor.listener = listener
        return ScoreSheetRouter(interactor: interactor, viewController: viewController)
    }
}
