//
//  ViewController.swift
//  Label_Extensions
//
//  Copyright © 2020. Geri Borbás. All rights reserved.
//  https://twitter.com/Geri_Borbas
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit


class ViewController: UIViewController {
	
	let string = "Underline / Line Height / Letter" // Spacing
	
	lazy var label = UILabel()
		.with {
			$0.textColor = .label
			$0.font = UIFont.newYork(ofSize: 1024/26) // Results in 47 points line height
			$0.numberOfLines = 0
			
			$0.adjustsFontSizeToFitWidth = false
			$0.baselineAdjustment = .alignBaselines
			$0.minimumScaleFactor = 1
			$0.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
			
			// 🤨
			let lineHeight = CGFloat(87)
			let baselineOffset = (lineHeight - $0.font.lineHeight) / 2.0 / 2.0
			
			$0.attributedText = NSAttributedString(
				string: string,
				attributes: [
					.baselineOffset : baselineOffset,
					.paragraphStyle : NSMutableParagraphStyle().with {
						$0.minimumLineHeight = lineHeight
						$0.maximumLineHeight = lineHeight
					}
				])
			
			// 🔑
			$0.observeIfNeeded()
			
			$0.showGrid = true
			$0.clipsToBounds = true
		}
		.inspect
		.with {
			$0.layer.cornerRadius = 5
		}
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			label,
			UIButton()
				.with(title: "Change Text", target: self, selector: #selector(didTapChangeTextButton))
				.inspect,
			UIButton()
				.with(title: "Attributes", target: self, selector: #selector(didTapAttributesButton))
				.inspect,
			UIButton()
				.with(title: "Lorem Ipsum", target: self, selector: #selector(didTapLoremIpsumButton))
				.inspect,
			UIButton()
				.with(title: "Glyph", target: self, selector: #selector(didTapGlyphButton))
				.inspect,
			UIView
				.spacer
				.inspect
		)
	
	var models: [(text: String, backgroundColor: UIColor)] = [
		("Lorem ipsum dolor sit amet.", UIColor.systemBlue.withAlphaComponent(0.3)),
		("Consectetur adipiscing elit.", UIColor.systemGreen.withAlphaComponent(0.3)),
		("Sed do eiusmod tempor incididunt ut labore.", UIColor.systemOrange.withAlphaComponent(0.3)),
		("Et dolore magna aliqua.", UIColor.systemIndigo.withAlphaComponent(0.3))
	]
	
	@objc func didTapChangeTextButton() {
		if models.isEmpty == false {
			let model = models.removeFirst()
			label.text = model.text
			label.backgroundColor = model.backgroundColor
		}
	}
	
	@objc func didTapAttributesButton() {
		self.present(AttributesViewController(), animated: true)
	}
	
	@objc func didTapGlyphButton() {
		self.present(GlyphViewController(), animated: true)
	}
	
	@objc func didTapLoremIpsumButton() {
		self.present(LoremIpsumViewController(), animated: true)
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
	
	var withImages: Self {
		with {
			$0.leadingImage = Typography.Image(
				image: UIImage(named: "Star"),
				size: CGSize(width: font.capHeight, height: font.capHeight)
			)
			$0.trailingImage = Typography.Image(
				image: UIImage(named: "Star")!.withRenderingMode(.alwaysTemplate),
				size: CGSize(width: font.capHeight, height: font.capHeight)
			)
		}
	}
}


fileprivate extension UIButton {
	
	var withButtonStyle: Self {
		with {
			$0.titleLabel?.textColor = .label
			$0.titleLabel?.backgroundColor = .cyan
			$0.titleLabel?.letterSpacing = 5
			$0.titleLabel?.lineHeight = 50
			$0.titleLabel?.lineBreakMode = .byTruncatingMiddle
			$0.titleLabel?.pin(to: $0, insets: UIEdgeInsets.zero)
			_ = $0.titleLabel?.withImages
			$0.setTitleColor(.label, for: .normal)
			$0.setAttributedTitle($0.titleLabel?.attributedText, for: .normal)
		}
	}
	
	func with(title: String, target: Any, selector: Selector) -> Self {
		self
			.withButtonStyle
			.with {
				$0.setTitle(title, for: .normal)
				$0.addTarget(target, action: selector, for: .touchUpInside)
			}
	}
}
	
