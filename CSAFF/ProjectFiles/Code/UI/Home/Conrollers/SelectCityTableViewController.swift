//
//  SelectCityViewController.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit

struct CityModel {
	var city: String
}

protocol SelectCityDelegate: class {
	func didSelectCity(_ viewController: SelectCityViewController, _ model: CityModel)
}


class SelectCityViewController: UITableViewController {

	var cities: [CityModel] = []
	
	weak var delegate: SelectCityDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavbar()
		cities = [ CityModel(city: "Noida"),
		           CityModel(city: "Mumbai"),
		           CityModel(city: "Gurugram")]
    }

	fileprivate func configureNavbar() {
		
//		for familyName:String in UIFont.familyNames {
//			print("Family Name: \(familyName)")
//			for fontName:String in UIFont.fontNames(forFamilyName: familyName) {
//				print("--Font Name: \(fontName)")
//			}
//		}
		
		self.navigationItem.title = "Select City"
		let textAttributes: [String: Any] = [NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 18)!,
		                                     NSForegroundColorAttributeName: UIColor.white]
//		self.navigationItem.backBarButtonItem?.setTitleTextAttributes(textAttributes, for: .normal)
		self.navigationController?.navigationBar.titleTextAttributes = textAttributes
		self.navigationController?.navigationBar.tintColor = .white
	}
	
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectCityTableCell", for: indexPath)
		cell.textLabel?.text = cities[indexPath.row].city
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.delegate?.didSelectCity(self, cities[indexPath.row])
		self.navigationController?.popViewController(animated: true)
	}
}
