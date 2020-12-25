//
//  UIStackView+Extensions.swift
//  Declarative_UIKit
//
//  Created by Geri Borbás on 29/11/2020.
//  http://www.twitter.com/Geri_Borbas
//

import UIKit


extension UIView {
	
	static var spacer: UIView {
		UIView().with {
			$0.setContentHuggingPriority(.required, for: .horizontal)
			$0.setContentHuggingPriority(.required, for: .vertical)
		}
	}
	
	func pin(to: UILayoutGuide, insets: UIEdgeInsets)  {
		guard let _ = superview else {
			return
		}
		
		translatesAutoresizingMaskIntoConstraints = false
		topAnchor.constraint(equalTo: to.topAnchor, constant: insets.top).isActive = true
		bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -insets.bottom).isActive = true
		leftAnchor.constraint(equalTo: to.leftAnchor, constant: insets.left).isActive = true
		rightAnchor.constraint(equalTo: to.rightAnchor, constant: -insets.right).isActive = true
	}
	
	func pin(to: UIView, insets: UIEdgeInsets)  {
		guard let _ = superview else {
			return
		}
		
		translatesAutoresizingMaskIntoConstraints = false
		topAnchor.constraint(equalTo: to.topAnchor, constant: insets.top).isActive = true
		bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -insets.bottom).isActive = true
		leftAnchor.constraint(equalTo: to.leftAnchor, constant: insets.left).isActive = true
		rightAnchor.constraint(equalTo: to.rightAnchor, constant: -insets.right).isActive = true
	}
	
	var withRedLines: UIView {
		with {
			$0.layer.borderWidth = 1
			$0.layer.cornerRadius = 2
			$0.layer.borderColor = UIColor.red.withAlphaComponent(0.3).cgColor
			$0.backgroundColor = UIColor.red.withAlphaComponent(0.1)
		}
	}
	
	var inspect: UIView {
		withRedLines
	}
}


extension UIStackView {
	
	func horizontal(spacing: CGFloat = 0) -> Self {
		with {
			$0.axis = .horizontal
			$0.spacing = spacing
		}
	}
	
	func vertical(spacing: CGFloat = 0) -> Self {
		with {
			$0.axis = .vertical
			$0.spacing = spacing
		}
	}
	
	func views(_ views: UIView ...) -> Self {
		views.forEach { self.addArrangedSubview($0) }
		return self
	}
}


extension UILabel {
	
	func with(text: String?) -> Self {
		with {
			$0.text = text
		}
	}
}


extension UIImageView {
	
	func with(image: UIImage?) -> Self {
		with {
			$0.image = image
		}
	}
}
