//
//  HomeEntity.swift
//  WeatherApp
//
//  Created by Даша Николаева on 25.02.2025.
//

import Foundation

struct HomeWeatherEntity: Codable {
    let current: Current
    let location: Location
}

struct Current: Codable {
    let temperature: Int
}

struct Location: Codable {
    let name: String
}

