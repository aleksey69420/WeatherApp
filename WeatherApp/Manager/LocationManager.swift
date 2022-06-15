//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Aleksey on 6/13/22.
//

import Foundation
import CoreLocation

protocol LocationService {
	
	typealias fetchLocationHandler = ((Result<Location, LocationServiceError>) -> Void)
	
	func fetchLocation(then handler: @escaping fetchLocationHandler)
}


enum LocationServiceError: Error {
	case notAuthorizedToRequestLocation
}


class LocationManager: NSObject, LocationService {
	
	private lazy var locationManager: CLLocationManager = {
		let locationManager = CLLocationManager()
		
		locationManager.distanceFilter = 1000.0
		locationManager.desiredAccuracy = 1000.0
		
		locationManager.delegate = self
		return locationManager
	}()
	
	// WHY IS THERE? HOW DOES IT WORK?
	// niiiiccce, input paramenters here, don't have to send to vc, closure in the vc
	// why do we need to reset the closure
	private var didFetchLocation: fetchLocationHandler?
	
	
	func fetchLocation(then handler: @escaping fetchLocationHandler) {
		Log.info("Requesting the location")
		
		didFetchLocation = handler
		locationManager.requestLocation() // returns immediately, notification through delegates
	}
	
}


extension LocationManager: CLLocationManagerDelegate {
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		Log.error("Unable to fetch the location")
		//TODO: handle the failed case - alert to the user
	}
	
	
	func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
		Log.info("Getting the location authorization")
		if manager.authorizationStatus == .notDetermined {
			locationManager.requestWhenInUseAuthorization()
		} else if manager.authorizationStatus == .authorizedWhenInUse {
			locationManager.requestLocation()
		} else {
			//presentAlert(of: .notAuthorizedToRequestLocation)
			Log.error("Not authorized to use the device location")
			didFetchLocation?(.failure(.notAuthorizedToRequestLocation))
			
			//reset handler
			didFetchLocation = nil
		}
	}
	
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		guard let location = locations.first else { return }
		
		// fetch the weather data by the location
		didFetchLocation?(.success(Location(location: location)))
		
		//reset handler
		didFetchLocation = nil
	}
}

// define here private to this file, Location doesn't have access to Core Location
fileprivate extension Location {
	
	init(location: CLLocation) {
		latitude = location.coordinate.latitude
		longitude = location.coordinate.longitude
	}
}
