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
			
			UILabel()
				.with(text: "Default")
				.with {
					$0.textColor = .gray
					$0.font = .preferredFont(forTextStyle: .largeTitle)
				}.inspect,
			
			UILabel()
				.with(text: "Default")
				.with {
					$0.textColor = .label
					$0.font = .preferredFont(forTextStyle: .headline)
					$0.underline = .double
					$0.lineHeight = 100
					$0.letterSpacing = -1
				}.with {
					$0.text = "Underline / Line Height / Letter Spacing"
					$0.tag = 3
				}.inspect,
			
			UILabel()
				.with(text: "Default")
				.with {
					$0.textColor = .label
					$0.font = .preferredFont(forTextStyle: .headline)
					$0.lineHeight = 100
				}
				.with {
					$0.text = "Line Height / Recolored / Strikethrough"
					$0.textColor = .orange
					$0.strikethrough = .single
					$0.lineBreakMode = .byTruncatingHead
				 }
				.inspect,
			
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
				 }
				.inspect,
			
			UILabel()
				.with(text: "Letter Spacing / Alignment / Line Break Mode")
				.with {
					$0.textColor = .systemGray
					$0.font = .preferredFont(forTextStyle: .footnote)
					$0.numberOfLines = 0
				}
				.with {
					$0.letterSpacing = 20
					$0.textAlignment = .right
					$0.lineBreakMode = .byTruncatingHead
				 }
				.inspect,
			
			UIButton()
				.with {
					$0.titleLabel?.text = "Button (Letter Spacing / Line Height / Underline)"
					$0.titleLabel?.textColor = .label
					$0.titleLabel?.letterSpacing = 5
					$0.titleLabel?.lineHeight = 50
					$0.titleLabel?.underline = .thick
					$0.titleLabel?.lineBreakMode = .byTruncatingMiddle
					$0.titleLabel?.pin(to: $0, insets: UIEdgeInsets.zero)
					$0.setAttributedTitle($0.titleLabel?.attributedText, for: .normal)
					$0.addTarget(self, action: #selector(didTap), for: .touchUpInside)
				}
				.inspect,
			
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
