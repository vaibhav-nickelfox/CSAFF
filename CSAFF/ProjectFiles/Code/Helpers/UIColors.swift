//
//  UIColors.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit

extension UIColor {
	convenience init(red: Int, green: Int, blue: Int, opacity: CGFloat = 1.0) {
		assert(red >= 0 && red <= 255, "Invalid red component")
		assert(green >= 0 && green <= 255, "Invalid green component")
		assert(blue >= 0 && blue <= 255, "Invalid blue component")
		self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: opacity)
	}
	
	convenience init(hex: Int, alpha: CGFloat = 1.0) {
		self.init(red:(hex >> 16) & 0xff, green:(hex >> 8) & 0xff, blue:hex & 0xff, opacity:alpha)
	}
	
	convenience init(hexString: String) {
		var hexValue: CUnsignedInt = 0
		let scanner = Scanner(string: hexString)
		scanner.scanHexInt32(&hexValue)
		let value = Int(hexValue)
		self.init(red:(value >> 16) & 0xff, green:(value >> 8) & 0xff, blue:value & 0xff)
	}
}
