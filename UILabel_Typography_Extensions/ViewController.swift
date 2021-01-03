//
//  ViewController.swift
//  Label_Extensions
//
//  Created by Geri Borbás on 21/12/2020.
//

import UIKit


class ViewController: UIViewController {
	
	let string = "Underline / Line Height / Letter" // Spacing
	
	lazy var label = UILabel()
		.with {
			$0.textColor = .label
			$0.font = UIFont.newYork(ofSize: 1024/26)
			$0.numberOfLines = 0
			
			$0.adjustsFontSizeToFitWidth = false
			$0.baselineAdjustment = .alignBaselines
			$0.minimumScaleFactor = 1
			$0.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.2)
			// $0.lineBreakStrategy = .pushOut
			
			let lineHeight = CGFloat(87)
			let fontLineHeight = $0.font.lineHeight
			let lineHeightMultiple = lineHeight / fontLineHeight
			let baselineOffset = (lineHeight - fontLineHeight) / 2.0 / 2.0
			
			print("lineHeight: \(lineHeight)")
			print("fontLineHeight: \(fontLineHeight)")
			print("lineHeightMultiple: \(lineHeightMultiple)")
			print("fontLineHeight * lineHeightMultiple: \(fontLineHeight * lineHeightMultiple)")
			print("baselineOffset: \(baselineOffset)")
			
			$0.attributedText = NSAttributedString(
				string: string,
				attributes: [
					.font : UIFont.newYork(ofSize: 1024/26),
					.baselineOffset : baselineOffset,
					.paragraphStyle : NSMutableParagraphStyle().with {
						$0.lineHeightMultiple = lineHeightMultiple
						$0.lineSpacing = 0
						$0.minimumLineHeight = lineHeight
						$0.maximumLineHeight = lineHeight
						$0.lineBreakMode = .byTruncatingTail
						$0.lineBreakStrategy = .pushOut
					},
					.kern : -1,
					.underlineStyle : NSUnderlineStyle.single.rawValue
				])
			$0.text = string
			
			$0.showGrid = true
			$0.clipsToBounds = true
		}
		.inspect
		.with {
			$0.layer.cornerRadius = 15
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
	
	var strings: [String] = [
		"Lorem ipsum dolor sit amet.",
		"Consectetur adipiscing elit.",
		"Sed do eiusmod tempor incididunt ut labore.",
		"Et dolore magna aliqua."
	]
	
	@objc func didTapChangeTextButton() {
		
		/// Update `text`.
		if strings.isEmpty == false {
			label.textColor = .systemGreen
			label.text = strings.removeFirst()
		}
		
		/// This is needed every time after the `text` property updated.
		label.attributedText = label.attributedText
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
			// $0.titleLabel?.text = "Button"
			$0.titleLabel?.textColor = .label
			$0.titleLabel?.backgroundColor = .cyan
			$0.titleLabel?.letterSpacing = 5
			$0.titleLabel?.lineHeight = 50
			$0.titleLabel?.lineBreakMode = .byTruncatingMiddle
			$0.titleLabel?.pin(to: $0, insets: UIEdgeInsets.zero)
			_ = $0.titleLabel?.withImages
			// $0.setColor(UIColor.label, for: .normal)
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
	
