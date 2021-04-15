//
//  NetworkInterceptorProvider.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 14.04.2021.
//

import Apollo

struct NetworkInterceptorProvider: InterceptorProvider {
    
    // MARK: - Private Properties
    
    private let store: ApolloStore
    private let client: URLSessionClient
    
    // MARK: - Init
    
    init(store: ApolloStore,
         client: URLSessionClient) {
        self.store = store
        self.client = client
    }
    
    // MARK: - Public Methods
    
    func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        return [
            MaxRetryInterceptor(),
            LegacyCacheReadInterceptor(store: self.store),
            NetworkFetchInterceptor(client: self.client),
            ResponseCodeInterceptor(),
            LegacyParsingInterceptor(cacheKeyForObject: self.store.cacheKeyForObject),
            AutomaticPersistedQueryInterceptor(),
            LegacyCacheWriteInterceptor(store: self.store)
        ]
    }
}
