//
//  GenreCoordinator.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import UIKit

protocol GenreCoordinatorDelegate: Coordinator {
    
}

class GenreCoordinator: GenreCoordinatorDelegate {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        childCoordinators = []
    }
    
    func start() {
        let module = loadViewController()
        navigationController.pushViewController(module, animated: true)
    }
    
    private func loadViewController() -> UIViewController {
        let viewModel = GenreViewModel()
        let viewController = GenreViewController(viewModel: viewModel)
        viewModel.coordinator = self
        
        return viewController
    }
}
