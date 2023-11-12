//
//  DataFetchPhase.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import Foundation

enum DataFetchPhase<V> {
    case empty
    case success(V)
    case failure(Error)

    var value: V? {
        if case .success(let value) = self {
            return value
        }
        return nil
    }
}
