//
//  Copyright (c) 2018. Uber Technologies
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR COITIONS OF ANY KI, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

// From: https://github.com/uber/needle/issues/176

/// The base builder protocol that all builders should conform to.
public protocol Buildable: AnyObject {}

/// Utility that instantiates a RIB and sets up its internal wirings.
// open class NeedleBuilder<ComponentType>: Buildable, Logging, Analytics {
open class NeedleBuilder<ComponentType>: Buildable {

    // Builder should not directly retain an instance of the component.
    // That would make the component's lifecycle longer than the built
    // RIB. Instead, whenever a new instance of the RIB is built, a new
    // instance of the DI component should also be instantiated.

    // Cannot store the component builder closure in the base class. Swift
    // compiler has a bug where if the closure is stored here, the return
    // value from invoking the closure will be some random object in memory.
    // Some times it's a valid object. Other times it's a bad address.

    /// The logging category of the builder. Defaults to 'Builder'.
    ///
    /// - SeeAlso: Logging
    // public let loggingCategory = "Builder"

    /// The closure to instantiate a new instance of the DI component
    /// that should be paired with this RIB.
    public let componentBuilder: () -> ComponentType

    /// Initializer.
    ///
    /// - parameter componentBuilder: The closure to instantiate a new
    /// instance of the DI component that should be paired with this RIB.
    public init(componentBuilder: @escaping () -> ComponentType) {
        self.componentBuilder = componentBuilder
    }
}