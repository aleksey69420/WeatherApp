//
//  ForecastVC.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import UIKit

class ForecastVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = .systemMint
		configure()
    }
	
	
	private func configure() {
		view.translatesAutoresizingMaskIntoConstraints = false
		
	}
}
