//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Aleksey on 6/8/22.
//

import Foundation

enum WeatherDataError: Error {
	case noWeatherDataAvailable
}

class NetworkManager {
	
	
	func fetchWeatherData(for location: Location, handler: @escaping (Result<WeatherData, WeatherDataError>) -> Void ) {
		
		let weatherRequest = WeatherRequest(baseURL: WeatherService.authenticatedURL, location: location)
		
		URLSession.shared.dataTask(with: weatherRequest.url) { data, response, error in
			
			guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
				return handler(.failure(.noWeatherDataAvailable))
			}
			
			
			guard let data = data, error == nil else {
				print("unable to fetch weather data: \(error!)")
				return handler(.failure(.noWeatherDataAvailable))
			}
			
			do {
				let dataResponse = try JSONDecoder().decode(DarkSkyForecastResponse.self, from: data)
				handler(.success(dataResponse))
			} catch {
				print("invalid response, unable to decode: \(error)")
				handler(.failure(.noWeatherDataAvailable))
			}
		}.resume()
	}
}
