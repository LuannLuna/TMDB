//
//  Coordinator.swift
//  TMDB
//
//  Created by Luann Marques Luna on 18/02/21.
//

import UIKit

public protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

extension Coordinator {
    var rootViewController: UIViewController? {
        if let presentedViewController = navigationController.presentedViewController {
            return presentedViewController
        } else if let topViewController = navigationController.topViewController {
            return topViewController
        } else {
            return navigationController
        }
    }
    
    func addChild(_ coordinator: Coordinator) {
        if !childCoordinators.contains(where: { $0 === coordinator }) {
            childCoordinators.append(coordinator)
        }
    }
    
    func removeChild(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
