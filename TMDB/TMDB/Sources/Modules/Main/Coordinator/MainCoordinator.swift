//
//  MainCoordinator.swift
//  TMDB
//
//  Created by Luann Marques Luna on 19/02/21.
//

import UIKit

protocol MainViewCoordinatorDelegate: class { }

class MainCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    private lazy var itens: [TabBarItem] = {
        return [.popular, .genre]
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }
    
    func start() {
        let module = loadViewController()
        navigationController.setViewControllers([module], animated: true)
    }
    
    private func loadViewController() -> UIViewController {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        
        viewModel.coordinator = self
        viewModel.view = viewController
        
        var controllers: [UIViewController] = []
        itens.forEach { item in
            if let coordinator = item.coordinator() {
                addChild(coordinator)
                coordinator.start()
                
                controllers.append(coordinator.navigationController)
            }
        }
        
        viewController.setViewControllers(controllers, animated: false)
        viewController.selectedIndex = 0
        
        return viewController
        
    }
}

extension MainCoordinator: MainViewCoordinatorDelegate { }
