//
//  EmptyViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 09/03/2022.
//

import UIKit


class EmptyViewController: UIViewController {
	
	let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
	
	lazy var label = UILabel()
		.with {
			
			// Properties.
			$0.font = UIFont.newYork(ofSize: 1024.0 / 26.0)
			$0.textColor = .text
			$0.layer.compositingFilter = "multiplyBlendMode"
			$0.numberOfLines = 0
			$0.showGrid = true
			$0.lineHeight = CGFloat(87)
			$0.underline = .double
			$0.textAlignment = .center
			
			// Set text after.
			$0.text = loremIpsum
			
		}.inspect

	var models: [(text: String, backgroundColor: UIColor)] = [
		("Lorem ipsum dolor sit amet.", UIColor.systemBlue.withAlphaComponent(0.1)),
		("Consectetur adipiscing elit.", UIColor.systemGreen.withAlphaComponent(0.1)),
		("", UIColor.clear),
		("Sed do eiusmod tempor incididunt ut labore.", UIColor.systemOrange.withAlphaComponent(0.1)),
		("Et dolore magna aliqua.", UIColor.systemIndigo.withAlphaComponent(0.1))
	]
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			label,
			UIButton()
				.with(title: "Change text")
				.onTouchUpInside { [unowned self] in
					if models.isEmpty == false {
						let model = models.removeFirst()
						label.text = model.text
						label.backgroundColor = model.backgroundColor
					}
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
}
