//
//  HomeViewController.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	
	var cellItems: [HomeCellModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavbar()
		setupTableView()
		
		APIRequestManager.fetch { [weak self](response) in
			guard let this = self, let events = response.value?.events  else { return }
			this.cellItems = events.map{
				HomeCellModel(image: $0.imageURL, title: $0.name)
			}
			print(this.cellItems)
			this.tableView.reloadData()
		}
//		cellItems = [HomeCellModel(image: "csaff", title: "Title1"),
//		             HomeCellModel(image: "csaff", title: "Title2"),
//		             HomeCellModel(image: "csaff", title: "Title3"),
//		             HomeCellModel(image: "csaff", title: "Title4")
//		]
	}
	
	fileprivate func configureNavbar() {
		self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "B53F5E")
		self.navigationController?.navigationBar.isTranslucent = false
		UIApplication.shared.statusBarStyle = .lightContent
	}
	
	@IBAction func handleCityTaped(_ sender: UIButton) {
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is SelectCityViewController {
			let vc = segue.destination as! SelectCityViewController
			vc.delegate = self
		}
	}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	fileprivate func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.identifier, for: indexPath) as! HomeTableCell
		cell.item = cellItems[indexPath.row]
		return cell
	}
}

extension HomeViewController: SelectCityDelegate {
	func didSelectCity(_ viewController: SelectCityViewController, _ model: CityModel) {
		print(model.city)
	}
}
