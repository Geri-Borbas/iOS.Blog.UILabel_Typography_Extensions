//
//  Extended.UILabel.swift
//  Label_Extensions
//
//  Created by Geri Borbás on 21/12/2020.
//

import UIKit


fileprivate protocol Extensions {
	
	var lineHeight: CGFloat? { get set }
	var letterSpacing: CGFloat? { get set }
	var underline: NSUnderlineStyle? { get set }
	var strikethrough: NSUnderlineStyle? { get set }
	
	/// Call `UILabel.swizzleIfNeeded()` before creating your first label.
	static func swizzleIfNeeded()
}


extension UILabel: Extensions {
	
	fileprivate struct Keys {
		
		static var lineHeight: UInt8 = 0
		static var letterSpacing: UInt8 = 1
		static var underline_: UInt8 = 2
		static var strikethrough: UInt8 = 3
		static var isSwizzled: UInt8 = 4
	}
	
	public var lineHeight: CGFloat? {
		get {
			objc_getAssociatedObject(self, &Keys.lineHeight) as? CGFloat
		}
		set {
			if lineHeight != newValue {
				objc_setAssociatedObject(self, &Keys.lineHeight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
				layout(text: text)
			}
		}
	}
	
	public var letterSpacing: CGFloat? {
		get {
			objc_getAssociatedObject(self, &Keys.letterSpacing) as? CGFloat
		}
		set {
			if letterSpacing != newValue {
				objc_setAssociatedObject(self, &Keys.letterSpacing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
				layout(text: text)
			}
		}
	}
	
	public var underline: NSUnderlineStyle? {
		get {
			objc_getAssociatedObject(self, &Keys.underline_) as? NSUnderlineStyle
		}
		set {
			if underline != newValue {
				objc_setAssociatedObject(self, &Keys.underline_, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
				layout(text: text)
			}
		}
	}
	
	public var strikethrough: NSUnderlineStyle? {
		get {
			objc_getAssociatedObject(self, &Keys.strikethrough) as? NSUnderlineStyle
		}
		set {
			print("strikethrough.set{ \(String(describing: newValue)) }")
			if strikethrough != newValue {
				objc_setAssociatedObject(self, &Keys.strikethrough, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
				layout(text: text)
			}
		}
	}
	
	fileprivate func layout(text: String?) {
		
		// Only if any.
		guard let text = text else {
			return attributedText = nil
		}
		
		// Collect attributes.
		var attributes: [NSAttributedString.Key : Any] = [:]
		
		// Inherit `UILabel.font`.
		if let font = font {
			attributes[.font] = font
		}
		
		// Inherit `UILabel.color`.
		if let textColor = textColor {
			attributes[.foregroundColor] = textColor
		}
		
		// Inherit `UILabel.shadowColor`.
		if let shadowColor = shadowColor {
			let shadow = NSShadow()
			shadow.shadowColor = shadowColor
			shadow.shadowOffset = shadowOffset
			attributes[.shadow] = shadow
		}
		
		// Underline (if any).
		if let underline = underline {
			attributes[.underlineStyle] = underline.rawValue
		}

		// Strikethrough (if any).
		if let strikethrough = strikethrough {
			attributes[.strikethroughStyle] = strikethrough.rawValue
		}
		
		let paragraphStyle = NSMutableParagraphStyle()
		
		// Inherit `UILabel.alignment` and `UILabel.lineBreakMode`.
		paragraphStyle.alignment = textAlignment
		paragraphStyle.lineBreakMode = lineBreakMode
		
		// Set line height (if any).
		if let lineHeight = lineHeight {
			
			// Align text center vertically relative to the line height.
			let baselineOffsetPoints = (lineHeight - font.lineHeight) / 2.0
			attributes[.baselineOffset] = baselineOffsetPoints / 2.0 // For some reason (?) it needs to be halved
			self.baselineAdjustment = .alignCenters
			
			// Paragraph.
			paragraphStyle.minimumLineHeight = lineHeight
			paragraphStyle.maximumLineHeight = lineHeight
		}
		
		// Set paragraph style.
		attributes[.paragraphStyle] = paragraphStyle
		
		// Kerning (if any).
		if let letterSpacing = letterSpacing {
			attributes[.kern] = letterSpacing
		}
		
		// Set attributed text.
		attributedText = NSAttributedString(
			string: text,
			attributes: attributes
		)
	}
}


extension UILabel {
	
	static var isSwizzled: Bool {
		get {
			objc_getAssociatedObject(UILabel.self, &Keys.isSwizzled) as? Bool ?? false
		}
		set {
			objc_setAssociatedObject(UILabel.self, &Keys.isSwizzled, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	static func swizzleIfNeeded() {
		print("\(Self.self).\(#function)")
		if !isSwizzled {
			swizzle()
			isSwizzled = true
		}
	}
	
	static func swizzle() {
		print("\(Self.self).\(#function)")
		swap(#selector(getter: Extension.text), of: Extension.self, to: #selector(getter: UILabel.text), of: UILabel.self)
		swap(#selector(setter: Extension.text), of: Extension.self, to: #selector(setter: UILabel.text), of: UILabel.self)
	}
	
	static func swap(_ originalSelector: Selector, of originalClass: AnyClass, to swizzledSelector: Selector, of swizzledClass: AnyClass) {
		if let originalMethod = class_getInstanceMethod(originalClass, originalSelector),
		   let swizzledMethod = class_getInstanceMethod(swizzledClass, swizzledSelector) {
			method_exchangeImplementations(originalMethod, swizzledMethod)
		}
	}
}


fileprivate class Extension: UILabel {
	
	@objc override var text: String? {
		get {
			attributedText?.string
		}
		set {
			print("UILabel.text.set, newValue: \(String(describing: newValue))")
			layout(text: newValue)
		}
	}
}
