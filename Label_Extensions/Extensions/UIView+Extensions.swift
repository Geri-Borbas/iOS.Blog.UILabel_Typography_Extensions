//
//  UIView+Extensions.swift
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
	
	var inspect: UIView {
		with {
			$0.layer.borderWidth = 1
			$0.layer.cornerRadius = 2
			$0.layer.borderColor = UIColor.red.withAlphaComponent(0.3).cgColor
			$0.backgroundColor = UIColor.red.withAlphaComponent(0.1)
		}
	}
}
