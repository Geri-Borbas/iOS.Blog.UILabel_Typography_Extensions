//
//  PlanetViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 09/03/2022.
//

import UIKit
import SwiftUI


class PlanetViewController: UIViewController {
	
	lazy var heroLabel = UILabel().withHeroStyle.inspect
	lazy var subtitleLabel = UILabel().withSubtitleStyle.inspect
	lazy var image = UIImageView().inspect
	lazy var introLabel = UILabel().withIntroStyle.inspect
	lazy var titleLabel = UILabel().withTitleStyle.inspect
	lazy var paragraphLabel = UILabel().withParagraphStyle.inspect
	
	lazy var stackView = UIStackView()
		.vertical(spacing: UI.StackView.spacing)
		.views(
			heroLabel,
			subtitleLabel,
			image,
			introLabel,
			titleLabel,
			paragraphLabel
		)
		.with {
			$0.setCustomSpacing(20 + 2 * UI.StackView.spacing, after: introLabel)
			$0.setCustomSpacing(20 + 2 * UI.StackView.spacing, after: titleLabel)
		}
	
	lazy var scrollView = UIScrollView()
		.with {
			$0.clipsToBounds = false
		}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Colors.
		view.backgroundColor = .background
		overrideUserInterfaceStyle = .dark
		
		// Hierarchy.
		view.addSubview(scrollView)
		scrollView.addSubview(stackView)
		scrollView.pin(
			to: view.safeAreaLayoutGuide,
			insets: .zero
		)
		stackView.pin(
			to: scrollView,
			insets: UI.padding
		)
		
		// Vertical scrolling.
		stackView.widthAnchor.constraint(
			equalTo: scrollView.widthAnchor,
			constant: -UI.padding.left - UI.padding.right
		).isActive = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Data.
		heroLabel.text = "Mars"
		heroLabel.textColor = .mars
		subtitleLabel.text = "Martian (/ˈmɑːrʃən/)"
		image.image = .init(named: "Mars")
		introLabel.text = "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, being larger than only Mercury. In English, Mars carries the name of the Roman god of war and is often referred to as the \"Red Planet\". The latter refers to the effect of the iron oxide prevalent on Mars's surface.".uppercased()
		titleLabel.text = "History"
		paragraphLabel.text = """
			The days and seasons are comparable to those of Earth, because the rotation period as well as the tilt of the rotational axis relative to the ecliptic plane are similar. Mars is the site of Olympus Mons, the largest volcano and highest known mountain on any planet in the Solar System, and of Valles Marineris, one of the largest canyons in the Solar System. The smooth Borealis basin in the Northern Hemisphere covers 40% of the planet and may be a giant impact feature. Mars has two moons, Phobos and Deimos, which are small and irregularly shaped.

			Mars has been explored by several uncrewed spacecraft. Mariner 4 was the first spacecraft to visit Mars; launched by NASA on 28 November 1964, it made its closest approach to the planet on 15 July 1965. Mariner 4 detected the weak Martian radiation belt, measured at about 0.1% that of Earth, and captured the first images of another planet from deep space. The latest spacecraft to successfully land on Mars are CNSA's Tianwen-1 lander and Zhurong rover, landed on 14 May 2021.
			"""
	}
}


struct PlanetViewController_Previews: PreviewProvider {
	static var previews: some View {
		PreviewView(for: PlanetViewController())
			.environment(\.colorScheme, .dark)
			.edgesIgnoringSafeArea(.all)
	}
}
