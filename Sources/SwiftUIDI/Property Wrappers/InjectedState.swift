//
//  InjectedState.swift
//  
//
//  Created by Tom van der Spek on 05/03/2021.
//

import SwiftUI

@propertyWrapper
public struct InjectedState<Value>: DynamicProperty {
    private let keyPath: KeyPath<DependencyLabel, Value.Type>?
    
    @State public var wrappedValue: Value
    
    public init(_ keyPath: KeyPath<DependencyLabel, Value.Type>? = nil) {
        self.keyPath = keyPath
        let dependencies = Environment(\.dependencies).wrappedValue
        
        guard let service: Value = dependencies.resolve(for: keyPath) else {
            fatalError("Service \(Value.self) not registered! See logs for more information")
        }
        
        _wrappedValue = State(initialValue: service)
    }
}
