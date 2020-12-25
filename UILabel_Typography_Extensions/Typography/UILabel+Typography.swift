//
//  UILabel+Typography.swift
//  Label_Extensions
//
//  Copyright © 2020. Geri Borbás. All rights reserved.
//  https://twitter.com/Geri_Borbas
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//


import UIKit


fileprivate protocol Extensions {
	
	var lineHeight: CGFloat? { get set }
	var letterSpacing: CGFloat? { get set }
	var underline: NSUnderlineStyle? { get set }
	var strikethrough: NSUnderlineStyle? { get set }
}


extension UILabel: Extensions {
	
	fileprivate struct Keys {
		
		static var lineHeight: UInt8 = 0
		static var letterSpacing: UInt8 = 1
		static var underline_: UInt8 = 2
		static var strikethrough: UInt8 = 3
		static var observer: UInt8 = 4
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
		
		// Observe.
		observeIfNeeded()
		
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
			
		// Create attributed string.
		let attributedString = NSMutableAttributedString(
			string: text,
			attributes: attributes
		)
		
		// This will be awesome (once I figure out vertical alignment issues) 🖼️
//		let attachment = NSTextAttachment()
//		let image = UIImage(systemName: "map")!.withRenderingMode(.alwaysTemplate)
//		attachment.image = image
//		attributedString.append(NSAttributedString(attachment: attachment))
		
		// Set attributed text.
		attributedText = attributedString
	}
}


extension UILabel {
	
	fileprivate var observer: Observer? {
		get {
			objc_getAssociatedObject(self, &Keys.observer) as? Observer
		}
		set {
			objc_setAssociatedObject(self, &Keys.observer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	fileprivate func observeIfNeeded() {
		guard observer == nil else {
			return
		}
		
		observer = Observer(
			for: self,
			onTextChange: { [weak self] text in
				print("onTextChange { \(String(describing: text)) }")
				self?.layout(text: text)
			}
		)
	}
}


fileprivate class Observer: NSObject {
	
	typealias TextChangeAction = (_ text: String?) -> Void
	let onTextChange: TextChangeAction
	private var observer: NSKeyValueObservation?
	
	init(for label: UILabel, onTextChange: @escaping TextChangeAction) {
		self.onTextChange = onTextChange
		super.init()
		observe(label)
	}
	
	func observe(_ label: UILabel) {
		observer = label.observe(
			\.text,
			options:  [.new, .old],
			changeHandler: { [weak self] _, change in
				self?.onTextChange(change.newValue ?? nil)
			}
		)
	}
	
	deinit {
		print("\(Self.self).\(#function)")
		observer?.invalidate()
	}
}
