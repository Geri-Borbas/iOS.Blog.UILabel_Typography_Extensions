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
	let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
	
	lazy var label_1: UILabel = {
				
		// Properties.
		let label = UILabel()
		label.font = UIFont.newYork(ofSize: 1024.0 / 26.0)
		label.textColor = .text
		label.layer.compositingFilter = "multiplyBlendMode"
		label.numberOfLines = 0
		label.showGrid = true
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
	
	lazy var label_2 = UILabel()
		.with {
			
			// Properties.
			$0.font = UIFont.newYork(ofSize: 1024.0 / 26.0)
			$0.textColor = .text
			$0.layer.compositingFilter = "multiplyBlendMode"
			$0.numberOfLines = 0
			$0.showGrid = true
			$0.text = loremIpsum
			$0.lineHeight = CGFloat(87)
			
		}.inspect
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			label_1
				.inspect,
			label_2
				.inspect,
			UIButton()
				.with(title: "Change Text", target: self, selector: #selector(didTapChangeTextButton)),
			UIButton()
				.with(title: "Attributes", target: self, selector: #selector(didTapAttributesButton)),
			UIButton()
				.with(title: "Lorem Ipsum", target: self, selector: #selector(didTapLoremIpsumButton)),
			UIButton()
				.with(title: "Glyph", target: self, selector: #selector(didTapGlyphButton)),
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
			label_1.text = model.text
			label_1.backgroundColor = .white // model.backgroundColor
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
			insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		)
		
		// 🔑
		DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
			self.label_1.text = self.label_1.text
			self.label_2.text = self.label_2.text
			
			print(self.label_1.lineHeight)
			print(self.label_2.lineHeight)
		}
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
			$0.titleLabel?.textColor = .systemBackground
			$0.titleLabel?.backgroundColor = .systemBlue
			$0.titleLabel?.letterSpacing = 5
			$0.titleLabel?.lineHeight = 50
			$0.titleLabel?.textAlignment = .center
			$0.titleLabel?.lineBreakMode = .byTruncatingMiddle
			$0.titleLabel?.pin(to: $0, insets: UIEdgeInsets.zero)
			_ = $0.titleLabel?.withImages
			$0.setTitleColor(.systemBackground, for: .normal)
			$0.setAttributedTitle($0.titleLabel?.attributedText, for: .normal)
			$0.layer.cornerRadius = 5
			$0.clipsToBounds = true
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
	
