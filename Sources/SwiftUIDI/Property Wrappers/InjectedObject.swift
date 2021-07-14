//
//  InjectedObject.swift
//  
//
//  Created by Vadym on 14.07.2021.
//

import Foundation
import SwiftUI

@propertyWrapper
public struct InjectedObject<Value>: DynamicProperty where Value : ObservableObject {

    private let keyPath: KeyPath<DependencyLabel, Value.Type>?

    @ObservedObject public var wrappedValue: Value
    
    public init(_ keyPath: KeyPath<DependencyLabel, Value.Type>? = nil) {
        self.keyPath = keyPath
        let dependencies = Environment(\.dependencies).wrappedValue
        
        guard let value: Value = dependencies.resolve(for: keyPath) else {
            fatalError("Service \(Value.self) not registered! See logs for more information")
        }
        wrappedValue = value
    }
}
