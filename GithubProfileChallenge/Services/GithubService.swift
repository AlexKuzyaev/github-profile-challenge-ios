//
//  GithubService.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import Foundation

final class GithubService {
    
    // MARK: - Constants

    private enum Constants {
        static let userKey: String = "user"
    }
    
    // MARK: - Public Methodz
    
    func getProfile(login: String, completion: @escaping ProfileModelResult) {
        
        Network.shared.cacheManager.updateCachePolicy()
        
        Network.shared.apollo.fetch(query: GetUserQuery(login: login)) { result in
            switch result {
              case .success(let graphQLResult):
                if let data = graphQLResult.data {
                    guard
                        let userData = data.jsonObject[Constants.userKey] as? [String: Any],
                        let profile = try? ProfileModel(JSON: userData)
                    else {
                        completion(.failure(CustomError.unknownError))
                        return
                    }
                    if graphQLResult.source == .server {
                        Network.shared.cacheManager.setCacheTime(time: Date().timeIntervalSince1970)
                    }
                    completion(.success(profile))
                } else if let errors = graphQLResult.errors {
                    print(errors)
                    if let first = errors.first {
                        completion(.failure(first))
                    } else {
                        completion(.failure(CustomError.unknownError))
                    }
                }
              case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
