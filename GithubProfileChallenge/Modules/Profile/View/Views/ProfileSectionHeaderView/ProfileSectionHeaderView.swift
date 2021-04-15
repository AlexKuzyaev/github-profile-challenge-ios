//
//  ProfileSectionHeaderView.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import UIKit

final class ProfileSectionHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Private Properties
    
    private var titleLabel: UILabel!
    private var viewAllButton: UIButton!
    
    // MARK: - Public Properties
    
    var viewAllAction: EmptyClosure?
    
    // MARK: - Init
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func update(title: String) {
        titleLabel.text = title
        titleLabel.addCharacterSpacing(kernValue: 1.6)
    }
}

// MARK: - Private Methods

private extension ProfileSectionHeaderView {
    
    func configureViews() {
        configureTitle()
        configureViewAllButton()
        
        for subview in subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func configureTitle() {
        titleLabel = UILabel()
        
        titleLabel.font = UIFont.mainFont(size: 24.0, weight: .bold)
        titleLabel.textColor = UIColor.black
        titleLabel.textAlignment = .left
        
        self.addSubview(titleLabel)
                
        let constraints = [
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16.0),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureViewAllButton() {
        viewAllButton = UIButton()
        viewAllButton.addTarget(self, action: #selector(viewAllButtonTapped), for: .touchUpInside)
        viewAllButton.setTitle("View all", for: .normal)
        viewAllButton.setTitleColor(.black, for: .normal)
        
        viewAllButton.titleLabel?.font = UIFont.mainFont(size: 16.0, weight: .semibold)
        viewAllButton.underline()
        
        self.addSubview(viewAllButton)
                
        let constraints = [
            viewAllButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 10.0),
            viewAllButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16.0),
            viewAllButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            viewAllButton.widthAnchor.constraint(equalToConstant: 57.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func viewAllButtonTapped() {
        viewAllAction?()
    }
}
