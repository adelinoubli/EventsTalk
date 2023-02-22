//
//  EventDataProvider.swift
//  Machinestalk
//
//  Created by Adel on 2/22/23.
//

import Foundation

class EventDataProvider: DataProvider, Provider {
    func execute(request: URLRequest, delegate: EventsResultDelegate) {
        
        URLSession(configuration: sessionConfiguration).task(with: request) { result in
            switch result {
            case .success((_, let data)):
                if let model = try? JSONDecoder().decode(Events.self, from: data) {
                    delegate.didRetrieveResults(result: model)
                }
                // Handle Data and Response
                break
            case .failure(let error):
                delegate.didFailWithError(error: error)
                break
            }
        }.resume()
    }
}
