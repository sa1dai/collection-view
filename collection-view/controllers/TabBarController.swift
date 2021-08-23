//
//  TabBarController.swift
//  collection-view
//
//  Created by Max Boychenko on 06.08.2021.
//

import UIKit
final class TabBarController: UITabBarController {
	
	// MARK: - Lifecycle Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabBar.tintColor = .black
		
		let leftTab = CollectionViewController()
		leftTab.tabBarItem = UITabBarItem(
			title: "Old collection view",
			image: UIImage(named: "OldListTabIcon"),
			tag: 0
		)
		
		let rightTab = ModernCollectionViewController()
		rightTab.tabBarItem = UITabBarItem(
			title: "Modern collection view",
			image: UIImage(named: "ModernListTabIcon"),
			tag: 1
		)
		
		viewControllers = [leftTab, rightTab]
	}
	
}
