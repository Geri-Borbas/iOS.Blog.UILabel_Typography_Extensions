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
import SwiftUI


extension Optional where Wrapped == String {
	
	var count: Int {
		switch self {
		case .none:
			return 0
		case .some(let wrapped):
			return wrapped.count
		}
	}
}


extension UILabel: TypographyExtensions {
		
	var paragraphStyle: NSParagraphStyle? {
		getAttribute(.paragraphStyle)
	}
	
	public var lineHeight: CGFloat? {
		get { paragraphStyle?.maximumLineHeight }
		set {
			let lineHeight = newValue ?? font.lineHeight
			let baselineOffset = (lineHeight - font.lineHeight) / 2.0 / 2.0
			addAttribute(.baselineOffset, value: baselineOffset)
			addAttribute(
				.paragraphStyle,
				value: (paragraphStyle ?? NSParagraphStyle())
					.mutable
					.withProperty(textAlignment, for: \.alignment)
					.withProperty(lineHeight, for: \.minimumLineHeight)
					.withProperty(lineHeight, for: \.maximumLineHeight)
			)
			setupCache()
		}
	}
	
	func setupCache() {
		onTextChange { [unowned self] oldText, newText in
			
			// Apply cached attributes (if any) in case text have just changed from empty.
			if oldText.count == 0,
			   newText.count > 0,
			   let newText = newText {
				self.attributedText = NSAttributedString(string: newText, attributes: cachedAttributes)
			}
			
			// Update attributed string layout due to (unknown) UIKit internals.
			_ = self.attributedText
		}
	}
	
	public var letterSpacing: CGFloat? {
		get { getAttribute(.kern) }
		set {
			setAttribute(.kern, value: newValue)
			setupCache()
		}
	}
	
	public var underline: NSUnderlineStyle? {
		get { getAttribute(.underlineStyle) }
		set {
			setAttribute(.underlineStyle, value: newValue)
			setupCache()
		}
	}
	
	public var strikethrough: NSUnderlineStyle? {
		get { getAttribute(.strikethroughStyle) }
		set {
			setAttribute(.strikethroughStyle, value: newValue)
			setupCache()
		}
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


fileprivate extension NSAttributedString {
	
	var entireRange: NSRange {
		NSRange(location: 0, length: self.length)
	}
	
	func stringByAddingAttribute(_ key: NSAttributedString.Key, value: Any) -> NSAttributedString {
		let changedString = NSMutableAttributedString(attributedString: self)
		changedString.addAttribute(key, value: value, range: self.entireRange)
		return changedString
	}
	
	func stringByRemovingAttribute(_ key: NSAttributedString.Key) -> NSAttributedString {
		let changedString = NSMutableAttributedString(attributedString: self)
		changedString.removeAttribute(key, range: self.entireRange)
		return changedString
	}
}


// MARK: Attributes

fileprivate extension UILabel {
	
	struct Keys {
		static var placeholder: UInt8 = 0
	}
	
	/// An attributed string property to cache typography even when the label text is empty.
	var cache: NSAttributedString {
		get {
			objc_getAssociatedObject(self, &Keys.placeholder) as? NSAttributedString ?? NSAttributedString(string: "Placeholder")
		}
		set {
			objc_setAssociatedObject(self, &Keys.placeholder, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	/// Attributes of `attributedText` (if any).
	var attributes: [NSAttributedString.Key: Any]? {
		get {
			if let attributedText = attributedText,
			   attributedText.length > 0 {
				return attributedText.attributes(at: 0, effectiveRange: nil)
			} else {
				return nil
			}
		}
	}
	
	/// Attributes of `cache`.
	var cachedAttributes: [NSAttributedString.Key: Any] {
		cache.attributes(at: 0, effectiveRange: nil)
	}
	
	func addAttribute(_ key: NSAttributedString.Key, value: Any) {
		attributedText = attributedText?.stringByAddingAttribute(key, value: value)
		cache = cache.stringByAddingAttribute(key, value: value)
	}
	
	func removeAttribute(_ key: NSAttributedString.Key) {
		attributedText = attributedText?.stringByRemovingAttribute(key)
		cache = cache.stringByRemovingAttribute(key)
	}
}


extension UILabel {
	
	/// Get attribute for the given key (if any).
	fileprivate func getAttribute<AttributeType>(
		_ key: NSAttributedString.Key
	) -> AttributeType? where AttributeType: Any {
		return (attributes ?? cachedAttributes)[key] as? AttributeType
	}
	
	/// Get `OptionSet` attribute for the given key (if any).
	fileprivate func getAttribute<AttributeType>(
		_ key: NSAttributedString.Key
	) -> AttributeType? where AttributeType: OptionSet {
		if let attribute = (attributes ?? cachedAttributes)[key] as? AttributeType.RawValue {
			return .init(rawValue: attribute)
		} else {
			return nil
		}
	}
	
	/// Add (or remove) attribute for the given key (if any).
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
	
	/// Add (or remove) `OptionSet` attribute for the given key (if any).
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
}


extension NSParagraphStyle {
	
	var mutable: NSMutableParagraphStyle {
		let mutable = NSMutableParagraphStyle()
		mutable.setParagraphStyle(self)
		return mutable
	}
}


extension NSMutableParagraphStyle {
	
	func withProperty<ValueType>(
		_ value: ValueType,
		for keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, ValueType>
	) -> NSMutableParagraphStyle {
		self[keyPath: keyPath] = value
		return self
	}
}
