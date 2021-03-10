//
//  DetailMovieCoordinator.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import UIKit

protocol DetailMovieCoordinatorDelegate: Coordinator {
    func didTapAtMovie(movie: Movie)
    func onFinish()
}

class DetailMovieCoordinator: DetailMovieCoordinatorDelegate {
    
    public var childCoordinators: [Coordinator]
    public var navigationController: UINavigationController
    let movie: Movie
    weak var coordinatorDelegate: CoordinatorDelegate?
    
    init(navigationController: UINavigationController, movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
        childCoordinators = []
    }
    
    public func start() {
        let module = loadViewController()
        navigationController.pushViewController(module, animated: true)
    }
    
    private func loadViewController() -> UIViewController {
        let viewModel = DetailMovieViewModel(movie: movie)
        let viewController = DetailMovieViewController(viewModel: viewModel)
        viewModel.coordinator = self
        
        return viewController
    }
    
    func didTapAtMovie(movie: Movie) {
        let coordinator = DetailMovieCoordinator(navigationController: navigationController, movie: movie)
        coordinator.coordinatorDelegate = self
        addChild(coordinator)
        coordinator.start()
    }
    
    func onFinish() {
        coordinatorDelegate?.onCoordinatorFinish(self)
    }
}

extension DetailMovieCoordinator: CoordinatorDelegate {}
