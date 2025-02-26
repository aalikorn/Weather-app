//
//  HomePresenter.swift
//  WeatherApp
//
//  Created by Даша Николаева on 25.02.2025.
//

protocol HomePresenterProtocol {
    var router: HomeRouterProtocol? { get set }
    var interactor: HomeInteractorProtocol? { get set }
    var view: HomeViewProtocol? { get set }
    
    func interactorDidFetchWeatherData(with result: Result<HomeWeatherEntity, Error>)
}

class HomePresenter: HomePresenterProtocol {
    var router: (any HomeRouterProtocol)?
    
    var interactor: (any HomeInteractorProtocol)? {
        didSet {
            interactor?.requestLocation()
        }
    }
    
    var view: (any HomeViewProtocol)?
    
    func interactorDidFetchWeatherData(with result: Result<HomeWeatherEntity, any Error>) {
        switch result {
        case .success(let weatherData):
            view?.updateInfo(temperature: String(weatherData.current.temperature), location: weatherData.location.name)
            
        case .failure:
            view?.showError("Internal error :(")
        }
    }
    
    
}
