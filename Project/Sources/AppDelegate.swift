//
//  AppDelegate.swift
//  KidsnotePreProject
//
//  Created by 가대현 on 3/27/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let rootViewController = storyboard.instantiateViewController(withIdentifier: "ViewController")
		
		let navigationController = UINavigationController(rootViewController: rootViewController)
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = navigationController
		self.window?.makeKeyAndVisible()
		
		return true
	}

}

