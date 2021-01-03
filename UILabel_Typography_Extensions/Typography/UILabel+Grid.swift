//
//  UILabel+Grid.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 02/01/2021.
//

import UIKit



// MARK: - Grid

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
		let baselineOffset = abs(self.baselineOffset)
		var cursor = CGFloat.zero
		cursor += baselineOffset
		while cursor + font.lineHeight - 2 < frame.size.height {
			addGridLayers(offset: cursor)
			cursor += font.lineHeight
			cursor += font.leading
			cursor += baselineOffset
			cursor += baselineOffset
		}
		
		// self.backgroundColor = UIColor.red.withAlphaComponent(0.1)
	}
	
	func addGridLayers(offset: CGFloat) {
		
		// Top down.
		let baseline = font.ascender + offset
		let descender = baseline - font.descender
		let xHeight = baseline - font.xHeight
		let capHeight = baseline - font.capHeight
		let ascender = baseline - font.ascender
		
		let green = UIColor(red: 21.0 / 255.0, green: 170.0 / 255.0, blue: 145.0 / 255.0, alpha: 0.05)
		let gray = UIColor.label.withAlphaComponent(0.05)
		
		add(
			path: rect(from: ascender, to: descender, cornerRadius: 2),
			fill: gray,
			stroke: gray
		)
		add(
			path: rect(from: capHeight, to: baseline, cornerRadius: 2),
			fill: green,
			stroke: green
		)
		add(
			path: line(at: xHeight),
			stroke: gray,
			dash: [2, 2]
		)
	}
	
	func rect(from: CGFloat, to: CGFloat, cornerRadius: CGFloat = 0) -> UIBezierPath {
		let rect = CGRect(x: 0, y: from, width: frame.size.width, height: to - from).insetBy(dx: 0.5, dy: 0.5)
		let cornerRadius = CGSize(width: cornerRadius, height: cornerRadius)
		return UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: cornerRadius)
	}
	
	func line(at: CGFloat) -> UIBezierPath {
		let path = UIBezierPath()
		path.move(to: CGPoint(x: 2, y: at))
		path.addLine(to: CGPoint(x: frame.size.width - 2, y: at))
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
