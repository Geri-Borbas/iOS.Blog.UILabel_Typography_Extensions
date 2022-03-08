//
//  MenuViewController.swift
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


class MenuViewController: UIViewController {
		
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			UIButton()
				.with(title: "Manual Label Styling")
				.onTouchUpInside { [unowned self] in
					self.present(ManualViewController(), animated: true)
				}
			,
			UIButton()
				.with(title: "Empty Label Styling")
				.onTouchUpInside { [unowned self] in
					self.present(EmptyViewController(), animated: true)
				},
			UIButton()
				.with(title: "Attributes")
				.onTouchUpInside { [unowned self] in
					self.present(AttributesViewController(), animated: true)
				},
			UIButton()
				.with(title: "Lorem Ipsum")
				.onTouchUpInside { [unowned self] in
					self.present(LoremIpsumViewController(), animated: true)
				},
			UIButton()
				.with(title: "Glyph")
				.onTouchUpInside { [unowned self] in
					self.present(GlyphViewController(), animated: true)
				},
			UIButton()
				.with(title: "Line Height")
				.onTouchUpInside { [unowned self] in
					self.present(LineHeightViewController(), animated: true)
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
			insets: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
		)
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		self.present(EmptyViewController(), animated: true)
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
