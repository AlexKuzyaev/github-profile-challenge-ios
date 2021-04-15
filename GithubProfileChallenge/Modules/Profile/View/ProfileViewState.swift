//
//  ProfileViewState.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 14.04.2021.
//

import Foundation

enum ProfileViewState {
    case profile(_ profile: ProfileModel)
    case loading
    case error(_ error: Error)
}
