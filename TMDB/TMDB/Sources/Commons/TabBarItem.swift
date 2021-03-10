//
//  TabBarItem.swift
//
//  Created by Luann Marques Luna on 19/02/21.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case popular = 0
    case genre
    
    static var numberOfItens: Int {
        allCases.count
    }
    
    var title: String {
        switch self {
        case .popular:
            return "Popular"
        case .genre:
            return "Genre"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .popular:
            return #imageLiteral(resourceName: "popularity")
        case .genre:
            return #imageLiteral(resourceName: "dashboard")
        }
    }
    
    var item: UITabBarItem {
        let tabbarItem = UITabBarItem(title: title, image: icon, selectedImage: icon)
        tabbarItem.imageInsets = UIEdgeInsets(top: -2, left: 0, bottom: 2, right: 0)
        
        return tabbarItem
    }
    
    func coordinator() -> Coordinator? {
        var coordinator: Coordinator?
        
        switch self {
        case .popular: coordinator = HomeCoordinator(navigationController: UINavigationController())
        case .genre: coordinator = GenreCoordinator(navigationController: UINavigationController())
        }
        
        coordinator?
            .rootViewController?
            .tabBarItem = self.item
        
        return coordinator
    }
}
