//
//  EventsViewController.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit
import SafariServices

fileprivate let webUrl = "http://www.csaff.org"
class EventsViewController: UITableViewController {

	var events: [EventCellModel] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavbar()
		events = [EventCellModel(image: "csaff", title: "CSAFF 2017: Shorts/Docs at", date: "Sep 29, 2017 11:00 AM", webUrl: webUrl),
		          EventCellModel(image: "csaff", title: "CSAFF 2017: Shorts/Docs at", date: "Sep 29, 2017 12:00 PM", webUrl: webUrl),
		          EventCellModel(image: "csaff", title: "CSAFF 2017: Shorts/Docs at", date: "Sep 29, 2017 1:00 PM", webUrl: webUrl),
		          EventCellModel(image: "csaff", title: "CSAFF 2017: Shorts/Docs at", date: "Sep 29, 2017 2:00 AM", webUrl: webUrl)
		]
    }
	
	fileprivate func configureNavbar() {
		self.navigationItem.title = "CSAFF"
		let textAttributes: [String: Any] = [NSFontAttributeName: UIFont(name: "Avenir-Heavy", size: 18)!,
		                                     NSForegroundColorAttributeName: UIColor.white]
				self.navigationItem.backBarButtonItem?.setTitleTextAttributes(textAttributes, for: .normal)
		self.navigationController?.navigationBar.titleTextAttributes = textAttributes
		self.navigationController?.navigationBar.tintColor = .white

	}

	// MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventsTableCell.identifier, for: indexPath) as! EventsTableCell
		cell.item = events[indexPath.row]
        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		guard let url = URL(string: events[indexPath.row].webUrl) else { return }
		let svc = SFSafariViewController(url: url)
		self.present(svc, animated: true, completion: nil)
	}

}
