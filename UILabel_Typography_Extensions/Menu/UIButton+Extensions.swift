//
//  UIButton+Extensions.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 09/03/2022.
//

import UIKit


extension UIButton {
	
	typealias Action = () -> Void
	
	struct Keys {
		static var action: UInt8 = 0
	}
	
	/// An attributed string property to cache typography even when the label text is empty.
	var action: Action? {
		get {
			objc_getAssociatedObject(self, &Keys.action) as? Action
		}
		set {
			objc_setAssociatedObject(self, &Keys.action, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	func onTouchUpInside(_ action: @escaping Action) -> Self {
		self.action = action
		addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
		return self
	}

	@objc func didTouchUpInside() {
		action?()
	}
}
