//
//  ConfigurationBuilder.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/28/20.
//

import RIBs
import UIKit

// MARK: - Builder

protocol ConfigurationBuildable: Buildable {
    func build(withListener listener: ConfigurationListener) -> (launchRouter: ConfigurationRouting, urlHandler: UrlHandler)
}

final class ConfigurationBuilder: ComponentizedBuilder<ConfigurationComponent, ConfigurationRouting, ConfigurationListener, ([String:Any])>, ConfigurationBuildable {

    func build(withListener listener: ConfigurationListener) -> (launchRouter: ConfigurationRouting, urlHandler: UrlHandler)  {
        let (component, router) = build(withDynamicBuildDependency: listener, dynamicComponentDependency: [:])
        
        return (router, component.interactor)
    }

    override func build(with component: ConfigurationComponent, _ listener: ConfigurationListener) -> ConfigurationRouting {
        
        let loggedOutBuilder = LoggedOutBuilder {
            component.loggedOutComponent
        }
        let loggedInBuilder = LoggedInBuilder { player1Name, player2Name in
            component.loggedInComponent(player1Name: player1Name, player2Name: player2Name)
        }
        
        let router = ConfigurationRouter(interactor: component.interactor,
                                         viewController: component.viewController as! ConfigurationViewControllable,
                                         loggedOutBuilder: loggedOutBuilder,
                                         loggedInBuilder: loggedInBuilder)
        
        return router
    }
    
}
