//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Aleksey on 6/8/22.
//

import Foundation

class NetworkManager {
	
	
	func fetchWeatherData(handler: @escaping (Result<ForecastResponse, Error>) -> Void ) {
		let weatherRequest = WeatherRequest(baseURL: WeatherService.authenticatedURL, location: Defaults.location)
		
		URLSession.shared.dataTask(with: weatherRequest.url) { data, response, error in
			if let response = response as? HTTPURLResponse {
				print(response.statusCode)
			}
			
			guard let data = data, error == nil else {
				print("unable to fetch weather data: \(error!)")
				return handler(.failure(error!))
			}
			
			do {
				let dataResponse = try JSONDecoder().decode(ForecastResponse.self, from: data)
				handler(.success(dataResponse))
			} catch {
				print("invalid response, unable to decode: \(error)")
				handler(.failure(error))
			}
		}.resume()
	}
}
