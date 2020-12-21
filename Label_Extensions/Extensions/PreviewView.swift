//
//  PreviewView.swift
//  Declarative_UIKit
//
//  Created by Geri Borbás on 30/11/2020.
//

import SwiftUI


struct PreviewView<ViewControllerType: UIViewController>: UIViewControllerRepresentable {
	
	let `for`: ViewControllerType
	
	func makeUIViewController(context: Context) -> ViewControllerType {
		`for`
	}
	
	func updateUIViewController(_ viewController: ViewControllerType, context: Context) {
		
	}
}
