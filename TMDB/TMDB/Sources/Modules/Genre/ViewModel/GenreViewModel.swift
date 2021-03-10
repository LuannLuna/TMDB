//
//  GenreViewModel.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import Foundation

protocol GenreViewModelDelegate: class {
    var numberOfElements: Int { get }
    func featchData(completion: @escaping CompletionHandler)
    func elementAt(index: Int) -> Genre?
}

class GenreViewModel: GenreViewModelDelegate {
    
    weak var coordinator: GenreCoordinatorDelegate?
    var service: GenreServiceProtocol
    private var genres: [Genre]
    
    init(service: GenreServiceProtocol = GenreService()) {
        self.service = service
        genres = []
    }
    
    func featchData(completion: @escaping CompletionHandler) {
        service.fetchGenreData { [weak self] result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let result):
                self?.genres = result.genres
                completion()
            }
        }
    }
    
    func elementAt(index: Int) -> Genre? {
        return genres.element(at: index)
    }
    
    var numberOfElements: Int {
        genres.count
    }
}
