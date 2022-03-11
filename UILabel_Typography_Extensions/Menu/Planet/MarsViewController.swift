//
//  MarsViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 11/03/2022.
//

import UIKit
import SwiftUI


class MarsViewController: UIViewController {
	
	lazy var stackView = UIStackView().with {
		$0.axis = .vertical
		$0.spacing = 5
		[
			UILabel().with {
				$0.textColor = UIColor(named: "Mars")
				$0.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 100)
				$0.lineHeight = 80
				$0.letterSpacing = 100 * -0.02
				$0.text = "Mars"
			},
			UILabel().with {
				$0.textColor = .label
				$0.font = UIFont(name: "HelveticaNeue", size: 20)
				$0.lineHeight = 30
				$0.letterSpacing = 20 * 0.28
				$0.text = "Martian (/ˈmɑːrʃən/)"
			},
			UIImageView(image: .init(named: "Mars")),
			UILabel().with {
				$0.textColor = .label
				$0.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
				$0.numberOfLines = 0
				$0.lineHeight = 20
				$0.letterSpacing = 12 * 0.30
				$0.text = "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, being larger than only Mercury. In English, Mars carries the name of the Roman god of war and is often referred to as the \"Red Planet\". The latter refers to the effect of the iron oxide prevalent on Mars's surface.".uppercased()
			},
			UILabel().with {
				$0.textColor = .label
				$0.font = UIFont(name: "HelveticaNeue-Bold", size: 21)
				$0.numberOfLines = 0
				$0.lineHeight = 30
				$0.letterSpacing = 21 * 0.10
				$0.underline = .single
				$0.text = "History"
			},
			UILabel().with {
				$0.textColor = .label.withAlphaComponent(0.5)
				$0.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
				$0.numberOfLines = 0
				$0.lineHeight = 20
				$0.text = "The days and seasons are comparable to those of Earth, because the rotation period as well as the tilt of the rotational axis relative to the ecliptic plane are similar. Mars is the site of Olympus Mons, the largest volcano and highest known mountain on any planet in the Solar System, and of Valles Marineris, one of the largest canyons in the Solar System. The smooth Borealis basin in the Northern Hemisphere covers 40% of the planet and may be a giant impact feature. Mars has two moons, Phobos and Deimos, which are small and irregularly shaped.\n\nMars has been explored by several uncrewed spacecraft. Mariner 4 was the first spacecraft to visit Mars; launched by NASA on 28 November 1964, it made its closest approach to the planet on 15 July 1965. Mariner 4 detected the weak Martian radiation belt, measured at about 0.1% that of Earth, and captured the first images of another planet from deep space. The latest spacecraft to successfully land on Mars are CNSA's Tianwen-1 lander and Zhurong rover, landed on 14 May 2021."
			}
		].add(to: $0)
	}
		.views(
			
		)
		.with {
			$0.setCustomSpacing(30, after: $0.subviews[3])
			$0.setCustomSpacing(30, after: $0.subviews[4])
		}
	
	lazy var scrollView = UIScrollView()
		.with {
			$0.clipsToBounds = false
		}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Colors.
		view.backgroundColor = UI.Color.background
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
}


fileprivate extension Array where Element: UIView {
	
	func add(to stackView: UIStackView) {
		forEach { stackView.addArrangedSubview($0) }
	}
}


struct MarsViewController_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PreviewView(for: MarsViewController())
				.environment(\.colorScheme, .light)
			.edgesIgnoringSafeArea(.all)
		}
	}
}

