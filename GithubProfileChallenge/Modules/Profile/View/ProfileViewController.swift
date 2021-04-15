//
//  ViewController.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import UIKit

final class ProfileViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var output: ProfileViewOutput?
    
    // MARK: - Private Properties

    private var tableView: UITableView!
    private var adapter: ProfileTableViewAdapter!
    private var loadingAlert: UIAlertController!
    private var errorAlert: UIAlertController!
    
    // MARK: - UIViewController Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.viewDidAppear()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // table header view fix for iOS 11

        if let headerView = tableView.tableHeaderView {

            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame

            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
}

// MARK: - ProfileViewInput

extension ProfileViewController: ProfileViewInput {
    
    func update(state: ProfileViewState) {
        switch state {
        case .profile(let profile):
            loadingAlert.dismiss(animated: true, completion: nil)
            update(for: profile)
        case .loading:
            present(loadingAlert, animated: true, completion: nil)
        case .error(let error):
            errorAlert.message = error.localizedDescription
            loadingAlert.dismiss(animated: true) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.present(self.errorAlert, animated: true, completion: nil)
                }
            }
        }
    }
}

// MARK: - Private Methods

private extension ProfileViewController {
    
    func configureView() {
        
        title = "Profile"
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureTableView()

        configureLoadingAlert()
        configureErrorAlert()
    }
    
    func configureNavigationBar() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black,
                                                                        .font: UIFont.mainFont(size: 20.0,
                                                                                               weight: .bold),
                                                                        .kern: 1.33]
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func configureLoadingAlert() {
        loadingAlert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)

        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5,
                                                                     width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();

        loadingAlert.view.addSubview(loadingIndicator)
    }
    
    func configureErrorAlert() {
        errorAlert = UIAlertController(title: "Error", message: "", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        errorAlert.addAction(okAction)
        
        let retryAction = UIAlertAction(title: "Retry", style: .default) { (_) in
            DispatchQueue.main.async { [weak self] in
                self?.errorAlert.dismiss(animated: true, completion: nil)
                self?.output?.fetchProfile()
            }
        }
        errorAlert.addAction(retryAction)
    }
    
    func configureTableView() {
        
        tableView = UITableView(frame: CGRect.zero, style: .grouped)
        adapter = ProfileTableViewAdapter(tableView: tableView)
        
        adapter.refreshAction = { [weak self] in
            self?.output?.fetchProfile()
        }
        
        adapter.viewAllPinnedAction = { [weak self] in
            self?.output?.viewAllPinnedTapped()
        }
        
        adapter.viewAllTopAction = { [weak self] in
            self?.output?.viewAllTopTapped()
        }
        
        adapter.viewAllStarredAction = { [weak self] in
            self?.output?.viewAllStarredTapped()
        }
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let guide = view.safeAreaLayoutGuide

        let constraints = [
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor,
                                           multiplier: 1.0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func update(for profile: ProfileModel) {
        adapter.update(profile: profile)
    }
}

