//
//  DataProvider.swift
//  1MinuteMeteo
//
//  Created by Adel on 1/13/23.
//

import Foundation

class DataProvider: NSObject {
    
    public var baseURL: URL?
    public var scheme: String
    public var path: String
    public var sessionConfiguration: URLSessionConfiguration
    
    // DataProvidable Initializer
    //Easily testable networking logic,
    //eg. use custom url session for unit tests
    public required init(scheme: String?, path: String?, baseURL: URL? = nil, configuration: URLSessionConfiguration) {
        self.baseURL = baseURL?.appendingPathComponent(path ?? "")
        self.scheme = scheme ?? ""
        self.path = path ?? ""
        sessionConfiguration = configuration
    }
    
    func getRequestForPath(withQueryItems items: [URLQueryItem], path: String ) -> URLRequest? {
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = URL_HOST
        components.path = path
        components.queryItems = items
        guard let url = components.url else {return nil}
        return URLRequest(url: url)
    }
}
