//
//  URLSession+.swift
//  1MinuteMeteo
//
//  Created by Adel on 1/12/23.
//
import Foundation

extension URLSession {
    func task(with request: URLRequest, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        
    return dataTask(with: request) { (data, response, error) in
        if let error = error {
            result(.failure(error))
            return
        }
        guard let data = data else {return}
        guard let response = response as? HTTPURLResponse, response.statusCode < 206 else {
            let userInfo = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let error = NSError(domain: "error", code: 0, userInfo: userInfo)
            result(.failure(error))
            return
        }
        result(.success((response, data)))
    }
}
}
