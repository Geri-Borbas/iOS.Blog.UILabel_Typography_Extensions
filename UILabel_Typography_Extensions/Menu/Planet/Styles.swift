//
//  UIColor+Styles.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 09/03/2022.
//

import Foundation
import UIKit


struct UI {
	
	static let padding = UIEdgeInsets(top: 15, left: 25, bottom: 25, right: 25)
	
	struct StackView {
		
		static let spacing = CGFloat(5)
		static let spacer = CGFloat(20)
	}
	
	struct Color {
		
		static let background = UIColor(named: "Background") ?? UIColor.clear
		static let label = UIColor(named: "Label") ?? UIColor.clear
		static let mars = UIColor(named: "Mars") ?? UIColor.clear
	}
	
	struct Asset {
		
		static let mars = UIImage(named: "Mars")
	}
}


extension UILabel {
	
	var withHeroStyle: Self {
		self
			.with {
				$0.textColor = UI.Color.label
				$0.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 100)
				$0.lineHeight = 80
				$0.letterSpacing = 100 * -0.02
			}
	}
	
	var withSubtitleStyle: Self {
		self
			.with {
				$0.textColor = UI.Color.label
				$0.font = UIFont(name: "HelveticaNeue", size: 20)
				$0.adjustsFontSizeToFitWidth = false
				$0.lineHeight = 30
				$0.letterSpacing = 20 * 0.28
			}
	}
	
	var withIntroStyle: Self {
		self
			.with {
				$0.textColor = UI.Color.label
				$0.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
				$0.numberOfLines = 0
				$0.lineHeight = 20
				$0.letterSpacing = 12 * 0.30
			}
	}
	
	var withTitleStyle: Self {
		self
			.with {
				$0.textColor = UI.Color.label
				$0.font = UIFont(name: "HelveticaNeue-Medium", size: 21)
				$0.numberOfLines = 0
				$0.lineHeight = 30
				$0.letterSpacing = 21 * 0.10
				$0.underline = .single
			}
	}
	
	var withParagraphStyle: Self {
		self
			.with {
				$0.textColor = UI.Color.label.withAlphaComponent(0.5)
				$0.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
				$0.numberOfLines = 0
				$0.lineHeight = 20
			}
	}
}
