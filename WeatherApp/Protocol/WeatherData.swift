//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Aleksey on 6/8/22.
//

import Foundation

// interface for VCs to interact with the data returned by API

protocol WeatherData {
	
	var latitude: Double { get }
	var longitude: Double { get }
	var current: CurrentWeatherConditions { get }
	var forecast: [ForecastWeatherConditions] { get }
	
}


protocol WeatherConditions {
	var time: Date { get }
	var summary: String { get }
	var icon: String { get }
	var windSpeed: Double { get }
}


protocol CurrentWeatherConditions: WeatherConditions {
	var temperature: Double { get }
}


protocol ForecastWeatherConditions: WeatherConditions {
	var temperatureMin: Double { get }
	var temperatureMax: Double { get }
}
