//
//  HomeViewController.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavbar()
	}
	
//	override var preferredStatusBarStyle: UIStatusBarStyle {
//		return UIStatusBarStyle.lightContent
//	}
	
	fileprivate func configureNavbar() {
		decorateNavbar()
		let leftItem = UIBarButtonItem(title: "Festivals", style: .plain, target: nil, action: nil)
		leftItem.tintColor = UIColor.white
//		leftItem.isEnabled = false
		//self.navigationItem.leftBarButtonItem = leftItem
	}
	
	fileprivate func decorateNavbar() {
		self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "B53F5E")
		self.navigationController?.navigationBar.isTranslucent = false
		UIApplication.shared.statusBarStyle = .lightContent
	}
}
