//
//  HomeView.swift
//  WeatherApp
//
//  Created by Даша Николаева on 25.02.2025.
//

import UIKit

protocol HomeViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    func updateTemperature(_ temperature: String)
    func showError(_ message: String)
}

class HomeViewController: UIViewController, HomeViewProtocol {
    var presenter: (any HomePresenterProtocol)?
    
    private let infoView = UIView()
    private let errorView = UIView()
    private let temperatureLabel = UILabel()
    private let errorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        infoView.frame = view.bounds
        errorView.frame = view.bounds
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        temperatureLabel.textColor = .black
        temperatureLabel.font = .systemFont(ofSize: 70, weight: .bold)
        temperatureLabel.textAlignment = .center
        infoView.addSubview(temperatureLabel)
        
        errorLabel.font = .systemFont(ofSize: 20, weight: .regular)
        errorLabel.textColor = .black
        errorLabel.textAlignment = .center
        errorLabel.numberOfLines = 0
        errorView.addSubview(errorLabel)
        
        infoView.isHidden = true
        errorView.isHidden = true
        view.addSubview(infoView)
        view.addSubview(errorView)
    }
    
    private func setupConstraints() {
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.centerXAnchor.constraint(equalTo: infoView.centerXAnchor),
            temperatureLabel.centerYAnchor.constraint(equalTo: infoView.centerYAnchor, constant: -100)
        ])
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: errorView.centerYAnchor),
            errorLabel.widthAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func updateTemperature(_ temperature: String) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = temperature
            self.errorView.isHidden = true
            self.infoView.isHidden = false
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            self.errorLabel.text = message
            self.infoView.isHidden = true
            self.errorView.isHidden = false
        }
        
    }
}
