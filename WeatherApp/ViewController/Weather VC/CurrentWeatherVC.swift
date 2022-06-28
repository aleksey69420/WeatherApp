//
//  CurrentWeatherVC.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import UIKit

final class CurrentWeatherVC: UIViewController {
	
	let locationLabel = UILabel()
	let temperatureLabel = UILabel()
	let summaryLabel = UILabel()
	let windSpeedLabel = UILabel()
	
	let stackView = UIStackView()
	
	var locationString: String? {
		didSet {
			locationLabel.text = locationString ?? ""
		}
	}
	
	var now: CurrentWeatherConditions? {
		didSet {
			updateUI()
		}
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureUIElements()
		layoutUI()
	}
	
	
	private func updateUI() {
		guard let now = now else { return }
		locationLabel.text = locationString
		temperatureLabel.text = "\(now.temperature)℉"
		summaryLabel.text = now.summary
		windSpeedLabel.text = "\(now.windSpeed) MPH"
	}
	
	private func configureUIElements() {
		view.backgroundColor = .systemBlue
		
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.distribution = .fillProportionally
		
	}
	
	private func layoutUI() {
		view.translatesAutoresizingMaskIntoConstraints = false
		
		locationLabel.translatesAutoresizingMaskIntoConstraints = false
		temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
		summaryLabel.translatesAutoresizingMaskIntoConstraints = false
		windSpeedLabel.translatesAutoresizingMaskIntoConstraints = false
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(stackView)
		
		stackView.addArrangedSubview(locationLabel)
		stackView.addArrangedSubview(temperatureLabel)
		stackView.addArrangedSubview(summaryLabel)
		stackView.addArrangedSubview(windSpeedLabel)
		
		NSLayoutConstraint.activate([
			stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
}
