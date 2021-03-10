//
//  HomeViewModel.swift
//  TMDB
//
//  Created by Luann Marques Luna on 19/02/21.
//

import Foundation

protocol HomeViewModelDelegate: class {
    func viewDidLoad(completion: CompletionHandler?)
    func numberOfItens() -> Int
    func elementAt(index: Int) -> Movie?
    func didTapElement(index: Int)
}

class HomeViewModel: HomeViewModelDelegate {
    
    var service: MovieServiceProtocol
    weak var coordinator: HomeCoordinatorDelegate?
    
    private var movies: [Movie]
    
    init(service: MovieServiceProtocol = MovieService(query: MovieQuery.popular)) {
        self.service = service
        movies = []
    }
    
    // TODO: Call service
    func viewDidLoad(completion: CompletionHandler?) {
        service.fetchMovieData { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let movies):
                self?.movies = movies.results
                completion?()
            }
        }
    }
    
    func numberOfItens() -> Int {
        return movies.count
    }
    
    func elementAt(index: Int) -> Movie? {
        return movies.element(at: index)
    }
    
    func didTapElement(index: Int) {
        guard let movie = elementAt(index: index),
              let coordinator = coordinator else { return }
        coordinator.showMovieDetail(movie: movie)
    }
}
