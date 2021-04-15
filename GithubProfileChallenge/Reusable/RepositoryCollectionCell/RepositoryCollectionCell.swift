//
//  RepositoryCollectionCell.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import UIKit

final class RepositoryCollectionCell: UICollectionViewCell {
    
    // MARK: - Constants

    private enum Constants {
        static let inset: CGFloat = 16.0
        static let height: CGFloat = 164.0
    }
    
    // MARK: - Private Properties
    
    private var cellContentView: UIView!
    private var avatarImageView: UIImageView!
    private var usernameLabel: UILabel!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var starsImageView: UIImageView!
    private var starsLabel: UILabel!
    private var languageView: UIView!
    private var languageLabel: UILabel!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func update(repository: RepositoryModel) {
        usernameLabel.text = repository.username
        titleLabel.text = repository.title
        descriptionLabel.text = repository.description
        starsLabel.text = String(repository.starsCount)
        languageView.backgroundColor = UIColor(hex: repository.languageColor)
        languageLabel.text = repository.languageName
        
        if let url = repository.avatarUrl {
            avatarImageView.load(url: url)
        }
    }
}

// MARK: - Private Methods

private extension RepositoryCollectionCell {
    
    func configureViews() {
        configureContentView()
        configureCellContentView()
        configureAvatar()
        configureUsernameLabel()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStarsImageView()
        configureStarsLabel()
        configureLanguageView()
        configureLanguageLabel()
        
        for subview in cellContentView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func configureContentView() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor(red: 0.8, green: 0.8,
                                                blue: 0.8, alpha: 1).cgColor
    }
    
    func configureCellContentView() {
        
        cellContentView = UIView()
        
        contentView.addSubview(cellContentView)
        
        cellContentView.translatesAutoresizingMaskIntoConstraints = false
                
        let constraints: [NSLayoutConstraint] = [
            cellContentView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.inset),
            cellContentView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.inset),
            cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.inset),
            cellContentView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.inset),
            cellContentView.heightAnchor.constraint(equalToConstant: Constants.height - Constants.inset * 2)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureAvatar() {
        
        avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = 16.0
        avatarImageView.layer.masksToBounds = true
        
        cellContentView.addSubview(avatarImageView)
                
        let constraints: [NSLayoutConstraint] = [
            avatarImageView.topAnchor.constraint(equalTo: cellContentView.topAnchor),
            avatarImageView.leftAnchor.constraint(equalTo: cellContentView.leftAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 32.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 32.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureUsernameLabel() {
        usernameLabel = UILabel()
        
        usernameLabel.font = UIFont.mainFont(size: 16.0, weight: .regular)
        usernameLabel.textColor = UIColor.black
        usernameLabel.textAlignment = .left
        
        cellContentView.addSubview(usernameLabel)
                
        let constraints = [
            usernameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 7.0),
            usernameLabel.rightAnchor.constraint(equalTo: cellContentView.rightAnchor),
            usernameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureTitleLabel() {
        titleLabel = UILabel()
        
        titleLabel.font = UIFont.mainFont(size: 16.0, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
        
        cellContentView.addSubview(titleLabel)
                
        let constraints = [
            titleLabel.leftAnchor.constraint(equalTo: cellContentView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: cellContentView.rightAnchor),
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 4.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureDescriptionLabel() {
        descriptionLabel = UILabel()
        
        descriptionLabel.font = UIFont.mainFont(size: 16.0, weight: .regular)
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .left
        
        cellContentView.addSubview(descriptionLabel)
                
        let constraints = [
            descriptionLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureStarsImageView() {
        starsImageView = UIImageView()
        
        starsImageView.image = UIImage(named: "star")
        
        cellContentView.addSubview(starsImageView)
                
        let constraints = [
            starsImageView.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor),
            starsImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 22.0),
            starsImageView.heightAnchor.constraint(equalToConstant: 12.0),
            starsImageView.widthAnchor.constraint(equalToConstant: 12.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureStarsLabel() {
        starsLabel = UILabel()
        
        starsLabel.font = UIFont.mainFont(size: 16.0, weight: .regular)
        starsLabel.textColor = .black
        starsLabel.textAlignment = .left
        
        cellContentView.addSubview(starsLabel)
                
        let constraints = [
            starsLabel.leftAnchor.constraint(equalTo: starsImageView.rightAnchor, constant: 4.0),
            starsLabel.centerYAnchor.constraint(equalTo: starsImageView.centerYAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    // Language
    
    func configureLanguageView() {
        languageView = UIView()
        
        let width: CGFloat = 10.0
        
        languageView.layer.cornerRadius = width / 2.0
        
        cellContentView.addSubview(languageView)
                
        let constraints = [
            languageView.leftAnchor.constraint(equalTo: starsLabel.rightAnchor, constant: 24.0),
            languageView.centerYAnchor.constraint(equalTo: starsImageView.centerYAnchor),
            languageView.heightAnchor.constraint(equalToConstant: width),
            languageView.widthAnchor.constraint(equalToConstant: width)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureLanguageLabel() {
        languageLabel = UILabel()
        
        languageLabel.font = UIFont.mainFont(size: 16.0, weight: .regular)
        languageLabel.textColor = .black
        languageLabel.textAlignment = .left
        
        cellContentView.addSubview(languageLabel)
                
        let constraints = [
            languageLabel.leftAnchor.constraint(equalTo: languageView.rightAnchor, constant: 4.0),
            languageLabel.rightAnchor.constraint(lessThanOrEqualTo: cellContentView.rightAnchor, constant: 0.0),
            languageLabel.centerYAnchor.constraint(equalTo: languageView.centerYAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
