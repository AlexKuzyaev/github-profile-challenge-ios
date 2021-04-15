//
//  ProfilePresenter.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import Foundation

final class ProfilePresenter {
    
    // MARK: - Public Properties
    
    weak var view: ProfileViewInput?
    
    // MARK: - Private Properties
    
    private var githubService: GithubService
    
    // MARK: - Init
    
    init(githubService: GithubService) {
        self.githubService = githubService        
    }
}

// MARK: - ProfileViewOutput

extension ProfilePresenter: ProfileViewOutput {
    
    func viewDidAppear() {
        fetchProfile()
    }
    
    func fetchProfile() {
        view?.update(state: .loading)
        
        let login = GithubLogin.yegor256.rawValue
        
        // Uncomment to fetch different profile on each PTR
//        let login = GithubLoginFactory().produce()
        
        githubService.getProfile(login: login) { result in
            switch result {
              case .success(let profile):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.update(state: .profile(profile))
                }
              case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.view?.update(state: .error(error))
                }
            }
        }
    }
    
    func viewAllPinnedTapped() {
        print("viewAllPinnedTapped")
    }
    
    func viewAllTopTapped() {
        print("viewAllTopTapped")
    }
    
    func viewAllStarredTapped() {
        print("viewAllStarredTapped")
    }
}
