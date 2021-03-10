//
//  TabBarNavigatable.swift
//  TMDB
//
//  Created by Luann Marques Luna on 19/02/21.
//

import UIKit

protocol TabBarNavigatable: class {
    func changeToTab(_ tabBarItem: TabBarItem)
}

extension TabBarNavigatable {
    func changeToTab(_ tabBarItem: TabBarItem) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            if let mainCoordinator = appDelegate.coordinator?.childCoordinators.first(where: { $0 is MainCoordinator }),
                let mainController = mainCoordinator.rootViewController as? MainViewController {
                mainController.selectedIndex = tabBarItem.rawValue
            }
        }
    }
}
