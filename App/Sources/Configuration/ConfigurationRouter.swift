//
//  ConfigurationRouter.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/28/20.
//

import RIBs

protocol ConfigurationInteractable: Interactable, RootListener, LoggedOutListener, LoggedInListener {
    var router: ConfigurationRouting? { get set }
    var listener: ConfigurationListener? { get set }
}

protocol ConfigurationViewControllable: RootViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class ConfigurationRouter: Router<ConfigurationInteractable>, ConfigurationRouting {
    
    // TODO: Constructor inject child builder protocols to allow building children.
    init(
        interactor: ConfigurationInteractable,
        viewController: ConfigurationViewControllable,
        loggedOutBuilder: LoggedOutBuildable,
        loggedInBuilder: LoggedInBuildable) {
        self.loggedOutBuilder = loggedOutBuilder
        self.loggedInBuilder = loggedInBuilder
        self.viewController = viewController
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
    }
    
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String) {
        // Detach logged out.
        if let loggedOut = self.loggedOut {
            detachChild(loggedOut)
            viewController.dismiss(viewController: loggedOut.viewControllable)
            self.loggedOut = nil
        }
        
        let loggedIn = loggedInBuilder.build(withListener: interactor, player1Name: player1Name, player2Name: player2Name)
        attachChild(loggedIn)
    }
    
    // MARK: - Private
    private let loggedOutBuilder: LoggedOutBuildable
    private let loggedInBuilder: LoggedInBuildable
    private let viewController: ConfigurationViewControllable
    
    private var loggedOut: ViewableRouting?
    
    func routeToLoggedOut() {
        let loggedOut = loggedOutBuilder.build(withListener: interactor)
        self.loggedOut = loggedOut
        attachChild(loggedOut)
        viewController.present(viewController: loggedOut.viewControllable)
    }
    
    func cleanupViews() {
        
    }
}
