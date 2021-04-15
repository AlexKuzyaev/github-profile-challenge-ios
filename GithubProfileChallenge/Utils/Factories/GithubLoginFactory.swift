//
//  GithubProfileFactory.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 14.04.2021.
//

import Foundation

final class GithubLoginFactory {
    
    // MARK: - Public Methods
    
    func produce() -> String {
        return GithubLogin.all.randomElement()?.rawValue ?? ""
    }
}
