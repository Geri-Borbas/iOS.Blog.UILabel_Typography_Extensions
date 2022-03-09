//
//  UIButton+Styles.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 09/03/2022.
//

import UIKit


extension UIButton {
	
	var withButtonStyle: Self {
		with {
			$0.titleLabel?.textColor = .systemBackground
			$0.titleLabel?.backgroundColor = .systemBlue
			$0.titleLabel?.letterSpacing = 2
			$0.titleLabel?.lineHeight = 50
			$0.titleLabel?.textAlignment = .center
			$0.titleLabel?.lineBreakMode = .byTruncatingMiddle
			$0.titleLabel?.pin(to: $0, insets: UIEdgeInsets.zero)
			_ = $0.titleLabel?.withImages
			$0.setTitleColor(.systemBackground, for: .normal)
			$0.setAttributedTitle($0.titleLabel?.attributedText, for: .normal)
			$0.layer.cornerRadius = 25
			$0.clipsToBounds = true
		}
	}
	
	func with(title: String) -> Self {
		self
			.withButtonStyle
			.with {
				$0.setTitle(title, for: .normal)
			}
	}
}
