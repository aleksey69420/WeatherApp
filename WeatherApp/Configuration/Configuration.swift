//
//  Configuration.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import Foundation


enum Defaults {
	//static let location = Location(latitude: 35.73265, longitude: -78.85029) // apex
	static let location = Location(latitude: 71.706936, longitude: -42.604303000000016) // greenland
}

enum WeatherService {
	private static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
	private static let apiKey = "2c745dcd4c911f5d486945ea8f00899f"
	
	static var authenticatedURL: URL {
		return baseURL.appendingPathComponent(apiKey)
	}
}
