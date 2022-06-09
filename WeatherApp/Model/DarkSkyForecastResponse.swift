//
//  ForecastResponse.swift
//  WeatherApp
//
//  Created by Aleksey on 6/8/22.
//

import Foundation

struct DarkSkyForecastResponse: Codable {
	
	struct CurrentConditions: Codable {
		let time: Date
		let summary: String
		let icon: String
		let windSpeed: Double
		let temperature: Double
	}
	
	struct Daily: Codable {
		
		struct DailyConditions: Codable {
			let time: Date
			let icon: String
			let windSpeed: Double
			let temperatureMin: Double
			let temperatureMax: Double
			let summary: String
		}
		
		let data: [DailyConditions]
	}
	
	
	let latitude: Double
	let longitude: Double
	let currently: CurrentConditions
	let daily: Daily
}


extension DarkSkyForecastResponse: WeatherData {
	var current: CurrentWeatherConditions {
		return currently
	}
	
	var forecast: [ForecastWeatherConditions] {
		return daily.data
	}
}

// just formal confirmation because of the same structure
extension DarkSkyForecastResponse.CurrentConditions: CurrentWeatherConditions { }

extension DarkSkyForecastResponse.Daily.DailyConditions: ForecastWeatherConditions { }
