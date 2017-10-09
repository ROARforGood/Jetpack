//
//  Created by Pavel Sharanda on 20.09.16.
//  Copyright © 2016. All rights reserved.
//

import Foundation

public extension ObservableProtocol {
    
    @discardableResult
    public func bind<T: UpdateValueProtocol>(_ bindable: T) -> Disposable where T.UpdateValueType == ValueType {
        return subscribe {result in
            bindable.update(result)
        }
    }
    
    @discardableResult
    public func bind<T: UpdateValueProtocol>(_ bindable: T) -> Disposable where T.UpdateValueType == ValueType? {
        
        return subscribe { result in
            bindable.update(result)
        }
    }
}


