//
//  RootVC.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import UIKit

final class RootVC: UIViewController {
	
	private let currentWeatherVC = CurrentWeatherVC()
	private let forecastVC = ForecastVC()

	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpChildVCs()
		fetchWeatherData()
	}
	
	
	private func fetchWeatherData() {
		let weatherRequest = WeatherRequest(baseURL: WeatherService.authenticatedURL, location: Defaults.location)
		
		URLSession.shared.dataTask(with: weatherRequest.url) { data, response, error in
			if let response = response {
				print(response)
			} else {
				print(error!)
			}
		}.resume()
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
}

// overkill in this case
extension RootVC {
	
	fileprivate enum Layout {
		enum DayView {
			static let height: CGFloat = 300
		}
	}
}
