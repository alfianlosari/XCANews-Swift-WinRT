//
//  DataFetchPhase.swift
//  DataFetchPhase
//
//  Created by Alfian Losari on 8/29/21.
//

import Foundation

enum DataFetchPhase<T> {
    
    case initial
    case empty
    case fetching
    case success(T)
    case failure(Error)

    var isEmpty: Bool {
        if case .empty = self {
            return true
        }
        return false
    }
    
    var value: T? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }

    var isFetching: Bool {
        if case .fetching = self {
            return true
        }
        return false
    }

    var errorText: String? {
        if case .failure(let error) = self {
            return error.localizedDescription
        }
        return nil
    }
    
}
