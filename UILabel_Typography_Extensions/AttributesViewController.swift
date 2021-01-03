//
//  AttributesViewController.swift
//  Label_Extensions
//
//  Created by Geri Borbás on 21/12/2020.
//

import UIKit


class AttributesViewController: UIViewController {
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			
			UILabel()
				.with(text: "Default")
				.with {
					$0.textColor = .label
					$0.font = .preferredFont(forTextStyle: .headline)
					$0.strikethrough = .double
					$0.lineHeight = 100
				}
				.with {
					$0.textColor = .orange
					$0.lineBreakMode = .byTruncatingHead
					$0.showGrid = true
					$0.numberOfLines = 0
					$0.text = "Line Height / Recolored / Strikethrough"
				 }
				.withImages,
			
			UILabel()
				.with(text: "Hello World!")
				.with {
					$0.textColor = .systemGray
					$0.font = .preferredFont(forTextStyle: .body)
					$0.lineHeight = 50
				}
				.with {
					$0.text = "Line Height / Recolored"
					$0.textColor = .green
					$0.showGrid = true
				 }
				.withImages,
			
			UILabel()
				.with(text: "Letter Spacing / Alignment / Line Break Mode")
				.with {
					$0.textColor = .systemGray
					$0.font = .preferredFont(forTextStyle: .body)
					$0.numberOfLines = 0
				}
				.with {
					$0.letterSpacing = 20
					$0.textAlignment = .right
					$0.lineBreakMode = .byTruncatingHead
					$0.showGrid = true
				 }
				.withImages,
			
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
