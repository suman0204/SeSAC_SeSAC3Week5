//
//  Weather.swift
//  SeSAC3Week5
//
//  Created by 홍수만 on 2023/08/17.
//

import Foundation

// MARK: - Weather
struct WeatherData: Codable {
    let timezone: Int
    let sys: Sys
    let dt: Int
    let weather: [Weather]
    let main: Main
    let id: Int
    let coord: Coord
    let name: String
    let visibility: Int
    let base: String
    let wind: Wind
    let cod: Int
    let clouds: Clouds
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let humidity: Int
    let tempMin, tempMax: Double
    let grndLevel, pressure: Int
    let feelsLike: Double
    let seaLevel: Int
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case grndLevel = "grnd_level"
        case pressure
        case feelsLike = "feels_like"
        case seaLevel = "sea_level"
        case temp
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise, sunset, type, id: Int
    let country: String
}

// MARK: - WeatherElement
struct Weather: Codable {
    let main, icon: String
    let id: Int
    let description: String
}

// MARK: - Wind
struct Wind: Codable {
    let deg: Int
    let speed, gust: Double
}
