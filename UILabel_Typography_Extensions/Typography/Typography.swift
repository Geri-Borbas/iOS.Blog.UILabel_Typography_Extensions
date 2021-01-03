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


public protocol TypographyExtensions {
	
	/// The line height for the reciever (setter lays out and sets `attributedText`).
	var lineHeight: CGFloat? { get set }
	
	/// The letter spacing (kerning) for the reciever (setter lays out and sets `attributedText`).
	var letterSpacing: CGFloat? { get set }
	
	/// The underline style for the reciever (setter lays out and sets `attributedText`).
	var underline: NSUnderlineStyle? { get set }
	
	/// The strikethrough style for the reciever (setter lays out and sets `attributedText`).
	var strikethrough: NSUnderlineStyle? { get set }
	
	/// The leading image for the reciever (setter lays out and sets `attributedText`).
	var leadingImage: Typography.Image? { get set }
	
	/// The trailing image for the reciever (setter lays out and sets `attributedText`).
	var trailingImage: Typography.Image? { get set }
	
	/// Show typographic grid.
	var showGrid: Bool { get set }
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
			
			case baseline
			case centeredRelativeToPointSize
			case centeredRelativeToCapitalSize
			case descender
			case ascender
			case bottom
			case top
		}
		
		/// Determine the bases of the vertical alignment (centering) of the image
		let align: Align = .baseline
		
		
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
