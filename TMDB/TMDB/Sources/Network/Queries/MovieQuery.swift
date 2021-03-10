//
//  Movie.swift
//  TMDB
//
//  Created by Luann Marques Luna on 19/02/21.
//

import Foundation

public enum MovieQuery: RestQuery {
    case popular
    case similar(movieID: Int)
    
    public var path: String {
        switch self {
        case .popular:
            return "movie/popular"
        case .similar(let movieID):
            return "movie/\(movieID)/similar"
        }
    }
    
    public var method: NetworkMethod { .get }
}
