//
//  Typography.swift
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

@objc public protocol KeyValueObservableTextContainer {
    @objc dynamic var text: String? { get set }
}

public protocol TextPropertiesHolder: AnyObject {
    var paragraphStyle: NSParagraphStyle? { get }
    var textAlignment: NSTextAlignment { get set }
}

public protocol TypographyExtensions: NSObject, KeyValueObservableTextContainer, TextPropertiesHolder {
	
	/// Set the line height (points) on the underlying `NSAttributedString` (with
	/// vertical centering). The provided `lineHeight` value is set to the
	/// `minimumLineHeight` and `maximumLineHeight` property of the `paragraphStyle`
	/// attribute.
	///
	/// If the label has no `attributedText` populated yet, a new one will be created
	/// with the corresponding attributes (otherwise the existing `attributedText`
	/// will be mutated). In order to preserve consistent `baselineOffset` behavior,
	/// the `attributedText` property gets updated whenever the `text` property of
	/// the label changes.
	var lineHeight: CGFloat? { get set }
	
	/// Set the letter spacing (kerning) on the underlying `NSAttributedString`.
	///
	/// If the label has no `attributedText` populated yet, a new one will be created
	/// with the corresponding attributes (otherwise the existing `attributedText`
	/// will be mutated).
	var letterSpacing: CGFloat? { get set }
	
	/// Set the underline style on the underlying `NSAttributedString`.
	///
	/// If the label has no `attributedText` populated yet, a new one will be created
	/// with the corresponding attributes (otherwise the existing `attributedText`
	/// will be mutated).
	var underline: NSUnderlineStyle? { get set }
	
	/// Set the strikethrough style on the underlying `NSAttributedString`.
	///
	/// If the label has no `attributedText` populated yet, a new one will be created
	/// with the corresponding attributes (otherwise the existing `attributedText`
	/// will be mutated).
	var strikethrough: NSUnderlineStyle? { get set }
	
	/// If this value is set to `true`, the label will add a sublayer containing
	/// a typographic grid (updated on `layoutSubviews`).
	var showGrid: Bool { get set }
	
	/// The leading image for the reciever (setter lays out and sets `attributedText`).
	var leadingImage: Typography.Image? { get set }
	
	/// The trailing image for the reciever (setter lays out and sets `attributedText`).
	var trailingImage: Typography.Image? { get set }

    /// Just a wrapper for `UIFont!` or `UIFont?`
    /// Fix for: https://forums.swift.org/t/protocol-conformance-and-implicitly-unwrapped-optionals/12310
    var optionalFont: UIFont? { get set }

    /// Just a wrapper for `NSAttributedString!` or `NSAttributedString?`
    /// Fix for:  https://forums.swift.org/t/protocol-conformance-and-implicitly-unwrapped-optionals/12310
    var optionalAttributedText: NSAttributedString? { get set }
}

extension TypographyExtensions {

    public var paragraphStyle: NSParagraphStyle? {
        getAttribute(.paragraphStyle)
    }

    public var lineHeight: CGFloat? {
        get { paragraphStyle?.maximumLineHeight }
        set {
            let lineHeight = newValue ?? optionalFont!.lineHeight
            let adjustment = lineHeight > optionalFont!.lineHeight ? 2.0 : 1.0
            let baselineOffset = (lineHeight - optionalFont!.lineHeight) / 2.0 / adjustment
            addAttribute(.baselineOffset, value: baselineOffset)
            addAttribute(
                .paragraphStyle,
                value: (paragraphStyle ?? NSParagraphStyle())
                    .mutable
                    .withProperty(lineHeight, for: \.minimumLineHeight)
                    .withProperty(lineHeight, for: \.maximumLineHeight)
            )
            setupAttributeCacheIfNeeded()
        }
    }

    func setupAttributeCacheIfNeeded() {
        onTextChange { [unowned self] oldText, newText in

            // Apply cached attributes (if any) in case text have just changed from empty.
            if oldText.count == 0,
               newText.count > 0,
               let newText = newText {
                let alignment = textAlignment
                self.optionalAttributedText = NSAttributedString(string: newText, attributes: cachedAttributes)
                self.textAlignment = alignment
            }

            // Update attributed string layout due to (unknown) UIKit internals.
            _ = self.optionalAttributedText
        }
    }

    public var letterSpacing: CGFloat? {
        get { getAttribute(.kern) }
        set {
            setAttribute(.kern, value: newValue)
            setupAttributeCacheIfNeeded()
        }
    }

    public var underline: NSUnderlineStyle? {
        get { getAttribute(.underlineStyle) }
        set {
            setAttribute(.underlineStyle, value: newValue)
            setupAttributeCacheIfNeeded()
        }
    }

    public var strikethrough: NSUnderlineStyle? {
        get { getAttribute(.strikethroughStyle) }
        set {
            setAttribute(.strikethroughStyle, value: newValue)
            setupAttributeCacheIfNeeded()
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


// MARK: Attributes (and caching)

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

fileprivate enum Keys {
    static var cache: UInt8 = 0
}

fileprivate extension TypographyExtensions {

    /// An attributed string property to cache typography even when the label text is empty.
    var cache: NSAttributedString {
        get {
            objc_getAssociatedObject(self, &Keys.cache) as? NSAttributedString ?? NSAttributedString(string: "Placeholder")
        }
        set {
            objc_setAssociatedObject(self, &Keys.cache, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    /// Attributes of `attributedText` (if any).
    var attributes: [NSAttributedString.Key: Any]? {
        get {
            if let attributedText = optionalAttributedText,
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
        optionalAttributedText = optionalAttributedText?.stringByAddingAttribute(key, value: value)
        cache = cache.stringByAddingAttribute(key, value: value)
    }

    func removeAttribute(_ key: NSAttributedString.Key) {
        optionalAttributedText = optionalAttributedText?.stringByRemovingAttribute(key)
        cache = cache.stringByRemovingAttribute(key)
    }
}


fileprivate extension TypographyExtensions {

    /// Get attribute for the given key (if any).
    func getAttribute<AttributeType>(
        _ key: NSAttributedString.Key
    ) -> AttributeType? where AttributeType: Any {
        return (attributes ?? cachedAttributes)[key] as? AttributeType
    }

    /// Get `OptionSet` attribute for the given key (if any).
    func getAttribute<AttributeType>(
        _ key: NSAttributedString.Key
    ) -> AttributeType? where AttributeType: OptionSet {
        if let attribute = (attributes ?? cachedAttributes)[key] as? AttributeType.RawValue {
            return .init(rawValue: attribute)
        } else {
            return nil
        }
    }

    /// Add (or remove) attribute for the given key (if any).
    func setAttribute<AttributeType>(
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
     func setAttribute<AttributeType>(
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


// MARK: Paragraph Style

fileprivate extension NSParagraphStyle {

    var mutable: NSMutableParagraphStyle {
        let mutable = NSMutableParagraphStyle()
        mutable.setParagraphStyle(self)
        return mutable
    }
}


fileprivate extension NSMutableParagraphStyle {

    func withProperty<ValueType>(
        _ value: ValueType,
        for keyPath: ReferenceWritableKeyPath<NSMutableParagraphStyle, ValueType>
    ) -> NSMutableParagraphStyle {
        self[keyPath: keyPath] = value
        return self
    }
}

fileprivate extension Optional where Wrapped == String {

    var count: Int {
        switch self {
        case .none:
            return 0
        case .some(let wrapped):
            return wrapped.count
        }
    }
}

public class Typography {
		
	var lineHeight: CGFloat? = nil
	var letterSpacing: CGFloat? = nil
	var underline: NSUnderlineStyle? = nil
	var strikethrough: NSUnderlineStyle? = nil
	var leadingImage: Image? = nil
	var trailingImage: Image? = nil
	
	public struct Image: Equatable {
		
		let image: UIImage
		
		let size: CGSize
		
		public enum Align {
			
			case baseline(_ offset: CGFloat? = nil, _ size: CGSize? = nil)
			case centered(_ offset: CGFloat? = nil, _ size: CGSize? = nil)
			case fitToLineHeight
			case fitToCapHeight
		}
		
		/// Determine the bases of the vertical alignment (centering) of the image
		let align: Align = .baseline()
		
		/// If you set an image taller than the `ascender` of the label font, then
		/// you need to set the lineheight after the setting the image. If the image
		/// height is taller than the `lineheight`, then additional spacing will be
		/// added below the descender line (seemingly).
		init?(image: UIImage?, size: CGSize? = nil) {
			if let image = image {
				self.image = image
				self.size = size ?? image.size
			} else {
				return nil
			}
		}
		
		public static func == (lhs: Typography.Image, rhs: Typography.Image) -> Bool {
			false
		}
	}
	
	func set<ValueType: Equatable>(_ value: ValueType, for keyPath: ReferenceWritableKeyPath<Typography, ValueType>, onChange: () -> Void) {
		if self[keyPath: keyPath] != value {
			self[keyPath: keyPath] = value
			onChange()
		}
	}
}
