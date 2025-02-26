//
//  HomeInteractor.swift
//  WeatherApp
//
//  Created by Даша Николаева on 25.02.2025.
//

import Foundation

protocol HomeInteractorProtocol {
    var presenter: HomePresenterProtocol? { get set }
    
    func fetchWeatherData(lat: Double, lon: Double)
    func requestLocation()
}

class HomeInteractor: HomeInteractorProtocol {
    var presenter: (any HomePresenterProtocol)?
    
    init() {
        LocationManager.shared.delegate = self
    }
    
    func fetchWeatherData(lat: Double, lon: Double) {
        
        guard let url = URL(string: "https://api.weatherstack.com/current?access_key=498f2fce1088103d8f2a1421c8717217&query=\(lat),\(lon)") else {
            return
        }
        
        print(url)
        
        NetworkService.shared.fetchData(from: url) {[weak self] result in
            switch result {
            case .success(let data):
                do {
                    let entity = try JSONDecoder().decode(HomeWeatherEntity.self, from: data)
                    self?.presenter?.interactorDidFetchWeatherData(with: .success(entity))
                }
                catch {
                    self?.presenter?.interactorDidFetchWeatherData(with: .failure(error))
                }
            case .failure(let error):
                self?.presenter?.interactorDidFetchWeatherData(with: .failure(error))
                return
            }
        }
    
    }
    
    func requestLocation() {
        LocationManager.shared.requestLocation()
    }
}

extension HomeInteractor: LocationManagerDelegate {
    func didUpdateLocation(latitude: Double, longitude: Double) {
        fetchWeatherData(lat: latitude, lon: longitude)
    }
    
    func didFailWithError(error: any Error) {
        fetchWeatherData(lat: 55.76430624, lon: 48.72625452)
    }
    
    
}
