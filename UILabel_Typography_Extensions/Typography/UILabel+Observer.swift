//
//  UILabel+Observer.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 02/01/2021.
//

import UIKit


extension UILabel {
	
	fileprivate struct Keys {
		static var observer: UInt8 = 0
	}
	
	var observer: Observer? {
		get {
			objc_getAssociatedObject(self, &Keys.observer) as? Observer
		}
		set {
			objc_setAssociatedObject(self, &Keys.observer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}

	func observeIfNeeded() {
		guard observer == nil else {
			return
		}
		
		observer = Observer(
			for: self,
			onTextChange: { text in
				print("\(Self.self).onTextChange(), text: `\(String(describing: text))`")
			}
		)
	}
}


class Observer: NSObject {
	
	typealias TextChangeAction = (_ text: String?) -> Void
	let onTextChange: TextChangeAction
	private var observer: NSKeyValueObservation?
	
	init(for label: UILabel, onTextChange: @escaping TextChangeAction) {
		self.onTextChange = onTextChange
		super.init()
		observe(label)
	}
	
	func observe(_ label: UILabel) {
		observer = label.observe(
			\.text,
			options:  [.new, .old],
			changeHandler: { [weak self] _, change in
				self?.onTextChange(change.newValue ?? nil)
			}
		)
	}
	
	deinit {
		observer?.invalidate()
	}
}
