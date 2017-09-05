//
//  HomeTableCell.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit

struct HomeCellModel {
	var image: String
	var title: String
}

class HomeTableCell: UITableViewCell {

	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var imgView: ImageView!
	@IBOutlet weak var bgView: UIView!
	
	static let identifier = "HomeTableCell"
	
	var item: HomeCellModel? {
		didSet {
			self.config(item)
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	fileprivate func config(_ item: HomeCellModel?) {
		guard let model = item else { return }
		imgView.setImageFromUrl(urlString: model.image)
		titleLabel.text = model.title
	}

}
