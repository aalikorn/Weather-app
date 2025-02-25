//
//  HomeRouter.swift
//  WeatherApp
//
//  Created by Даша Николаева on 25.02.2025.
//

import UIKit

typealias EntryPoint = HomeViewProtocol & UIViewController

protocol HomeRouterProtocol {
    var entry: EntryPoint? { get }
    static func start() -> HomeRouterProtocol
}

class HomeRouter: HomeRouterProtocol {
    var entry: (any EntryPoint)?
    
    static func start() -> HomeRouterProtocol {
        let router = HomeRouter()
        
        var view: HomeViewProtocol = HomeViewController()
        var presenter: HomePresenterProtocol = HomePresenter()
        var interactor: HomeInteractorProtocol = HomeInteractor()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }
}
