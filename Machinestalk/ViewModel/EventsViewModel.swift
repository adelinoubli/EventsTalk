//
//  WeatherViewModel.swift
//  1MinuteMeteo
//
//  Created by Adel on 1/13/23.

import Foundation
import Combine
import UIKit
import CoreData

class EventViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var eventsResult: Events = []

    var eventDataProvider: EventDataProvider?
    
    
    init(sessionConfig: URLSessionConfiguration = URLSessionConfiguration.default) {
        eventDataProvider = EventDataProvider(scheme: URL_SCHEME, path: URL_PATH, configuration: sessionConfig)
    }
    
    
    func performRequestFor() {
        let request = eventDataProvider?.getRequestForPath(withQueryItems: [], path: URL_PATH)
            self.eventDataProvider?.execute(request: request!, delegate: self)
    }
    
    func reset() {
        eventsResult.removeAll()
    }
}

extension EventViewModel: EventsResultDelegate {
    
    func didRetrieveResults(result: Events) {
        eventsResult = result
    }
    
    func didFailWithError(error: Error) {
        let nsError = error as NSError
        print(nsError.description)
        }
    }

//  MARK: - Persistent data
extension EventViewModel {
    
    func addToPersistent (event: Event) {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let newEntity = NSEntityDescription.insertNewObject(forEntityName: "LocalEvent", into: managedContext) 
        
        
        newEntity.setValue(event.name, forKey: "name")
        newEntity.setValue(event.startTime, forKey: "startDate")
        newEntity.setValue(event.endTime, forKey: "endDate")
        newEntity.setValue(event.status?.rawValue, forKey: "status")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print ("Could not save. \(error)")
        }
    }
    
    func loadFavoriteData () {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalEvent")
        do {
            let result = try managedContext.fetch(fetchReq)
            
            for data in result as! [NSManagedObject] { 
                let name = data.value(forKey: "name")as! String
                let startTime = data.value(forKey: "startDate") as! String
                let endTime = data.value(forKey: "endDate") as! String
                let statusRawValue = data.value(forKey: "status") as! String
                
                let newEvent = Event(name: name, url: nil, startTime: startTime, endTime: endTime, duration: nil, site: nil, in24_Hours: nil, status: Status(rawValue: statusRawValue))
                self.eventsResult.append(newEvent)
            }
        } catch {
            print("error")
        }
    }
    
}
