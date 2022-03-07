//
//  LineHeightViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 05/01/2021.
//

import UIKit


class LineHeightViewController: UIViewController {
	
	let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
	
	var label: UILabel!
	var sliderObserver: Observer<UISlider, Float>!
		
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			
			UILabel()
				.with {
					$0.textColor = .label
					$0.font = UIFont.newYork(ofSize: 1024 / 26.0 / 2.0)
					$0.lineHeight = 50
					$0.numberOfLines = 0
					$0.showGrid = true
					$0.underline = .single
					self.label = $0
				}
                .with(text: text),
			
			UISlider()
				.with {
					$0.minimumValue = 50
					$0.maximumValue = 100
					$0.addTarget(self, action: #selector(didChangeSlider), for: .valueChanged)
				},
			
			UIView
				.spacer
				.inspect
		)
	
	@objc func didChangeSlider(_ sender: UISlider) {
		label.lineHeight = CGFloat(sender.value)
	}
	
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
