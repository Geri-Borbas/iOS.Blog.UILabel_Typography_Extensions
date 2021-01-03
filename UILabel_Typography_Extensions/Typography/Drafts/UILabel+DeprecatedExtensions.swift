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
		static var showGrid: UInt8 = 8
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


// MARK: - Layout

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
	
	fileprivate var baselineOffset: CGFloat {
		
		// Align text center vertically relative to the line height (if any).
		if let lineHeight = lineHeight {
			let baselineOffsetPoints = (lineHeight - font.lineHeight) / 2.0
			let divider: CGFloat = hasImage ? 1.0 : 2.0 // For some reason (?) it needs to be halved (if no image attachment present)
			return baselineOffsetPoints // / divider
		} else {
			return 0
		}
	}
	
	fileprivate func layout(text: String?) {
		
		print("layout(text: \(text)")
		
		// Only if any.
		guard let text = text else {
			return attributedText = nil
		}
		
		// Only if needed.
		guard needsLayout else {
			return
		}
		
		// Observe.
		// observeIfNeeded()
		
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
			attributes[.baselineOffset] = baselineOffset
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
		let attributedString = NSMutableAttributedString()
				
		// Leading image.
		if let leadingImage = leadingImage {
			attributedString.append(leadingImage.attributedString(attributes: attributes))
		}

		// Text.
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
		attachment.bounds = CGRect(origin: .zero,
			size: size)
		
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


// MARK: - Grid

extension UILabel {
	
	public var showGrid: Bool {
		get {
			(objc_getAssociatedObject(self, &Keys.showGrid) as? NSNumber)?.boolValue ?? false
		}
		set {
			objc_setAssociatedObject(self, &Keys.showGrid, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	override open func layoutSubviews() {
		super.layoutSubviews()
		
		if true || showGrid {
			if layer.sublayers?.last?.name != "ascender" {
				addGridLayers()
			}
		} else {
			removeGridLayers()
		}
	}
	
	fileprivate func addGridLayers() {
		
		// Draw until fits.
		var cursor = CGFloat.zero
		cursor += baselineOffset
		while cursor + font.lineHeight - 2 < frame.size.height {
			addGridLayers(offset: cursor)
			cursor += font.lineHeight
			cursor += font.leading
			cursor += baselineOffset
			cursor += baselineOffset
		}
		
		self.backgroundColor = UIColor.red.withAlphaComponent(0.1)
	}
	
	func addGridLayers(offset: CGFloat) {
		
		// Top down.
		let baseline = font.ascender + offset
		let descender = baseline - font.descender
		let xHeight = baseline - font.xHeight
		let capHeight = baseline - font.capHeight
		let ascender = baseline - font.ascender
		
		let blue = UIColor.systemBlue.withAlphaComponent(0.05)
		let gray = UIColor.label.withAlphaComponent(0.05)
		
		add(
			path: rect(from: ascender, to: descender, cornerRadius: 2),
			fill: blue,
			stroke: blue
		)
		add(
			path: rect(from: capHeight, to: baseline),
			fill: gray,
			stroke: gray
		)
		add(
			path: line(at: xHeight),
			stroke: gray,
			dash: [2, 2]
		)
	}
	
	func rect(from: CGFloat, to: CGFloat, cornerRadius: CGFloat = 0) -> UIBezierPath {
		let rect = CGRect(x: 0, y: from, width: frame.size.width, height: to - from)
		let cornerRadius = CGSize(width: cornerRadius, height: cornerRadius)
		return UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: cornerRadius)
	}
	
	func line(at: CGFloat) -> UIBezierPath {
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 0, y: at))
		path.addLine(to: CGPoint(x: frame.size.width, y: at))
		return path
	}
	
	func add(path: UIBezierPath, fill: UIColor? = nil, stroke: UIColor? = nil, dash: [NSNumber]? = nil) {
		let layer = CAShapeLayer()
		layer.path = path.cgPath
		layer.fillColor = fill?.cgColor
		layer.strokeColor = stroke?.cgColor
		layer.lineDashPattern = dash
		layer.lineCap = .round
		layer.compositingFilter = "multiplyBlendMode"
		self.layer.addSublayer(layer)
	}
	
	fileprivate func removeGridLayers() {
		_ = self.layer.sublayers?.map {
			$0.removeFromSuperlayer()
		}
	}
}
