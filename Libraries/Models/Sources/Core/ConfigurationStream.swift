//
//  ConfigurationStream.swift
//  Models
//
//  Created by Angel Cortez on 4/30/20.
//

import RxSwift
import RxRelay

public protocol ConfigurationStream {
    var configurations: Observable<[String:Any]> { get }
}


public class MutableConfigurationStream: ConfigurationStream {
    // This eventRelay should be a ReplayRelay, but waiting on for it be released
    private final var configurationRelay: PublishSubject<[String:Any]> = PublishSubject()
    
    public init() {
        configurationRelay.onNext([:])
    }
    
    public func publish(configuration: [String:Any]) {
        configurationRelay.onNext(configuration)
    }
    
    public var configurations: Observable<[String:Any]> {
        return configurationRelay.asObservable()
    }
}
