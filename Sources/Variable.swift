//
//  Created by Pavel Sharanda on 15.04.17.
//  Copyright © 2017 Jetpack. All rights reserved.
//

import Foundation

/**
 Wrapper around some state which provides interface to get/set value
 */
public struct Variable<T>: Bindable {
    
    private let setter: (T)->Void
    private let getter: ()->T
    
    public var value: T {
        return getter()
    }
    
    public init(setter: @escaping (T)->Void, getter: @escaping ()->T) {
        self.setter = setter
        self.getter = getter
    }
    
    public func update(_ newValue: T) {
        setter(newValue)
    }
}

extension Variable {
    public var asReceiver: Receiver<ValueType> {
        return Receiver {
            self.update($0)
        }
    }
}