//
//  RootVC.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import UIKit

final class RootVC: UIViewController {
	
	private enum AlertType {
		case noWeatherDataAvailable
	}
	
	
	private let currentWeatherVC = CurrentWeatherVC()
	private let forecastVC = ForecastVC()

	private let networkManager = NetworkManager() // add lazy init when working with location
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setUpChildVCs()
		
		networkManager.fetchWeatherData { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				DispatchQueue.main.async {
					self.currentWeatherVC.now = response.current
					self.forecastVC.forecast = response.forecast
				}
			case .failure(let error):
				print(error.localizedDescription)
				self.presentAlert(of: .noWeatherDataAvailable)
			}
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
			static let height: CGFloat = 300
		}
	}
}
