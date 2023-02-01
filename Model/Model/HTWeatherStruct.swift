//
//  HTWeatherStruct.swift
//  Headache Tracker
//
//  Created by Nehal Jhala.
//

import Foundation

struct Response: Codable {
    var current: Weather
}

struct Weather: Codable {
    var temp: Float
    var humidity: Float
    var uvi: Float
    var wind_speed: Float
}

func convertKelvinToFarenheit(_ temp: Float) -> Float{
    let temp = ((temp - 273.15) * 9.0/5 + 31).rounded()
   return temp
}
