//
//  EventsTableCell.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit

struct EventCellModel {
	var image: String
	var title: String
	var date: String
}


class EventsTableCell: UITableViewCell {

	@IBOutlet var titleLabel: UILabel!
	@IBOutlet var dateLabel: UILabel!
	@IBOutlet var imgView: UIImageView!
	
	static let identifier = "EventsTableCell"
	
	var item: EventCellModel? {
		didSet {
			configure(item)
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		decorateImgView()
    }
	
	fileprivate func configure(_ item: EventCellModel?) {
		guard let model = item else { return }
		titleLabel.text = model.title
		dateLabel.text = model.date
		imgView.image = UIImage(named: model.image)
	}

	func decorateImgView() {
		imgView.layer.cornerRadius = imgView.frame.size.width / 2
		imgView.layer.masksToBounds = true
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
