//
//  UILabel+Grid.swift
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


extension UILabel {
	
	fileprivate struct Keys {
		
		static var showGrid: UInt8 = 0
	}
	
	public var showGrid: Bool {
		get {
			(objc_getAssociatedObject(self, &Keys.showGrid) as? NSNumber)?.boolValue ?? false
		}
		set {
			objc_setAssociatedObject(self, &Keys.showGrid, NSNumber(value: newValue), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	fileprivate static let gridLayerName = "Grid"
	
	fileprivate static let compositingFilter = "multiplyBlendMode"
	
	fileprivate var gridLayer: CALayer? {
		layer.sublayers?.first(where: { $0.name == Self.gridLayerName })
	}
	
	override open func layoutSubviews() {
		super.layoutSubviews()
		removeGridLayerIfNeeded()
		addGridLayerIfNeeded()
	}
	
	fileprivate func addGridLayerIfNeeded() {
		
		// Only if needed.
		guard showGrid else {
			return
		}
		
		// Add.
		let gridLayer = CALayer()
		gridLayer.name = Self.gridLayerName
		gridLayer.compositingFilter = Self.compositingFilter
		layer.addSublayer(gridLayer)
		
		// Draw until fits.
		let baselineOffset = abs(self.baselineOffset)
		var cursor = CGFloat.zero
		cursor += baselineOffset
		while cursor + font.lineHeight - 2 < frame.size.height {
			addGridLayers(to: gridLayer, offset: cursor)
			cursor += font.lineHeight
			cursor += font.leading
			cursor += baselineOffset
			cursor += baselineOffset
		}
	}
	
	fileprivate func removeGridLayerIfNeeded() {
		if let gridLayer = gridLayer {
			gridLayer.removeFromSuperlayer()
		}
	}
	
	fileprivate func addGridLayers(to gridLayer: CALayer, offset: CGFloat) {
		
		// Top down.
		let baseline = font.ascender + offset
		let descender = baseline - font.descender
		let xHeight = baseline - font.xHeight
		let capHeight = baseline - font.capHeight
		let ascender = baseline - font.ascender
		
		let baselineOffset = abs(self.baselineOffset)
		let top = ascender - baselineOffset
		let bottom = descender + baselineOffset

		gridLayer.addSublayer(shape(
			path: rect(from: top, to: bottom, cornerRadius: 2),
			fill: UIColor.gray.withAlphaComponent(0.05),
			stroke: UIColor.gray.withAlphaComponent(0.05)
		))
		gridLayer.addSublayer(shape(
			path: rect(from: ascender, to: descender, cornerRadius: 2),
			fill: UIColor.gray.withAlphaComponent(0.05),
			stroke: UIColor.gray.withAlphaComponent(0.05)
		))
		gridLayer.addSublayer(shape(
			path: rect(from: capHeight, to: baseline, cornerRadius: 2),
			fill: .teal,
			stroke: .teal
		))
		gridLayer.addSublayer(shape(
			path: line(at: xHeight),
			stroke: .teal,
			dash: [2, 2]
		))
	}
	
	fileprivate func rect(from: CGFloat, to: CGFloat, cornerRadius: CGFloat = 0) -> UIBezierPath {
		let rect = CGRect(x: 0, y: from, width: frame.size.width, height: to - from) // .insetBy(dx: 0.5, dy: 0.5)
		let cornerRadius = CGSize(width: cornerRadius, height: cornerRadius)
		return UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: cornerRadius)
	}
	
	fileprivate func line(at: CGFloat) -> UIBezierPath {
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 2, y: at))
		path.addLine(to: CGPoint(x: frame.size.width - 2, y: at))
		return path
	}
	
	fileprivate func shape(path: UIBezierPath, fill: UIColor? = nil, stroke: UIColor? = nil, dash: [NSNumber]? = nil) -> CAShapeLayer {
		let layer = CAShapeLayer()
		layer.path = path.cgPath
		layer.fillColor = fill?.cgColor
		layer.strokeColor = stroke?.cgColor
		layer.lineDashPattern = dash
		layer.lineCap = .round
		layer.compositingFilter = Self.compositingFilter
		return layer
	}
}


fileprivate extension UILabel {
	
	var paragraphStyle: NSParagraphStyle? {
		attributedText?.attribute(NSAttributedString.Key.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle
	}
	
	var baselineOffset: CGFloat {
		guard let lineHeight = paragraphStyle?.maximumLineHeight,
			  lineHeight != 0.0 else {
			return 0.0
		}
		return (lineHeight - font.lineHeight) / 2.0
	}
}
