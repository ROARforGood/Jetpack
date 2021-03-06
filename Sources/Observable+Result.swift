//
//  Created by Pavel Sharanda on 20.09.16.
//  Copyright © 2016. All rights reserved.
//

import Foundation

extension ObservableProtocol where ValueType: ValueConvertible {
    
    public var valueOnly: Observable<ValueType.ValueType> {
        return compactMap { result in
            result.value
        }
    }
}

extension ObservableProtocol where ValueType: ErrorConvertible {
    
    public var errorOnly: Observable<Error> {
        return compactMap { result in
            result.error
        }
    }
}

extension ObservableProtocol where ValueType: ResultConvertible {
    
    var resultOnly: Task<ValueType.ValueType> {
        return compactMap {
            $0.result
        }
    }
}

extension ObservableProtocol where ValueType: ResultConvertible {
    
    public typealias ResultValueType = ValueType.ValueType
    
    public func flatMapLatestValue<U>(_ f: @escaping (ResultValueType)->Task<U>) -> Task<U>  {
        return flatMapLatest { result in
            switch result.result {
            case .success(let value):
                return f(value)
            case .failure(let error):
                return Task.from(error: error)
            }
        }
    }
    
    public func flatMapMergeValue<U>(_ f: @escaping (ResultValueType)->Task<U>) -> Task<U>  {
        return flatMapMerge { result in
            switch result.result {
            case .success(let value):
                return f(value)
            case .failure(let error):
                return Task.from(error: error)
            }
        }
    }
    
    public func mapValue<U>(_ transform: @escaping (ResultValueType)-> U) -> Task<U> {
        return map { $0.result.map(transform) }
    }
    
    public func flatMapValue<U>(_ transform: @escaping (ResultValueType)-> Result<U>) -> Task<U> {
        return compactMap { $0.result.flatMap(transform) }
    }

    /// Transform task success value  to static value
    public func justValue<U>(_ value: U) -> Task<U> {
        return mapValue { _ in value }
    }
    
    /// Transform task success value to void value
    public var justValue: Task<Void> {
        return justValue(())
    }
    
    /// Transform task success value to optional
    public var optionalizedValue: Task<ResultValueType?> {
        return mapValue { Optional.some($0) }
    }
}

extension ObservableProtocol where ValueType: ValueConvertible {
    /// Add handler to perform specific action on each value
    public func forEachValue(_ handler:  @escaping(ResultValueType) -> Void) -> Observable<ValueType> {
        return forEach { result in
            if let value = result.value {
                handler(value)
            }
        }
    }
}

extension ObservableProtocol where ValueType: ErrorConvertible {
    /// Add handler to perform specific action on each error
    public func forEachError(_ handler:  @escaping(Error) -> Void) -> Observable<ValueType> {
        return forEach { result in
            if let error = result.error {
                handler(error)
            }
        }
    }
}




