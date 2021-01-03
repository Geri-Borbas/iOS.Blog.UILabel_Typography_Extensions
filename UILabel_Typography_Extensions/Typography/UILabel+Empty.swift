//
//  UILabel+Empty.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 02/01/2021.
//

import Foundation
import UIKit


extension UILabel: TypographyExtensions {
	
	public var lineHeight: CGFloat? {
		get { nil }
		set { }
	}
	
	public var letterSpacing: CGFloat? {
		get { nil }
		set { }
	}
	
	public var underline: NSUnderlineStyle? {
		get { nil }
		set { }
	}
	
	public var strikethrough: NSUnderlineStyle? {
		get { nil }
		set { }
	}
	
	public var leadingImage: Typography.Image? {
		get { nil }
		set {  }
	}
	
	public var trailingImage: Typography.Image? {
		get { nil }
		set { }
	}
		
	public var baselineOffset: CGFloat {
		let baselineOffset = (_lineHeight - font.lineHeight) / 2.0
		print("baselineOffset: \(baselineOffset)")
		return baselineOffset
		
	}
}


fileprivate extension UILabel {
	
	
	var paragraphStyle: NSParagraphStyle? {
		attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle
	}
	
	var _lineHeight: CGFloat {
		print("\(Self.self).\(#function)")
		let _lineHeight = paragraphStyle?.maximumLineHeight ?? font.lineHeight
		print("_lineHeight: \(_lineHeight)")
		return _lineHeight
	}
	
}
