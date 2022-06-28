//
//  DayWeatherCell.swift
//  WeatherApp
//
//  Created by Aleksey on 6/10/22.
//

import UIKit

class DayWeatherCell: UITableViewCell {
	
	static let reuseId = String(describing: DayWeatherCell.self)
	
	let horizonalStack = UIStackView()
	let dayLabel = UILabel()
	let iconImageView = UIImageView()
	let minTemperatureLabel = UILabel()
	let maxTemperatureLabel = UILabel()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		configure()
	}
	
	required init?(coder: NSCoder) { fatalError() }
	
	
	func configure(with day: ForecastWeatherConditions) {
		//textLabel?.text = day.summary
		dayLabel.text = String(day.time.description)
		iconImageView.image = UIImage(systemName: "sun.min")
		minTemperatureLabel.text = String(day.temperatureMin)
		maxTemperatureLabel.text = String(day.temperatureMax)
	}
	
	
	private func configure() {
		contentView.addSubview(horizonalStack)
		horizonalStack.translatesAutoresizingMaskIntoConstraints = false
		horizonalStack.distribution = .fillEqually
		horizonalStack.axis = .horizontal
		horizonalStack.backgroundColor = .systemRed
		
		horizonalStack.addArrangedSubview(dayLabel)
		horizonalStack.addArrangedSubview(iconImageView)
		horizonalStack.addArrangedSubview(minTemperatureLabel)
		horizonalStack.addArrangedSubview(maxTemperatureLabel)
		
		iconImageView.contentMode = .scaleAspectFit
		
		
		NSLayoutConstraint.activate([
			horizonalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
			horizonalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
			horizonalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
			horizonalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
		])
		
	}
}
