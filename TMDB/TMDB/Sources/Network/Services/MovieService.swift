//
//  HomeService.swift
//  TMDB
//
//  Created by Luann Marques Luna on 19/02/21.
//

import Foundation

public typealias MovieCallback = (Result<MovieQueryResult, NetworkError>) -> Void

public protocol MovieServiceProtocol {
    func fetchMovieData(callback: @escaping MovieCallback)
}

public class MovieService: MovieServiceProtocol {
    
    private var network: NetworkProtocolType
    var query: MovieQuery
    
    public init(network: NetworkProtocolType = Network.shared, query: MovieQuery) {
        self.network = network
        self.query = query
    }
    
    public func fetchMovieData(callback: @escaping MovieCallback) {
        network.call(query, MovieQueryResult.self) { result in
            switch result  {
            case .success(let response):
                callback(.success(response))
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
}
