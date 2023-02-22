//
//  Provider.swift
//  Machinestalk
//
//  Created by Adel on 2/22/23.
//

import Foundation
protocol Provider {
    associatedtype DelegateType
    func execute(request: URLRequest, delegate: DelegateType)
}

extension Provider {
    func execute(request: URLRequest, delegate: DelegateType) {}
}
