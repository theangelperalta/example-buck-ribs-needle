//
//  ConfigurationInteractor.swift
//  TicTacToeCore
//
//  Created by Angel Cortez on 4/28/20.
//

import RIBs
import RxSwift
import Foundation
import Models

protocol ConfigurationRouting: Routing {
    func cleanupViews()
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
    func routeToLoggedOut()
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String)
}

protocol ConfigurationListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class ConfigurationInteractor: Interactor, ConfigurationInteractable, UrlHandler {
    
    weak var router: ConfigurationRouting?
    weak var listener: ConfigurationListener?
    
    private let mutablePlayersStream: MutablePlayersStream
    private let mutableConfigurationStream: MutableConfigurationStream
    
    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    init(mutablePlayersStream: MutablePlayersStream, mutableConfigurationStream: MutableConfigurationStream) {
        self.mutablePlayersStream = mutablePlayersStream
        self.mutableConfigurationStream = mutableConfigurationStream
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(Int.random(in: 0 ..< 4))) {
            self.didReceive(configuration:
                [
                    LoggedIn.ribID: [
                        LoggedIn.plugins: [
                            "com.loggedin.plugin.ScoreSheet": [
                                "enabled": Int.random(in: 0 ... 1) > 0 ? true : false,
                                "displayName" : Int.random(in: 0 ... 1) > 0 ? "Leader Board" : "Score Sheet"
                            ]
                        ]
                    ]
                ]
            )
        }
        
    }
    
    override func willResignActive() {
        super.willResignActive()
        
        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    // MARK: - LoggedOutListener
    func didLogin(withPlayer1Name player1Name: String, player2Name: String) {
        mutablePlayersStream.update(player1: player1Name, player2: player2Name)
        router?.routeToLoggedIn(withPlayer1Name: player1Name, player2Name: player2Name)
    }
    
    
    private func didReceive(configuration: [String:Any]) {
        mutableConfigurationStream.publish(configuration: configuration)
        router?.routeToLoggedOut()
    }
    
    // MARK: - UrlHandler
    func handle(_ url: URL) {
        //        let launchGameWorkflow = LaunchGameWorkflow(url: url)
        //        launchGameWorkflow
        //            .subscribe(self)
        //            .disposeOnDeactivate(interactor: self)
    }
    
    // MARK: - RootActionableItem
    //    func waitForLogin() -> Observable<(LoggedInActionableItem, ())> {
    //        return loggedInActionableItemSubject
    //            .map { (loggedInItem: LoggedInActionableItem) -> (LoggedInActionableItem, ()) in
    //                (loggedInItem, ())
    //        }
    //    }
}
