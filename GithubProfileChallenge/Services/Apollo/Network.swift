//
//  Network.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 12.04.2021.
//

import Foundation
import Apollo
import ApolloSQLite

final class Network {
    
    // MARK: - Constants
    
    private enum Constants {
        static let token = "bearer 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"
        static let api = "https://api.github.com/graphql"
        
        enum HTTPHeaders {
            static let authorization = "Authorization"
        }
    }
    
    // MARK: - Static Properties
    
    static let shared = Network()
    
    // MARK: - Properties

    let cacheManager = NetworkCacheManager()
    
    private(set) lazy var apollo: ApolloClient = {
        let cache = NetworkCacheManager.getSQLiteCache()
        let store = ApolloStore(cache: cache)

        let client = URLSessionClient()
        let provider = NetworkInterceptorProvider(store: store, client: client)
        let url = URL(string: Constants.api)!
        let additionalHeaders = [Constants.HTTPHeaders.authorization: Constants.token]

        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url,
                                                                 additionalHeaders: additionalHeaders)
                                                               
        return ApolloClient(networkTransport: requestChainTransport,
                            store: store)
  }()
}
