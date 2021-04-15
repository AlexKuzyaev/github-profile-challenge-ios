//
//  ProfileConfigurator.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import Foundation

final class ProfileConfigurator {
    
    // MARK: Public Methods
    
    func configure() -> ProfileViewController {
        let githubService = GithubService()
        let presenter = ProfilePresenter(githubService: githubService)
        let viewController = ProfileViewController()
        presenter.view = viewController
        viewController.output = presenter
        return viewController
    }
}
