//
//  NetworkService.swift
//  WeatherApp
//
//  Created by Даша Николаева on 26.02.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkService {
    static let shared = NetworkService()
    private init() {}
    
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
}

