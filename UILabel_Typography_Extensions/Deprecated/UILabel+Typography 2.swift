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

typealias Attributes = [NSAttributedString.Key : Any]

extension UILabel: TypographyExtensions {
	
	public var lineHeight: CGFloat? {
		get { paragraphStyle?.minimumLineHeight }
		set {
			guard let _lineHeight = newValue else {
				// removeAttribute(for: .baselineOffset)
				set(paragraphStyleAttribute: 0, for: \.minimumLineHeight)
				set(paragraphStyleAttribute: 0, for: \.maximumLineHeight)
				return
			}

			let baselineOffset: CGFloat = (_lineHeight - font.lineHeight) / 2.0
			// set(attribute: baselineOffset, for: .baselineOffset)
			set(paragraphStyleAttribute: _lineHeight, for: \.minimumLineHeight)
			set(paragraphStyleAttribute: _lineHeight, for: \.maximumLineHeight)
		}
	}
	
	public var letterSpacing: CGFloat? {
		get { attribute(for: .kern) }
		set { set(attribute: newValue, for: .kern) }
	}
	
	public var underline: NSUnderlineStyle? {
		get { attribute(for: .underlineStyle) }
		set { set(attribute: newValue, for: .underlineStyle) }
	}
	
	public var strikethrough: NSUnderlineStyle? {
		get { attribute(for: .strikethroughStyle) }
		set { set(attribute: newValue, for: .strikethroughStyle) }
	}
	
	public var leadingImage: Typography.Image? {
		get { nil }
		set {  }
	}
	
	public var trailingImage: Typography.Image? {
		get { nil }
		set { }
	}
}


// MARK: - Layout

extension UILabel {
		
	var baselineOffset: CGFloat {
		
		// Align text center vertically relative to the line height (if any).
		if let lineHeight = lineHeight {
			let baselineOffsetPoints = (lineHeight - font.lineHeight) / 2.0
			// let divider: CGFloat = hasImage ? 1.0 : 2.0 // For some reason (?) it needs to be halved (if no image attachment present)
			return baselineOffsetPoints // / divider
		} else {
			return 0
		}
	}
	
	var attributes: [NSAttributedString.Key : Any]? {
		get {
			if let attributedText = attributedText {
				return attributedText.attributes(at: 0, effectiveRange: nil)
			} else {
				return nil
			}
		}
	}
	
	func attribute<AttributeType>(for key: NSAttributedString.Key) -> AttributeType? {
		nil // attributes?[key] as? AttributeType
	}
	
	func set(attribute: Any?, for key: NSAttributedString.Key) {
		if let attribute = attribute {
			set(attribute: attribute, for: key)
		} else {
			removeAttribute(for: key)
		}
	}
	
	func set(attribute: Any, for key: NSAttributedString.Key) {
		print("set(attribute: \(attribute), for: \(key)")
		if let attributedText = attributedText {
			let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
			mutableAttributedText.addAttribute(key, value: attribute, range: NSMakeRange(0, attributedText.length))
			self.attributedText = mutableAttributedText
		} else {
			self.attributedText = NSAttributedString(string: text ?? "", attributes: [key: attribute])
		}
	}
	
	func removeAttribute(for key: NSAttributedString.Key) {
		if let attributedText = attributedText {
			let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
			mutableAttributedText.removeAttribute(key, range: NSMakeRange(0, attributedText.length))
			self.attributedText = mutableAttributedText
		}
	}
	
	var paragraphStyle: NSParagraphStyle? {
		attribute(for: .paragraphStyle)
	}
	
	func set<ValueType>(paragraphStyleAttribute: ValueType, for keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, ValueType>) {
		let mutableParagraphStyle = NSMutableParagraphStyle()
		if let paragraphyStyle = paragraphStyle {
			mutableParagraphStyle.setParagraphStyle(paragraphyStyle)
		}
		mutableParagraphStyle[keyPath: keyPath] = paragraphStyleAttribute
		set(attribute: mutableParagraphStyle, for: .paragraphStyle)
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
