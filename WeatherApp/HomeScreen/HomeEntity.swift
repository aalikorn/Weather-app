//
//  HomeEntity.swift
//  WeatherApp
//
//  Created by Даша Николаева on 25.02.2025.
//

import Foundation

struct HomeWeatherEntity: Codable {
    let current: Current
}

struct Current: Codable {
    let temperature: Int
}


