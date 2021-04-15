//
//  ProfileViewInput.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 12.04.2021.
//

import Foundation

protocol ProfileViewInput: class {
    func update(state: ProfileViewState)
}
