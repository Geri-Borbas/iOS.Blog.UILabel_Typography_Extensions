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
		.views(
			UILabel().with {
				$0.text = "Hello World!"
				$0.textColor = .label
				$0.font = .preferredFont(forTextStyle: .largeTitle)
				$0.underline = .double
				$0.lineHeight = 100
				$0.letterSpacing = -2
			}.with {
				$0.text = "Hello Saturn!"
				$0.tag = 3
			}.inspect,
			UILabel()
				.with(text: "Hello World!")
				.withHeadlineStyle
				.with {
					$0.textColor = .red
					$0.strikethrough = .single
					$0.text = "Hello Mars!"
					$0.textColor = .orange
				 }
				.inspect,
			UILabel()
				.with(text: "Hello World!")
				.withBodyStyle
				.with {
					$0.textColor = .green
				 }
				.inspect,
			UILabel()
				.with(text: "Hello World!")
				.withFootnoteStyle
				.with {
					$0.letterSpacing = 20
					$0.textAlignment = .right
					$0.lineBreakMode = .byTruncatingHead
				 }
				.inspect,
			UIButton()
				.with {
					$0.setTitle("Press me", for: .normal)
					$0.setTitleColor(.label, for: .normal)
					$0.addTarget(self, action: #selector(didTap), for: .touchUpInside)
				},
			UIView
				.spacer
				.inspect
		)
	
	@objc func didTap() {
		self.present(UIViewController().with {
			let body = UIStackView()
				.vertical(spacing: 5)
				.views(
					UILabel().with {
						$0.text = "Hello World!"
						$0.textColor = .label
						$0.font = .preferredFont(forTextStyle: .largeTitle)
						$0.lineHeight = 40
						$0.letterSpacing = 20
					}.with {
						$0.text = "Hello Saturn!"
						$0.tag = 3
					}.inspect,
					UILabel()
						.with(text: "Hello World!")
						.withHeadlineStyle
						.with {
							$0.textColor = .blue
						}
						.inspect,
					UILabel()
						.with(text: "Hello World!")
						.withBodyStyle
						.with {
							$0.textAlignment = .center
							$0.lineBreakMode = .byTruncatingHead
							$0.text = "Hello Saturn!"
						}
						.inspect,
					UILabel()
						.with(text: "Hello World!")
						.withFootnoteStyle
						.with {
							$0.letterSpacing = 20
							$0.textAlignment = .right
							$0.lineBreakMode = .byTruncatingHead
							$0.text = "Hello Saturn!"
						}
						.inspect,
					UIView
						.spacer
						.inspect
				)
			$0.view.addSubview(body)
			$0.view.backgroundColor = .systemBackground
			body.pin(
				to: $0.view.safeAreaLayoutGuide,
				insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
			)
		},
		animated: true)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		UILabel.swizzleIfNeeded()
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
