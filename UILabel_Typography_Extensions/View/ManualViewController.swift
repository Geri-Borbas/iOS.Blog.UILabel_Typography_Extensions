//
//  ManualViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 09/03/2022.
//

import UIKit


class ManualViewController: UIViewController {
		
	lazy var label: UILabel = {
				
		// Properties.
		let label = UILabel()
		label.font = UIFont.newYork(ofSize: 1024.0 / 26.0)
		label.textColor = .text
		label.layer.compositingFilter = "multiplyBlendMode"
		label.numberOfLines = 0
		label.showGrid = true
		
		// Text.
		label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
		
		// Line height.
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.minimumLineHeight = CGFloat(87)
		paragraphStyle.maximumLineHeight = CGFloat(87)
		label.attributedText = NSAttributedString(
			string: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
			attributes: [
				.baselineOffset : 10, // (87 - 47) / 2 / 2
				.paragraphStyle : paragraphStyle
			]
		)
					   
		return label
	}()
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			label,
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

