//
//  ImageView.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 04/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

public class ImageView: UIImageView {
	
	var downloadImageCompletion: SDWebImageQueryCompletedBlock?
	
	public override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	public func setImageFromUrl(urlString: String, placeHolder: UIImage? = nil, removeExsiting: Bool = false) {
		
		guard let percentEscaped = urlString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed),
			let url = URL(string: percentEscaped) else {
				return
		}
		
		if removeExsiting {
			SDWebImageManager.shared().imageCache.removeImage(forKey: urlString, withCompletion: { [weak self] _ in
				self?.setImageFromUrl(url: url, placeHolder: placeHolder)
			})
		} else {
			self.setImageFromUrl(url: url, placeHolder: placeHolder)
		}
	}
	
	public func setImageFromUrl(url: URL, placeHolder: UIImage? = nil) {
		let options: SDWebImageOptions = [
			.continueInBackground,
			.highPriority,
			.progressiveDownload,
			.refreshCached,
			.retryFailed
		]
		self.image = placeHolder
		
		self.sd_setImage(
			with: url,
			placeholderImage: placeHolder,
			options: options) { [weak self] (image, _, _, _) in
				guard let this = self else { return }
				this.image = image
		}
	}
}
