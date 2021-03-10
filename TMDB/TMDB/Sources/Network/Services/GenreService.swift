//
//  GenreService.swift
//  TMDB
//
//  Created by Luann Marques Luna on 21/02/21.
//

import Foundation

public typealias GenreCallback = (Result<GenreQueryResult, NetworkError>) -> Void

public protocol GenreServiceProtocol {
    func fetchGenreData(callback: @escaping GenreCallback)
}

public class GenreService: GenreServiceProtocol {
    private var network: NetworkProtocolType
    
    public init(network: NetworkProtocolType = Network.shared) {
        self.network = network
    }
    
    public func fetchGenreData(callback: @escaping GenreCallback) {
        let query: GenreQuery = .movie
        network.call(query, GenreQueryResult.self) { result in
            switch result {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
