//
//  Event.swift
//  Machinestalk
//
//  Created by Adel on 2/22/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - WelcomeElement
struct Event: Codable {
    let name: String
    let url: String?
    let startTime, endTime: String
    let  duration, site: String?
    let in24_Hours: In24_Hours?
    let status: Status?

    
    enum CodingKeys: String, CodingKey {
        case name, url
        case startTime = "start_time"
        case endTime = "end_time"
        case duration, site
        case in24_Hours = "in_24_hours"
        case status
    }
    
    
    func getDateIntervalValue()-> String {
        return "From \(startTime.localizedDate()) to \(endTime.localizedDate())"
    }
}

enum In24_Hours: String, Codable {
    case no = "No"
    case yes = "Yes"
}

enum Status: String, Codable {
    case before = "BEFORE"
    case coding = "CODING"
}


typealias Events = [Event]
