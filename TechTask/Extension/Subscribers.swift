//
//  Subscribers.swift
//  TechTask
//
//  Created by Alexandr Bahno on 11.11.2023.
//

import Foundation
import Combine

extension Subscribers.Completion {

    var error: Failure? {
        switch self {
        case .failure(let error):
            print("Error: \(error)")
            return error
        case .finished:
            return nil
        }
    }
}
