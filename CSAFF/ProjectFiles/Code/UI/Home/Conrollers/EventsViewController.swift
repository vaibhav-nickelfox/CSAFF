//
//  EventsViewController.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit



class EventsViewController: UITableViewController {

	var events: [EventCellModel] = []
	
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavbar()
		events = [EventCellModel(image: "nav-bar", title: "CSAFF 2017: Shorts/Docs at", date: "Sep 29, 2017 11:00 AM"),
		          EventCellModel(image: "nav-bar", title: "CSAFF 2017: Shorts/Docs at", date: "Sep 29, 2017 12:00 PM"),
		          EventCellModel(image: "nav-bar", title: "CSAFF 2017: Shorts/Docs at", date: "Sep 29, 2017 1:00 PM"),
		          EventCellModel(image: "nav-bar", title: "CSAFF 2017: Shorts/Docs at", date: "Sep 29, 2017 2:00 AM")
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
