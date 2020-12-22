//
//  Extended.UILabel.swift
//  Label_Extensions
//
//  Created by Geri Borbás on 21/12/2020.
//

import UIKit



extension UILabel {
		
	var lineHeight: CGFloat? {
		get {
			if let lineHeightNumber = lineHeightNumber {
				return CGFloat(lineHeightNumber.floatValue)
			} else {
				return nil
			}
		}
		set {
			if let newValue = newValue {
				lineHeightNumber = NSNumber(value: Float(newValue))
			} else {
				lineHeightNumber = nil
			}
		}
	}
	
	@objc var lineHeightNumber: NSNumber? {
		get { nil }
		set { print("UILabel.lineHeightNumber.set { \(String(describing: newValue)) }") }
	}
	
	/// Make sure to call `UILabel.extend` somewhere.
	static let extend: Void = {
		swizzle()
	}()
	
	fileprivate static func swizzle() {	
		if let originalGetter = class_getInstanceMethod(UILabel.self, #selector(getter: UILabel.lineHeightNumber)),
		   let originalSetter = class_getInstanceMethod(UILabel.self, #selector(setter: UILabel.lineHeightNumber)),
		   let swizzledGetter = class_getInstanceMethod(_UILabel.self, #selector(getter: _UILabel.lineHeightNumber)),
		   let swizzledSetter = class_getInstanceMethod(_UILabel.self, #selector(setter: _UILabel.lineHeightNumber)) {
			method_exchangeImplementations(originalGetter, swizzledGetter)
			method_exchangeImplementations(originalSetter, swizzledSetter)
		}
	}
}

	
fileprivate class _UILabel: UILabel {
		
	// MARK: Properties
	
	@objc override public var lineHeightNumber: NSNumber? {
		get { nil }
		set { print("Swizzled._UILabel.lineHeightNumber.set { \(String(describing: newValue)) }") }
//		didSet {
//			if lineHeight != oldValue {
//				layout()
//			}
//		}
	}
	
	
	// MARK: Overrides
	
	override var text: String? {
		didSet {
			if text != oldValue {
				layout()
			}
		}
	}
	
	override var font: UIFont! {
		didSet {
			if font != oldValue {
				layout()
			}
		}
	}
	
	override var textColor: UIColor! {
		didSet {
			if textColor != oldValue {
				layout()
			}
		}
	}
	
	// open var text: String? // default is nil
	// open var font: UIFont! // default is nil (system font 17 plain)
	// open var textColor: UIColor! // default is labelColor
	
	// open var shadowColor: UIColor? // default is nil (no shadow)
	// open var shadowOffset: CGSize // default is CGSizeMake(0, -1) -- a top shadow
	
	// open var textAlignment: NSTextAlignment // default is NSTextAlignmentNatural (before iOS 9, the default was NSTextAlignmentLeft)
	// open var lineBreakMode: NSLineBreakMode // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text

	// the underlying attributed string drawn by the label, if set, the label ignores the properties above.
	// @NSCopying open var attributedText: NSAttributedString? // default is nil

	// the 'highlight' property is used by subclasses for such things as pressed states. it's useful to make it part of the base class as a user property
	// open var highlightedTextColor: UIColor? // default is nil
	// open var isHighlighted: Bool // default is NO

	// open var isUserInteractionEnabled: Bool // default is NO
	// open var isEnabled: Bool // default is YES. changes how the label is drawn

	// this determines the number of lines to draw and what to do when sizeToFit is called. default value is 1 (single line). A value of 0 means no limit
	// if the height of the text reaches the # of lines or the height of the view is less than the # of lines allowed, the text will be
	// truncated using the line break mode.
	// open var numberOfLines: Int

	// these next 3 properties allow the label to be autosized to fit a certain width by scaling the font size(s) by a scaling factor >= the minimum scaling factor
	// and to specify how the text baseline moves when it needs to shrink the font.
	// open var adjustsFontSizeToFitWidth: Bool // default is NO
	// open var baselineAdjustment: UIBaselineAdjustment // default is UIBaselineAdjustmentAlignBaselines
	// open var minimumScaleFactor: CGFloat // default is 0.0

	// Tightens inter-character spacing in attempt to fit lines wider than the available space if the line break mode is one of the truncation modes before starting to truncate.
	// The maximum amount of tightening performed is determined by the system based on contexts such as font, line width, etc.
	// open var allowsDefaultTighteningForTruncation: Bool // default is NO

	// Specifies the line break strategies that may be used for laying out the text in this label.
	// If this property is not set, the default value is NSLineBreakStrategyStandard.
	// If the label contains an attributed text with paragraph style(s) that specify a set of line break strategies, the set of strategies in the paragraph style(s) will be used instead of the set of strategies defined by this property.
	// open var lineBreakStrategy: NSParagraphStyle.LineBreakStrategy

	// override points. can adjust rect before calling super.
	// label has default content mode of UIViewContentModeRedraw
	// open func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect
	// open func drawText(in rect: CGRect)

	// Support for constraint-based layout (auto layout)
	// If nonzero, this is used when determining -intrinsicContentSize for multiline labels
	// open var preferredMaxLayoutWidth: CGFloat
	
	
	// MARK: Layout
	
	private func layout() {
		
		// Only if any.
		guard let text = text else {
			return attributedText = nil
		}
		
		// Collect attributes.
		var attributes: [NSAttributedString.Key : Any] = [:]
		
		// Inherit font.
		if let font = font {
			attributes[.font] = font
		}
		
		// Inherit color.
		if let textColor = textColor {
			attributes[.foregroundColor] = textColor
		}
		
		// Set line height if any.
		if let lineHeight = lineHeight {
			
			// Align text center vertically relative to the line height.
			let baselineOffsetPoints = (lineHeight - font.lineHeight) / 2.0
			attributes[.baselineOffset] = baselineOffsetPoints / 2.0 // For some reason (?) it needs to be halved
			
			// Paragraph.
			attributes[.paragraphStyle] = NSMutableParagraphStyle().with {
				$0.minimumLineHeight = lineHeight
				$0.maximumLineHeight = lineHeight
				
				// Inherit alignment and line break mode.
				$0.alignment = textAlignment
				$0.lineBreakMode = lineBreakMode
			}
		}
		
		// Set attributed text.
		attributedText = NSAttributedString(
			string: text,
			attributes: attributes
		)
	}
}
