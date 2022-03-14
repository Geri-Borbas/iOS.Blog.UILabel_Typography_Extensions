//
//  ImperativeViewController.swift
//  UILabel_Typography_Extensions
//
//  Created by Geri Borbás on 14/03/2022.
//

import UIKit
import SwiftUI


class ImperativeViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Colors.
		view.backgroundColor = UI.Color.background
		overrideUserInterfaceStyle = .dark
		
		
		let headerLabel = UILabel()
		headerLabel.textColor = UIColor(named: "Mars")
		headerLabel.font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 100)
		headerLabel.lineHeight = 80
		headerLabel.letterSpacing = 100 * -0.02
		headerLabel.text = "Mars"
		
		let subtitleLabel = UILabel()
		subtitleLabel.textColor = .label
		subtitleLabel.font = UIFont(name: "HelveticaNeue", size: 20)
		subtitleLabel.lineHeight = 30
		subtitleLabel.letterSpacing = 20 * 0.28
		subtitleLabel.text = "Martian (/ˈmɑːrʃən/)"
		
		let image = UIImageView(image: .init(named: "Mars"))
		
		let introLabel = UILabel()
		introLabel.textColor = .label
		introLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 12)
		introLabel.numberOfLines = 0
		introLabel.lineHeight = 20
		introLabel.letterSpacing = 12 * 0.30
		introLabel.text = "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, being larger than only Mercury. In English, Mars carries the name of the Roman god of war and is often referred to as the \"Red Planet\". The latter refers to the effect of the iron oxide prevalent on Mars's surface.".uppercased()
			
		let titleLabel = UILabel()
		titleLabel.textColor = .label
		titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 21)
		titleLabel.numberOfLines = 0
		titleLabel.lineHeight = 30
		titleLabel.letterSpacing = 21 * 0.10
		titleLabel.underline = .single
		titleLabel.text = "History"
			
		let paragraphLabel = UILabel()
		paragraphLabel.textColor = .label.withAlphaComponent(0.5)
		paragraphLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
		paragraphLabel.numberOfLines = 0
		paragraphLabel.lineHeight = 20
		paragraphLabel.text = "The days and seasons are comparable to those of Earth, because the rotation period as well as the tilt of the rotational axis relative to the ecliptic plane are similar. Mars is the site of Olympus Mons, the largest volcano and highest known mountain on any planet in the Solar System, and of Valles Marineris, one of the largest canyons in the Solar System. The smooth Borealis basin in the Northern Hemisphere covers 40% of the planet and may be a giant impact feature. Mars has two moons, Phobos and Deimos, which are small and irregularly shaped.\n\nMars has been explored by several uncrewed spacecraft. Mariner 4 was the first spacecraft to visit Mars; launched by NASA on 28 November 1964, it made its closest approach to the planet on 15 July 1965. Mariner 4 detected the weak Martian radiation belt, measured at about 0.1% that of Earth, and captured the first images of another planet from deep space. The latest spacecraft to successfully land on Mars are CNSA's Tianwen-1 lander and Zhurong rover, landed on 14 May 2021."
		
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 5
		stackView.addArrangedSubview(headerLabel)
		stackView.addArrangedSubview(subtitleLabel)
		stackView.addArrangedSubview(image)
		stackView.addArrangedSubview(introLabel)
		stackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(paragraphLabel)
		stackView.setCustomSpacing(30, after: introLabel)
		stackView.setCustomSpacing(30, after: titleLabel)
		
		let scrollView = UIScrollView()
		scrollView.clipsToBounds = false
		
		// Hierarchy.
		view.addSubview(scrollView)
		scrollView.addSubview(stackView)
		
		// Constraints.
		scrollView.translatesAutoresizingMaskIntoConstraints = false
		scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
		scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: UI.padding.top).isActive = true
		stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -UI.padding.bottom).isActive = true
		stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: UI.padding.left).isActive = true
		stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -UI.padding.right).isActive = true
		
		// Vertical scrolling.
		stackView.widthAnchor.constraint(
			equalTo: scrollView.widthAnchor,
			constant: -UI.padding.left - UI.padding.right
		).isActive = true
	}
}


struct ImperativeViewController_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			PreviewView(for: MarsViewController())
				.environment(\.colorScheme, .light)
			.edgesIgnoringSafeArea(.all)
		}
	}
}
