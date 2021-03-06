//
//  RootVC.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import UIKit
import CoreLocation

final class RootVC: UIViewController {
	
	private enum AlertType {
		case noWeatherDataAvailable
		case notAuthorizedToRequestLocation
	}
	
	
	private let currentWeatherVC = CurrentWeatherVC()
	private let forecastVC = ForecastVC()

	private let networkManager = NetworkManager() // add lazy init when working with location
	private let locationService: LocationService
	
	private lazy var geocoder = CLGeocoder()
	var placemark: CLPlacemark?
	
	private var currentLocation: Location? {
		didSet {
			geodecodeCoordinates(currentLocation!)
			networkManager.fetchWeatherData(for: currentLocation!) { [weak self] result in
				guard let self = self else { return }
				switch result {
				case .success(let weatherData):
					self.handleWeatherResponse(weatherData)
				case .failure:
					self.presentAlert(of: .noWeatherDataAvailable)
				}
			}
		}
	}
	
	
	init(locationService: LocationService) {
		self.locationService = locationService
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpChildVCs()
		fetchLocation()
	}
	
	
	private func fetchLocation() {
		
		locationService.fetchLocation { [weak self] result in
			guard let self = self else { return }
			
			switch result {
			case .success(let location):
				self.currentLocation = location
			case .failure(_):
				self.presentAlert(of: .notAuthorizedToRequestLocation)
			}
		}
	}
	
	private func geodecodeCoordinates(_ location: Location) {
		geocoder.reverseGeocodeLocation(CLLocation(latitude: location.latitude, longitude: location.longitude)) { placemarks, error in
			if let error = error {
				Log.error("\(error)")
			}
			
			if let placemarks = placemarks {
				Log.info("found placemarks: \(placemarks)")
				let placemark = placemarks.first
				DispatchQueue.main.async {
					self.currentWeatherVC.locationString = placemark?.locality
				}
			}
		}
	}
	
	
	private func handleWeatherResponse(_ weatherData: WeatherData) {
		DispatchQueue.main.async {
			self.currentWeatherVC.now = weatherData.current
			self.forecastVC.forecast = weatherData.forecast
		}
	}
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
	}
	
	
	private func setUpChildVCs() {
		
		addChild(currentWeatherVC)
		addChild(forecastVC)
		
		view.addSubview(currentWeatherVC.view)
		view.addSubview(forecastVC.view)
		
		NSLayoutConstraint.activate([
			currentWeatherVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			currentWeatherVC.view.topAnchor.constraint(equalTo: view.topAnchor),
			currentWeatherVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			currentWeatherVC.view.heightAnchor.constraint(equalToConstant: Layout.DayView.height),
			
			forecastVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			forecastVC.view.topAnchor.constraint(equalTo: currentWeatherVC.view.bottomAnchor),
			forecastVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			forecastVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		
		currentWeatherVC.didMove(toParent: self)
		forecastVC.didMove(toParent: self)
	}
	
	
	private func presentAlert(of type: AlertType) {
		let title: String
		let message: String
		
		switch type {
		case .noWeatherDataAvailable:
			title = "Unable to fetch weather data"
			message = "The application is unable to fetch weather data. Please make sure that your device is connected to the internet and try again"
		case .notAuthorizedToRequestLocation:
			title = "Unable to fetch your location"
			message = "If you would like to fetch the weather at your current location please update the location settings of the app."
		}
		
		DispatchQueue.main.async {
			let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
			let cancelAction = UIAlertAction(title: "OK", style: .cancel)
			alertController.addAction(cancelAction)
			self.present(alertController, animated: true)
		}
	}
}


// overkill in this case
extension RootVC {
	
	fileprivate enum Layout {
		enum DayView {
			static let height: CGFloat = 200
		}
	}
}
