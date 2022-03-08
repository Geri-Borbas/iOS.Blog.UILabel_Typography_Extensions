//
//  UIFont+Extensions.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 29/12/2020.
//

import UIKit


extension UIFont {
	
	static func newYork(ofSize size: CGFloat) -> UIFont {
		let font: UIFont
		if let newYork = UIFont.italicSystemFont(ofSize: size).fontDescriptor.withDesign(.serif) {
			font = UIFont(descriptor: newYork, size: size)
		} else {
			font = UIFont.italicSystemFont(ofSize: size)
		}
		return font
	}
}
