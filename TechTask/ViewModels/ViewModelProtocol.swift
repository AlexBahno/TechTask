//
//  ViewModelProtocol.swift
//  TechTask
//
//  Created by Alexandr Bahno on 12.11.2023.
//

import Foundation

protocol ViewModelProtocol: ObservableObject {

    associatedtype T

    var data: T { get }
    func getData()
}
