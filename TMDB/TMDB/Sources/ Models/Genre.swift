//
//  Genre.swift
//
//  Created by Luann Marques Luna on 18/02/21.
//

import Foundation

public class GenreQueryResult: Codable {
    let genres: [Genre]
}

public class Genre: Codable {
    let id: Int
    let name: String
}
