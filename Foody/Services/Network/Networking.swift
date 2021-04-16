//
//  Networking.swift
//  Foody
//
//  Created by Sanjeeb on 14/04/21.
//

import Foundation

public enum Response<T: Any> {
    case object(value: T)
    case error(value: Error)
    
    public func callBlocks(error errorBlock: (Error) -> (), successblock: (T) throws -> ()) {
        do {
            switch self {
            case .error(let value):
                throw value
            case .object(let value):
                try successblock(value)
            }
        } catch {
            errorBlock(error)
        }
    }
}

public typealias ResponseBlock<T: Any> = (Response<T>) -> ()
