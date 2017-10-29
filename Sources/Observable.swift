//
//  Created by Pavel Sharanda on 11.04.17.
//  Copyright © 2017. All rights reserved.
//

import Foundation

/**
 Building block to chain observables
 */
public final class Observable<T>: ObservableProtocol {
    
    public typealias ValueType = T
    
    private let generator: (@escaping (T) -> Void) -> Disposable
    
    public init(generator: @escaping (@escaping (T) -> Void) -> Disposable) {
        self.generator = generator
    }
    
    @discardableResult
    public func subscribe(_ observer: @escaping (T) -> Void) -> Disposable {
        return generator(observer)
    }
}

extension ObservableProtocol {
    public var asObservable: Observable<ValueType> {
        return Observable { observer in
            return self.subscribe(observer)
        }
    }
}



