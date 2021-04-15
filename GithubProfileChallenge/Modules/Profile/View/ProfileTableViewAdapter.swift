//
//  ProfileTableViewAdapter.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import UIKit

// MARK: - Section Enum

private enum Section: Int {
    case pinned
    case top
    case starred
}

private extension Section {
    static let all: [Section] = [.pinned, .top, .starred]
}

// MARK: - ProfileTableViewAdapter

final class ProfileTableViewAdapter: NSObject {
    
    // MARK: - Constants

    private enum Constants {
        static let baseCellHeight: CGFloat = 164.0
        static let inset: CGFloat = 16.0
        static let headerHeight: CGFloat = 32.0
    }
    
    // MARK: - Public Properties
    
    weak var tableView: UITableView?
    var refreshAction: EmptyClosure?
    var viewAllPinnedAction: EmptyClosure?
    var viewAllTopAction: EmptyClosure?
    var viewAllStarredAction: EmptyClosure?
    
    // MARK: - Private Properties
    
    private var profile: ProfileModel?
    private var sections: [Section] = []
    
    private var headerView: ProfileTableHeaderView!
    private var refreshControl: UIRefreshControl!
    
    // MARK: - Init
    
    init(tableView: UITableView) {
        super.init()
        self.tableView = tableView
        configureTableView()
    }
    
    // MARK: - Public Methods
    
    func update(profile: ProfileModel) {
        self.profile = profile
        
        headerView.update(profile: profile)
        
        sections = []
        
        if !profile.pinnedRepositories.isEmpty {
            sections.append(.pinned)
        }
        if !profile.topRepositories.isEmpty {
            sections.append(.top)
        }
        if !profile.starredRepositories.isEmpty {
            sections.append(.starred)
        }
                
        tableView?.reloadData()
        
        refreshControl.endRefreshing()
        tableView?.setContentOffset(CGPoint.zero, animated: true)
    }
}

// MARK: - Private Methods

private extension ProfileTableViewAdapter {
    
    func configureTableView() {
        
        headerView = ProfileTableHeaderView()
        tableView?.tableHeaderView = headerView
        
        tableView?.backgroundColor = .white
        tableView?.separatorColor = .clear
        tableView?.showsVerticalScrollIndicator = false
        tableView?.allowsSelection = false
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView?.addSubview(refreshControl)
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(RepositoriesTableViewCell.self,
                            forCellReuseIdentifier: String(describing: RepositoriesTableViewCell.self))
    }
    
    @objc func refresh() {
        refreshAction?()
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource

extension ProfileTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let profile = profile else {
            return UITableViewCell()
        }
        
        switch sections[indexPath.section] {
            case .pinned:
                let cell = RepositoriesTableViewCell(type: .vertical)
                cell.update(repositories: profile.pinnedRepositories)
                return cell
            case .top:
                let cell = RepositoriesTableViewCell(type: .horizontal)
                cell.update(repositories: profile.topRepositories)
                return cell
            case .starred:
                let cell = RepositoriesTableViewCell(type: .horizontal)
                cell.update(repositories: profile.starredRepositories)
                return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                
        switch sections[indexPath.section] {
            case .pinned:
                if let count = profile?.pinnedRepositories.count {
                    let countFloat: CGFloat = CGFloat(count)
                    let insetsCount: CGFloat = countFloat + 1.0
                    return Constants.baseCellHeight * countFloat + Constants.inset * insetsCount
                }
                return 0.0
            case .top:
                let insetCount: CGFloat = 2.0
                return Constants.baseCellHeight + Constants.inset * insetCount
            case .starred:
                let insetCount: CGFloat = 2.0
                return Constants.baseCellHeight + Constants.inset * insetCount
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = ProfileSectionHeaderView()
        
        switch sections[section] {
            case .pinned:
                view.update(title: "Pinned")
                view.viewAllAction = viewAllPinnedAction
            case .top:
                view.update(title: "Top repositories")
                view.viewAllAction = viewAllTopAction
            case .starred:
                view.update(title: "Starred repositories")
                view.viewAllAction = viewAllStarredAction
        }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.headerHeight
    }
}
