//
//  Button+Extension.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/29/24.
//

import UIKit

extension UIButton {
	func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
		UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
		
		guard let context = UIGraphicsGetCurrentContext() else { return }
		
		context.setFillColor(color.cgColor)
		context.fill(CGRect(x: 0.0, y: 0.0, width: 1, height: 1))
		
		let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		setBackgroundImage(backgroundImage, for: state)
	}
}
