//
//  LoggedInNonCoreComponent.swift
//  LoggedInPluginPoint
//
//  Created by Angel Cortez on 4/22/20.
//

import Models
import NeedleFoundation
import ScoreSheet

/// Component for the LoggedIn non core scope.
public class LoggedInNonCoreComponent: NonCoreComponent<EmptyDependency>, ScoreSheetDependency {

    fileprivate var scoreSheetBuilder: ScoreSheetBuilder {
        ScoreSheetBuilder {
            ScoreSheetComponent(dependency: self)
        }
    }

    public var mutableScoreStream: MutableScoreStream {
        return shared { ScoreStreamImpl() }
    }

    public var scoreStream: ScoreStream {
        return mutableScoreStream
    }
    
    public var loggedInPluginFactory: ILoggedInPluginFactory {
        return LoggedInPluginFactory(plugins: [
            scoreSheetBuilder
        ])
    }
}
