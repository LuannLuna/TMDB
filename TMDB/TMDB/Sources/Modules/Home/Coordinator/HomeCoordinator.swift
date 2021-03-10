//
//  HomeCoordinator.swift
//  TMDB
//
//  Created by Luann Marques Luna on 19/02/21.
//

import UIKit

protocol HomeCoordinatorDelegate: Coordinator {
    func showMovieDetail(movie: Movie)
}

class HomeCoordinator: HomeCoordinatorDelegate {
    
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
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        
        viewModel.coordinator = self
        
        return viewController
    }
    
    func showMovieDetail(movie: Movie) {
        let coordinator = DetailMovieCoordinator(navigationController: navigationController, movie: movie)
        coordinator.coordinatorDelegate = self
        addChild(coordinator)
        coordinator.start()
    }
}

extension HomeCoordinator: CoordinatorDelegate {}
