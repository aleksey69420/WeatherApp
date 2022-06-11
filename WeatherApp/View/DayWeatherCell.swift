//
//  DayWeatherCell.swift
//  WeatherApp
//
//  Created by Aleksey on 6/10/22.
//

import UIKit

class DayWeatherCell: UITableViewCell {
	
	static let reuseId = String(describing: DayWeatherCell.self)
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	func configure(with day: ForecastWeatherConditions) {
		textLabel?.text = day.summary
	}
	
	
	private func configure() {
		
	}
}
