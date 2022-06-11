//
//  ForecastVC.swift
//  WeatherApp
//
//  Created by Aleksey on 6/7/22.
//

import UIKit

class ForecastVC: UIViewController {
	
	let tableView = UITableView()
	
	var forecast: [ForecastWeatherConditions]? {
		didSet {
			updateUI()
		}
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		configureTableView()
		configure()
    }
	
	
	private func updateUI() {
		print(#function)
		tableView.reloadData()
	}
	
	private func configureTableView() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.register(DayWeatherCell.self, forCellReuseIdentifier: DayWeatherCell.reuseId)
		tableView.rowHeight = 80
		tableView.dataSource = self
	}
	
	
	private func configure() {
		view.backgroundColor = .systemBackground
		view.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}


extension ForecastVC: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return forecast?.count ?? 0
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		guard let forecast = forecast else { return UITableViewCell() }
		let day = forecast[indexPath.row]
		
		let cell = tableView.dequeueReusableCell(withIdentifier: DayWeatherCell.reuseId, for: indexPath) as! DayWeatherCell
		cell.configure(with: day)
		return cell
	}
}
