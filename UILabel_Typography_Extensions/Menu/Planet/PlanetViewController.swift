//
//  PlanetViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 09/03/2022.
//

import UIKit


class PlanetViewController: UIViewController {
	
	lazy var titleLabel = UILabel()
		.with {
			$0.textColor = .label
			$0.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 100)
			$0.lineHeight = 80
			$0.showGrid = true
		}
	
	lazy var subtitleLabel = UILabel()
		.with {
			$0.textColor = .label
			$0.font = UIFont(name: "HelveticaNeue-Regular", size: 20)
			$0.lineHeight = 30
			$0.letterSpacing = 20
		}
	
	lazy var introLabel = UILabel()
		.with {
			$0.textColor = .label
			$0.font = UIFont(name: "HelveticaNeue-Regular", size: 12)
			$0.lineHeight = 20
			$0.letterSpacing = 10
		}
	
	lazy var body = UIStackView()
		.vertical(spacing: 10)
		.views(
			titleLabel,
			subtitleLabel,
			introLabel,
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
			insets: UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
		)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Data.
		titleLabel.text = "Jupiter"
		subtitleLabel.text = "Jovian /ˈdʒoʊviən/"
		introLabel.text = "Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a gas giant with a mass one-thousandth that of the Sun, but two-and-a-half times that of all the other planets in the Solar System combined.".uppercased()
	}
}
