//
//  UIFont+Extensions.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 29/12/2020.
//

import UIKit


extension UIFont {
	
	static var fonts: String {
		Self.familyNames.map {
			Self.fontNames(forFamilyName: $0).joined(separator: "\n")
		}.joined(separator: "\n")
	}
	
	static func newYork(ofSize size: CGFloat) -> UIFont {
		let font: UIFont
		if let newYork = UIFont.italicSystemFont(ofSize: size).fontDescriptor.withDesign(.serif) {
			font = UIFont(descriptor: newYork, size: size)
		} else {
			font = UIFont.italicSystemFont(ofSize: size)
		}
		return font
	}
	
	static func inspectNewYork() {
		logNewYorkSizes()
	}
	
	static func logNewYorkSizes() {
		(0...1024).forEach {
			let eachFont = newYork(ofSize: CGFloat($0))
			if eachFont.metricsHasFewDecimals {
				eachFont.log()
			}
		}
	}
	
	var metricsHasFewDecimals: Bool {
		max(
			capHeight.decimalPlaces,
			xHeight.decimalPlaces,
			ascender.decimalPlaces,
			descender.decimalPlaces,
			lineHeight.decimalPlaces,
			leading.decimalPlaces
		) < 1
	}
	
	func log() {
		print("font.familyName: \(familyName)")
		print("font.fontName: \(fontName)")
		print("font.pointSize: \(pointSize)")
		print("font.capHeight: \(capHeight)")
		print("font.xHeight: \(xHeight)")
		print("font.ascender: \(ascender)")
		print("font.descender: \(descender)")
		print("font.lineHeight: \(lineHeight)")
		print("font.leading: \(leading)")
	}
}

extension Double {
	
	var decimalPlaces: Int {
		let decimals = String(self).split(separator: ".")[1]
		return decimals == "0" ? 0 : decimals.count
	}
}

extension CGFloat {
	
	var decimalPlaces: Int {
		Double(self).decimalPlaces
	}
}
