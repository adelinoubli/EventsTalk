//
//  WeatherProtocol.swift
//  1MinuteMeteo
//
//  Created by Adel on 1/12/23.
//

import Foundation

protocol EventsResultDelegate {
    func didRetrieveResults(result: Events)
    func didFailWithError(error: Error)
}
