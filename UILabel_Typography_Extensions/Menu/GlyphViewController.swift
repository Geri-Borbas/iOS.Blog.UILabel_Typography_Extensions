//
//  GlyphViewController.swift
//  Label_Extensions
//
//  Created by Geri Borbás on 21/12/2020.
//

import UIKit


class GlyphViewController: UIViewController {
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			
//			font.pointSize: 128.0
//			font.capHeight: 90.25
//			font.xHeight: 60.5
//			font.ascender: 121.875
//			font.descender: -30.875
//			font.lineHeight: 152.75
//			font.leading: 0.0
			
			UILabel()
				.with(text: "Glyph")
				.withGlyphStyle
				.with {
					let size = 121.875 + 0
					$0.leadingImage = Typography.Image(
						image: UIImage(named: "Star"),
						size: CGSize(width: size, height: size)
					)
				}
				.with(text: "Typo"),
			
			UILabel()
				.with(text: "Glyph")
				.withGlyphStyle
				.with {
					let height: CGFloat = 121.875 + 5
					let image = UIImage(named: "Star")
					let width: CGFloat = (image?.size.width ?? 0) * height / (image?.size.height ?? 0)
					$0.leadingImage = Typography.Image(
						image: UIImage(named: "Star"),
						size: CGSize(width: width, height: height)
					)
					// TODO: Implement this behaviour in the layout itself
					// $0.lineHeight = CGFloat(size) // $0.font.lineHeight
					$0.lineHeight = $0.font.lineHeight
				}
				.with(text: "Typo"),
			
			UILabel()
				.with(text: "Glyph")
				.withGlyphStyle
				.with {
					// let size = 121.875 + 10
					let size = 152.75 + 10
					// TODO: Implement this behaviour in the layout itself
					$0.lineHeight = CGFloat(size) // $0.font.lineHeight
					$0.leadingImage = Typography.Image(
						image: UIImage(named: "Star"),
						size: CGSize(width: size, height: size)
					)
				}
				.with(text: "Typo"),
			
			UIView
				.spacer
				.inspect
		)
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(body)
		view.backgroundColor = .systemBackground
		body.pin(
			to: view.safeAreaLayoutGuide,
			insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
		)
	}
}


fileprivate extension UILabel {
	
	var withGlyphStyle: Self {
		with {
			$0.textColor = .gray
			$0.backgroundColor = .cyan
			$0.font = UIFont.newYork(ofSize: 128)
			$0.showGrid = true
		}
	}
}
