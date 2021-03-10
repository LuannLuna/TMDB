//
//  GenreServiceMock.swift
//  TMDBTests
//
//  Created by Luann Marques Luna on 22/02/21.
//

import Foundation

@testable import TMDB

class GenreServiceMock: GenreServiceProtocol {
    
    var result: ResultCase
    
    init(result: ResultCase) {
        self.result = result
    }
    
    func fetchGenreData(callback: @escaping GenreCallback) {
        switch result {
        case .success:
            let genres: GenreQueryResult = LocalFileJSON.get("Genres")
            callback(.success(genres))
        case .failure:
            callback(.failure(NetworkError.dataNotFound))
        }
    }
}
