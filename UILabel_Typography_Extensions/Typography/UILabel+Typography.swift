//
//  UILabel+Typography.swift
//  UILabel_Typography_Extensions
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


extension UILabel: TypographyExtensions {
	
	public var lineHeight: CGFloat? {
		get { typography?.lineHeight }
		set { typography?.set(newValue, for: \.lineHeight, onChange: { layout(text: text) }) }
	}
	
	public var letterSpacing: CGFloat? {
		get { typography?.letterSpacing }
		set { typography?.set(newValue, for: \.letterSpacing, onChange: { layout(text: text) }) }
	}
	
	public var underline: NSUnderlineStyle? {
		get { typography?.underline }
		set { typography?.set(newValue, for: \.underline, onChange: { layout(text: text) }) }
	}
	
	public var strikethrough: NSUnderlineStyle? {
		get { typography?.strikethrough }
		set { typography?.set(newValue, for: \.strikethrough, onChange: { layout(text: text) }) }
	}
	
	public var leadingImage: Typography.Image? {
		get { typography?.leadingImage }
		set { typography?.set(newValue, for: \.leadingImage, onChange: { layout(text: text) }) }
	}
	
	public var trailingImage: Typography.Image? {
		get { typography?.trailingImage }
		set { typography?.set(newValue, for: \.trailingImage, onChange: { layout(text: text) }) }
	}
	
	fileprivate struct Keys {
		
		static var typography: UInt8 = 0
		static var observer: UInt8 = 4
	}
	
	fileprivate var _typography: Typography? {
		get { objc_getAssociatedObject(self, &Keys.typography) as? Typography }
		set { objc_setAssociatedObject(self, &Keys.typography, Typography(), .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
	}
	
	fileprivate var typography: Typography? {
		get {
			if _typography == nil {
				_typography = Typography()
			}
			return _typography
		}
	}
}


extension UILabel {
	
	fileprivate var needsLayout: Bool {
		lineHeight != nil ||
		letterSpacing != nil ||
		underline != nil ||
		strikethrough != nil ||
		leadingImage != nil ||
		trailingImage != nil
	}
	
	fileprivate var hasImage: Bool {
		leadingImage != nil ||
		trailingImage != nil
	}
	
	fileprivate func layout(text: String?) {
		
		// Only if any.
		guard let text = text else {
			return attributedText = nil
		}
		
		// Only if needed.
//		guard needsLayout else {
//			return
//		}
		
		print("\n")
		print("layout(text: `\(text)`)")
		
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
		
		// Inherit `UILabel.backgroundColor`.
		if let backgroundColor = backgroundColor {
			attributes[.backgroundColor] = backgroundColor
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
			print("underline: \(underline)))")
			attributes[.underlineStyle] = underline.rawValue
		}

		// Strikethrough (if any).
		if let strikethrough = strikethrough {
			print("strikethrough: \(strikethrough)))")
			attributes[.strikethroughStyle] = strikethrough.rawValue
		}
		
		let paragraphStyle = NSMutableParagraphStyle()
		
		// Inherit `UILabel.alignment` and `UILabel.lineBreakMode`.
		paragraphStyle.alignment = textAlignment
		paragraphStyle.lineBreakMode = lineBreakMode
		
		// Set line height (if any).
		if let lineHeight = lineHeight {
			
			print("lineHeight: \(lineHeight)))")
			
			// Align text center vertically relative to the line height.
			let baselineOffsetPoints = (lineHeight - font.lineHeight) / 2.0
			let divider: CGFloat = hasImage ? 1.0 : 2.0 // For some reason (?) it needs to be halved (if no image attachment present)
			attributes[.baselineOffset] = baselineOffsetPoints / divider
			
			// Paragraph.
			paragraphStyle.minimumLineHeight = lineHeight
			paragraphStyle.maximumLineHeight = lineHeight
		}
		
		// Set paragraph style.
		attributes[.paragraphStyle] = paragraphStyle
		
		// Kerning (if any).
		if let letterSpacing = letterSpacing {
			print("letterSpacing: \(letterSpacing)))")
			attributes[.kern] = letterSpacing
		}
			
		// Create attributed string.
		let attributedString = NSMutableAttributedString()
		
		self.leadingImage = Typography.Image(
			image: UIImage(named: "Star"),
			size: CGSize(width: font.pointSize / 2.0, height: font.pointSize / 2.0)
		)
		self.trailingImage = Typography.Image(
			image: UIImage(named: "Star")!.withRenderingMode(.alwaysTemplate),
			size: CGSize(width: font.capHeight, height: font.capHeight)
		)
				
		// Leading image.
		if let leadingImage = leadingImage {
			attributedString.append(leadingImage.attributedString(attributes: attributes))
		}

		attributedString.append(NSAttributedString(string: text, attributes: attributes))
		
		// Trailing image.
		if let trailingImage = trailingImage {
			attributedString.append(trailingImage.attributedString(attributes: attributes))
		}
		
		// Set attributed text.
		attributedText = attributedString
	}
}


extension Typography.Image {
	
	func attributedString(attributes: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString {
		
		// Attachment.
		let attachment = NSTextAttachment()
		attachment.image = image
		attachment.bounds = CGRect(origin: CGPoint(x: -10, y: 0), size: size)
		
		// Attributes string.
		let attributedString = NSMutableAttributedString(attachment: attachment)
		
		// Inherit from existing attributes (if any).
		var attributes: [NSAttributedString.Key : Any] = attributes ?? [:]
		
		// Align image vertically.
		if let font = attributes[.font] as? UIFont {
			
			// Vertical overlap of the image relative to the capital height of the font.
			let overlap = (size.height - font.capHeight) / 2
			let baselineOffset: CGFloat = attributes[.baselineOffset] as? CGFloat ?? 0
			attributes[.baselineOffset] = baselineOffset - overlap
		}
		
		attributedString.addAttributes(
			attributes,
			range: .init(location: 0, length: attributedString.length)
		)
		
		return attributedString
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
