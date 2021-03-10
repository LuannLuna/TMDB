//
//  MovieServiceMock.swift
//  TMDBTests
//
//  Created by Luann Marques Luna on 22/02/21.
//

import Foundation

@testable import TMDB

class MovieServiceMock: MovieServiceProtocol {
    
    var result: ResultCase
    
    init(result: ResultCase) {
        self.result = result
    }
    
    func fetchMovieData(callback: @escaping MovieCallback) {
        switch result {
        case .success:
            let movies: MovieQueryResult = LocalFileJSON.get("PopularMovies")
            callback(.success(movies))
        case .failure:
            callback(.failure(NetworkError.dataNotFound))
        }
    }
}
