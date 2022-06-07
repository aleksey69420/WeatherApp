//
//  CurrentWeatherVC.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import UIKit

final class CurrentWeatherVC: UIViewController {
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .systemBlue
		configure()
	}
	
	
	private func configure() {
		view.translatesAutoresizingMaskIntoConstraints = false
		
	}
}
