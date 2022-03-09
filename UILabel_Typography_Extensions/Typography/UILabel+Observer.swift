//
//  UILabel+Observer.swift
//  UILabel_Typography_Extensions
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


extension UILabel {
	
	typealias TextObserver = Observer<UILabel, String?>
	typealias TextChangeAction = (_ oldValue: String?, _ newValue: String?) -> Void
	
	fileprivate struct Keys {
		static var observer: UInt8 = 0
	}
	
	fileprivate var observer: TextObserver? {
		get {
			objc_getAssociatedObject(self, &Keys.observer) as? TextObserver
		}
		set {
			objc_setAssociatedObject(self, &Keys.observer, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
		}
	}
	
	func onTextChange(_ completion: @escaping TextChangeAction) {
		guard observer == nil else {
			return
		}
		
		observer = TextObserver(
			for: self,
			keyPath: \.text,
			onChange: { oldText, newText in
				completion(oldText ?? nil, newText ?? nil)
			}
		)
	}
}


class Observer<ObjectType: NSObject, ValueType>: NSObject {
	
	typealias ChangeAction = (_ oldValue: ValueType?, _ newValue: ValueType?) -> Void
	let onChange: ChangeAction
	private var observer: NSKeyValueObservation?
	
	init(for object: ObjectType, keyPath: KeyPath<ObjectType, ValueType>, onChange: @escaping ChangeAction) {
		self.onChange = onChange
		super.init()
		observe(object, keyPath: keyPath)
	}
	
	func observe(_ object: ObjectType, keyPath: KeyPath<ObjectType, ValueType>) {
		observer = object.observe(
			keyPath,
			options:  [.new, .old],
			changeHandler: { [weak self] _, change in
				self?.onChange(change.oldValue, change.newValue)
			}
		)
	}
	
	deinit {
		observer?.invalidate()
	}
}
