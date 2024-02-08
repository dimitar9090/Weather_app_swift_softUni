//
//  Weather.swift
//  SoftUniWeatherApp
//
//  Created by Ivan Chavdarov Ivanov on 23.01.24.
//

import Foundation

// MARK: - Weather
struct Weather: Codable {
    let location: Location
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let lastUpdated: String
    let tempC: Double
    let condition: Condition
    let humidity: Int
    let feelslikeC: Double
    let uv: Int
    
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case condition
        case humidity
        case feelslikeC = "feelslike_c"
        case uv
    }
}

// MARK: - Condition
struct Condition: Codable {
    let text: String
    let icon: String
    let code: Int
}

// MARK: - Location
struct Location: Codable {
    let name: String
}
