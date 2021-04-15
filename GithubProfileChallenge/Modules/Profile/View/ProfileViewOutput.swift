//
//  ProfileViewOutput.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 12.04.2021.
//

import Foundation

protocol ProfileViewOutput: class {
    func viewDidAppear()
    func fetchProfile()
    func viewAllPinnedTapped()
    func viewAllTopTapped()
    func viewAllStarredTapped()
}
