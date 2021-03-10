//
//  DetailMovieViewModel.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import Foundation

protocol DetailMovieViewModelDelegate: class {
    var title: String { get }
    var img: String? { get }
    var overview: String { get }
    var average: String { get }
    var releaseDate: String { get }
    var numberOfItens: Int { get }
    func viewDidAppear(completion: @escaping CompletionHandler)
    func elementAt(index: Int) -> Movie?
    func onFinish()
    func didTapped(at index: Int)
}

public class DetailMovieViewModel {
    
    weak var coordinator: DetailMovieCoordinatorDelegate?
    weak var view: DetailMovieViewControllerDelegate?
    
    var service: MovieServiceProtocol
    let movie: Movie
    var similarMovies: [Movie]
    
    init(movie: Movie) {
        self.movie = movie
        self.service = MovieService(query: MovieQuery.similar(movieID: movie.id))
        self.similarMovies = []
    }
    
}

extension DetailMovieViewModel: DetailMovieViewModelDelegate {
    
    var title: String { movie.title }
    
    var img: String? { movie.img }
    
    var overview: String { movie.overview ?? "" }
    
    var average: String {
        if let voteAverage = movie.voteAverage {
            return String(format: "%.1f", voteAverage)
        }
        return ""
    }
    
    var numberOfItens: Int { similarMovies.count }
    
    var releaseDate: String {
        movie.releaseDate?.atFormat(with: "EEE MM/dd/YYYY") ?? ""
    }
    
    func viewDidAppear(completion: @escaping CompletionHandler) {
        service.fetchMovieData { [weak self] result in
            switch result {
            case .success(let response):
                self?.similarMovies = response.results
                completion()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func elementAt(index: Int) -> Movie? {
        return similarMovies.element(at: index)
    }
    
    func didTapped(at index: Int) {
        if let movie = similarMovies.element(at: index) {
            coordinator?.didTapAtMovie(movie: movie)
        }
    }
    
    func onFinish() {
        coordinator?.onFinish()
    }
}
