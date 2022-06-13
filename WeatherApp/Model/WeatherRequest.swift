//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import Foundation
//import CoreLocation

struct WeatherRequest {
	
	let baseURL: URL
//	let location: CLLocation
	let location: Location
	
	
	private var latitude: Double {
		return location.latitude
	}
	
	
	private var longitude: Double {
		return location.longitude
	}
	
	var url: URL {
		return baseURL.appendingPathComponent("\(latitude),\(longitude)")
	}
}
