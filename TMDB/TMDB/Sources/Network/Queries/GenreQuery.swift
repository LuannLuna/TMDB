//
//  GenreQuery.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import Foundation

enum GenreQuery: RestQuery {
    case movie
    case tv
    
    var path: String {
        switch self {
        case .movie:
            return "genre/movie/list"
        case .tv:
            return "genre/tv/list"
        }
    }
    
    var method: NetworkMethod { .get }
}
