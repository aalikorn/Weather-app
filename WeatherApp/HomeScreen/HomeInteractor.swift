//
//  HomeInteractor.swift
//  WeatherApp
//
//  Created by Даша Николаева on 25.02.2025.
//

import Foundation

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func fetchWeatherData()
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: (any HomePresenterProtocol)?
    
    func fetchWeatherData() {
        guard let url = URL(string: "https://api.weatherstack.com/current?access_key=498f2fce1088103d8f2a1421c8717217&query=Moscow") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                self?.presenter?.interactorDidFetchWeatherData(with: .failure(error))
                return
            }
            
            if let data = data {
                do {
                    let entity = try JSONDecoder().decode(HomeWeatherEntity.self, from: data)
                    self?.presenter?.interactorDidFetchWeatherData(with: .success(entity))
                }
                catch {
                    self?.presenter?.interactorDidFetchWeatherData(with: .failure(error))
                }
            }
        }
        
        task.resume()
    }
    
}
