//
//  UILabel+Typograpy.swift
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
import SwiftUI


extension UILabel: TypographyExtensions {
    public var optionalFont: UIFont? {
        get { font }
        set { font = newValue }
    }

    public var optionalAttributedText: NSAttributedString? {
        get { attributedText }
        set { attributedText = newValue }
    }
}

// Warning due to: https://forums.swift.org/t/optional-conformance-warnings-with-protocols/3530/2
extension UITextView: TypographyExtensions {
    public var optionalFont: UIFont? {
        get { font }
        set { font = newValue }
    }

    public var optionalAttributedText: NSAttributedString? {
        get { attributedText }
        set { attributedText = newValue }
    }
}

extension UITextField: TypographyExtensions {
    public var optionalFont: UIFont? {
        get { font }
        set { font = newValue }
    }

    public var optionalAttributedText: NSAttributedString? {
        get { attributedText }
        set { attributedText = newValue }
    }
}

