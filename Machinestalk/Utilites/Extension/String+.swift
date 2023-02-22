//
//  String+.swift
//  Machinestalk
//
//  Created by Adel on 2/22/23.
//

import Foundation

extension String {
    
    func localizedDate(dateStyle: DateFormatter.Style? = nil) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
}
