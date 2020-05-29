//
//  MultiDelegatesProtocol.swift
//
//  Created by Nick Melnick on 18.02.2019.
//  Copyright © 2019 Nick Melnick. All rights reserved.
//

import Foundation

public struct Weak<T> {
    private weak var _value: AnyObject?
    
    public var value: T? {
        get {
            return _value as? T
        }
        set {
            _value = newValue as AnyObject
        }
    }
    
    public init(value: T) {
        self.value = value
    }
}

protocol MultiDelegates: class {
    
    associatedtype ProtocolType
    
    typealias WeakArray = Array<Weak<ProtocolType>>
    
    var delegates: WeakArray { get set }
    
    func add(delegate: ProtocolType)
    
    func remove(delegate: ProtocolType)
    
}

extension MultiDelegates {

    func add(delegate: ProtocolType) {
        if delegates.compactMap({ $0.value as AnyObject? }).first(where: { $0 === delegate as AnyObject }) == nil {
            delegates.append(Weak(value: delegate))
        }
    }
    
    func remove(delegate: ProtocolType) {
        delegates.removeAll(where: { $0.value as AnyObject? === delegate as AnyObject })
    }

}
