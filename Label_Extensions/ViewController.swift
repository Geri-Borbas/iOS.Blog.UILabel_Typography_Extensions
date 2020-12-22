//
//  ViewController.swift
//  Label_Extensions
//
//  Created by Geri Borbás on 21/12/2020.
//

import UIKit


class ViewController: UIViewController {

	lazy var body = UIStackView()
		.vertical(spacing: 5)
		.withViews(
			UILabel()
				.with(text: "Hello World!")
				.withLargeTitleStyle
				.inspect,
			UILabel()
				.with(text: "Hello World!")
				.withHeadlineStyle
				.inspect,
			UILabel()
				.with(text: "Hello World!")
				.withBodyStyle
				.inspect,
			UILabel()
				.with(text: "Hello World!")
				.withFootnoteStyle
				.inspect,
			UIView
				.spacer
				.inspect
		)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		UILabel.extend
		view.addSubview(body)
		view.backgroundColor = .systemBackground
		body.pin(
			to: view.safeAreaLayoutGuide,
			insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
		)
    }
}


extension UILabel {
	
	var withLargeTitleStyle: Self {
		with {
			$0.textColor = .label
			$0.font = .preferredFont(forTextStyle: .largeTitle)
			$0.lineHeight = 100
		}
	}
	
	var withHeadlineStyle: Self {
		with {
			$0.textColor = .label
			$0.font = .preferredFont(forTextStyle: .headline)
			$0.lineHeight = 100
		}
	}
	
	var withBodyStyle: Self {
		with {
			$0.textColor = .systemGray
			$0.font = .preferredFont(forTextStyle: .body)
			$0.lineHeight = 50
		}
	}
	
	var withFootnoteStyle: Self {
		with {
			$0.textColor = .systemGray
			$0.numberOfLines = 0
			$0.font = .preferredFont(forTextStyle: .footnote)
			$0.lineHeight = 50
		}
	}
}
