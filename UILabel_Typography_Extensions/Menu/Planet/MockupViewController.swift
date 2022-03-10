//
//  MockupViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 10/03/2022.
//

import UIKit
import SwiftUI


class MockupViewController: UIViewController {
	
	lazy var stackView = UIStackView()
		.vertical(spacing: 5)
		.views(
			UILabel()
				.withHeroStyle
				.with(text: "Mars"),
			UILabel()
				.withSubtitleStyle
				.with(text: "Martian (/ˈmɑːrʃən/)"),
			UIImageView(image: .init(named: "Placeholder")),
			UILabel()
				.withIntroStyle
				.with(text: "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, being larger than only Mercury. In English, Mars carries the name of the Roman god of war and is often referred to as the \"Red Planet\". The latter refers to the effect of the iron oxide prevalent on Mars's surface.".uppercased()),
			UILabel()
				.withTitleStyle
				.with(text: "History"),
			UILabel()
				.withParagraphStyle
				.with(text: "The days and seasons are comparable to those of Earth, because the rotation period as well as the tilt of the rotational axis relative to the ecliptic plane are similar. Mars is the site of Olympus Mons, the largest volcano and highest known mountain on any planet in the Solar System, and of Valles Marineris, one of the largest canyons in the Solar System. The smooth Borealis basin in the Northern Hemisphere covers 40% of the planet and may be a giant impact feature. Mars has two moons, Phobos and Deimos, which are small and irregularly shaped.\n\nMars has been explored by several uncrewed spacecraft. Mariner 4 was the first spacecraft to visit Mars; launched by NASA on 28 November 1964, it made its closest approach to the planet on 15 July 1965. Mariner 4 detected the weak Martian radiation belt, measured at about 0.1% that of Earth, and captured the first images of another planet from deep space. The latest spacecraft to successfully land on Mars are CNSA's Tianwen-1 lander and Zhurong rover, landed on 14 May 2021.")
		)
		.with {
			$0.setCustomSpacing(30, after: $0.subviews[3])
			$0.setCustomSpacing(30, after: $0.subviews[5])
		}
	
	lazy var scrollView = UIScrollView()
		.with {
			$0.clipsToBounds = false
		}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Colors.
		view.backgroundColor = UI.Color.background
		
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
}


struct MockupViewController_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PreviewView(for: MockupViewController())
				.environment(\.colorScheme, .light)
			.edgesIgnoringSafeArea(.all)
		}
	}
}
