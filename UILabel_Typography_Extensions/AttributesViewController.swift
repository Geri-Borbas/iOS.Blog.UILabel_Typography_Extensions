//
//  AttributesViewController.swift
//  Label_Extensions
//
//  Created by Geri Borbás on 21/12/2020.
//

import UIKit


class AttributesViewController: UIViewController {
	
	var label_1: UILabel!
	var label_2: UILabel!
	var label_3: UILabel!
	var label_4: UILabel!
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			
			UILabel()
				.with(text: "Default")
				.with {
					$0.textColor = .label
					$0.font = .preferredFont(forTextStyle: .headline)
					$0.underline = .double
					$0.lineHeight = 100
				}
				.with {
					$0.textColor = .orange
					$0.lineBreakMode = .byTruncatingHead
					$0.numberOfLines = 0
					$0.strikethrough = .single
					$0.text = "Line Height / Recolored / Underline"
					$0.showGrid = true
				 }
				.withImages
				.with {
					self.label_1 = $0
				},
			
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
					$0.numberOfLines = 0
					$0.text = "Line Height / Recolored / Strikethrough"
					$0.showGrid = true
				 }
				.withImages
				.with {
					self.label_2 = $0
				},
			
			UILabel()
				.with(text: "Default")
				.with {
					$0.textColor = .systemGray
					$0.font = .preferredFont(forTextStyle: .largeTitle)
					$0.lineHeight = 50
				}
				.with {
					$0.text = "Line Height / Recolored"
					$0.textColor = .systemGreen
					$0.layer.compositingFilter = "multiplyBlendMode"
					$0.showGrid = true
				 }
				.withImages
				.with {
					self.label_3 = $0
				},
			
			UILabel()
				.with(text: "🔠Letter Spacing / Alignment / Line Break Mode")
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
				.withImages
				.with {
					self.label_4 = $0
				},
			
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
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		print("\(label_1.underline)")
		print("\(label_1.strikethrough)")
		
		print("\(label_2.underline)")
		print("\(label_2.strikethrough)")
		
		print("\(label_3.lineHeight)")
		
		print("\(label_4.letterSpacing)")
	}
}
