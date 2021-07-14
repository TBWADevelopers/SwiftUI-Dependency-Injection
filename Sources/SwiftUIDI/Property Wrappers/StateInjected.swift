//
//  StateInjected.swift
//  
//
//  Created by Tom van der Spek on 05/03/2021.
//

import SwiftUI

@propertyWrapper
public class StateInjected<Value>: ObservableObject {
    private let keyPath: KeyPath<DependencyLabel, Value.Type>?
    
    @Published public var wrappedValue: Value
    
    public init(_ keyPath: KeyPath<DependencyLabel, Value.Type>? = nil) {
        self.keyPath = keyPath
        let dependencies = Environment(\.dependencies).wrappedValue
        
        guard let service: Value = dependencies.resolve(for: keyPath) else {
            fatalError("Service \(Value.self) not registered! See logs for more information")
        }
        
        _wrappedValue = Published(initialValue: service)
    }
}
