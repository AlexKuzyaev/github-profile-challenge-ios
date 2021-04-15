//
//  GithubLogin.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 15.04.2021.
//

import Foundation

// MARK: - GithubLogin

enum GithubLogin: String {
    case alexKuzuaev = "AlexKuzyaev"
    case abhisheknaiidu = "abhisheknaiidu"
    case matteocrippa = "matteocrippa"
    case archetapp = "Archetapp"
    case bobuk = "bobuk"
    case yegor256 = "yegor256"
    case etolstoy = "etolstoy"
    case azimin = "azimin"
    
    static let all: [GithubLogin] = [.alexKuzuaev, .abhisheknaiidu, .matteocrippa, .archetapp,
                                     .bobuk, .yegor256, .etolstoy, azimin]
}
