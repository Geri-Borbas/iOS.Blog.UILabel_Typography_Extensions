//
//  LoremIpsumViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 02/01/2021.
//

import UIKit


class LoremIpsumViewController: UIViewController {
	
	let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			
			UILabel()
				.with(text: loremIpsum)
				.with {
					$0.textColor = .label
					$0.font = .preferredFont(forTextStyle: .headline)
					$0.letterSpacing = 1
					$0.lineHeight = 50
				}
				.with {
					$0.textColor = .blue
					$0.numberOfLines = 0
				}
				.with(text: loremIpsum),
			
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
