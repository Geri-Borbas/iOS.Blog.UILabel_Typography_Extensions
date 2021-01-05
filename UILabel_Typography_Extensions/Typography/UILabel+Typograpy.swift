//
//  UILabel+Typograpy.swift
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
		get { paragraphStyle?.maximumLineHeight }
		set {
			let lineHeight = newValue ?? font.lineHeight
			let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0
			addAttribute(.baselineOffset, value: baselineOffset)
			setParagraphStyleProperty(lineHeight, for: \.minimumLineHeight)
			setParagraphStyleProperty(lineHeight, for: \.maximumLineHeight)
			observeIfNeeded()
		}
	}
	
	public var letterSpacing: CGFloat? {
		get { getAttribute(.kern) }
		set { setAttribute(.kern, value: newValue) }
	}
	
	public var underline: NSUnderlineStyle? {
		get { getAttribute(.underlineStyle) }
		set { setAttribute(.underlineStyle, value: newValue) }
	}
	
	public var strikethrough: NSUnderlineStyle? {
		get { getAttribute(.strikethroughStyle) }
		set { setAttribute(.strikethroughStyle, value: newValue) }
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


extension UILabel {
	
	// MARK: Get Attributes
	
	fileprivate var attributes: [NSAttributedString.Key : Any]? {
		get {
			if let attributedText = attributedText {
				return attributedText.attributes(at: 0, effectiveRange: nil)
			} else {
				return nil
			}
		}
	}
	
	fileprivate func getAttribute<AttributeType>(
		_ key: NSAttributedString.Key
	) -> AttributeType? where AttributeType: Any {
		print("getAttribute(\(key))")
		return attributes?[key] as? AttributeType
	}
	
	fileprivate func getAttribute<AttributeType>(
		_ key: NSAttributedString.Key
	) -> AttributeType? where AttributeType: OptionSet {
		print("getAttribute(\(key))")
		if let attribute = attributes?[key] as? AttributeType.RawValue {
			return .init(rawValue: attribute)
		} else {
			return nil
		}
	}
	
	// MARK: Set Attributes
	
	fileprivate func setAttribute<AttributeType>(
		_ key: NSAttributedString.Key,
		value: AttributeType?
	) where AttributeType: Any  {
		if let value = value {
			addAttribute(key, value: value)
		} else {
			removeAttribute(key)
		}
	}
	
	fileprivate func setAttribute<AttributeType>(
		_ key: NSAttributedString.Key,
		value: AttributeType?
	) where AttributeType: OptionSet  {
		if let value = value {
			addAttribute(key, value: value.rawValue)
		} else {
			removeAttribute(key)
		}
	}
	
	fileprivate func addAttribute(_ key: NSAttributedString.Key, value: Any) {
		print("addAttribute(\(key), value: \(value)")
		if let attributedText = attributedText {
			let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
			mutableAttributedText.addAttribute(key, value: value, range: attributedText.entireRange)
			self.attributedText = mutableAttributedText
		} else {
			self.attributedText = NSAttributedString(string: text ?? "", attributes: attributes)
		}
	}
	
	fileprivate func removeAttribute(_ key: NSAttributedString.Key) {
		print("removeAttribute(\(key)")
		if let attributedText = attributedText {
			let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
			mutableAttributedText.removeAttribute(key, range: attributedText.entireRange)
			self.attributedText = mutableAttributedText
		}
	}
	
	// MARK: Set Paragraph Style Properties
	
	var paragraphStyle: NSParagraphStyle? {
		getAttribute(.paragraphStyle)
	}
	
	fileprivate func setParagraphStyleProperty<ValueType>(
		_ value: ValueType,
		for keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, ValueType>
	) {
		let mutableParagraphStyle = NSMutableParagraphStyle()
		if let paragraphyStyle = paragraphStyle {
			mutableParagraphStyle.setParagraphStyle(paragraphyStyle)
		}
		mutableParagraphStyle[keyPath: keyPath] = value
		setAttribute(.paragraphStyle, value: mutableParagraphStyle)
	}
}
