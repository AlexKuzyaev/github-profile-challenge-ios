//
//  ProfileTableHeaderView.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import UIKit

final class ProfileTableHeaderView: UIView {
    
    private enum Constants {
        static let height: CGFloat = 224.0
        static let inset: CGFloat = 16.0
    }
    
    // MARK: - Private Properties
    
    private var contentView: UIView!
    private var avatarImageView: UIImageView!
    private var nameLabel: UILabel!
    private var usernameLabel: UILabel!
    private var emailLabel: UILabel!
    private var followersButton: UIButton!
    private var followingButton: UIButton!
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func update(profile: ProfileModel) {
        nameLabel.text = profile.name
        nameLabel.addCharacterSpacing(kernValue: 2.4)
        
        usernameLabel.text = profile.username
        emailLabel.text = profile.email
        
        if let url = profile.avatarUrl {
            avatarImageView.load(url: url)
        }
        
        updateFollowersButton(count: profile.followersCount)
        updateFollowingButton(count: profile.followingCount)
    }
}

// MARK: - Private Methods

private extension ProfileTableHeaderView {

    func configureViews() {
        
        configureContentView()
        configureAvatar()
        configureNameLabel()
        configureUsernameLabel()
        configureEmailLabel()
        configureFollowersButton()
        configureFollowingButton()
        
        for subview in contentView.subviews {
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func configureContentView() {
        
        contentView = UIView()
        
        self.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            contentView.topAnchor.constraint(equalTo: self.topAnchor, constant: Constants.inset),
            contentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: Constants.inset),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Constants.inset),
            contentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -Constants.inset),
            contentView.heightAnchor.constraint(equalToConstant: Constants.height - Constants.inset * 2)
        ]

        NSLayoutConstraint.activate(constraints)        
    }
    
    func configureAvatar() {
        
        avatarImageView = UIImageView()
        avatarImageView.layer.cornerRadius = 44.0
        avatarImageView.layer.masksToBounds = true
        
        contentView.addSubview(avatarImageView)
                
        let constraints: [NSLayoutConstraint] = [
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 88.0),
            avatarImageView.widthAnchor.constraint(equalToConstant: 88.0)
        ]

        NSLayoutConstraint.activate(constraints)        
    }
    
    func configureNameLabel() {
        nameLabel = UILabel()
        
        nameLabel.font = UIFont.mainFont(size: 32.0, weight: .bold)
        nameLabel.textColor = UIColor.black
        nameLabel.textAlignment = .left
        
        contentView.addSubview(nameLabel)
                
        let constraints = [
            nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 8.0),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureUsernameLabel() {
        usernameLabel = UILabel()
        
        usernameLabel.font = UIFont.mainFont(size: 16.0, weight: .regular)
        usernameLabel.textColor = UIColor.black
        usernameLabel.textAlignment = .left
        
        contentView.addSubview(usernameLabel)
                
        let constraints = [
            usernameLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor),
            usernameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            usernameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureEmailLabel() {
        emailLabel = UILabel()
        
        emailLabel.font = UIFont.mainFont(size: 16.0, weight: .semibold)
        emailLabel.textColor = UIColor.black
        emailLabel.textAlignment = .left
        
        contentView.addSubview(emailLabel)
                
        let constraints = [
            emailLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            emailLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24.0),
            emailLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            emailLabel.heightAnchor.constraint(equalToConstant: 20.0)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureFollowersButton() {
        followersButton = UIButton()
        followersButton.setTitleColor(.black, for: .normal)
        
        followersButton.titleLabel?.font = UIFont.mainFont(size: 16.0, weight: .semibold)
        
        contentView.addSubview(followersButton)
                
        let constraints = [
            followersButton.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            followersButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 16.0),
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func configureFollowingButton() {
        followingButton = UIButton()
        followingButton.setTitleColor(.black, for: .normal)
        
        followingButton.titleLabel?.font = UIFont.mainFont(size: 16.0, weight: .semibold)
        
        contentView.addSubview(followingButton)
                
        let constraints = [
            followingButton.leftAnchor.constraint(equalTo: followersButton.rightAnchor, constant: 16.0),
            followingButton.centerYAnchor.constraint(equalTo: followersButton.centerYAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func updateFollowersButton(count: Int) {
        
        let countString = String(count)
        
        let attributedString = NSMutableAttributedString(string: "\(countString) followers",
                                                        attributes: [NSAttributedString.Key.font: UIFont.mainFont(size: 16.0,
                                                                                                                  weight: .regular)])
        attributedString.addAttribute(NSAttributedString.Key.font,
                                      value: UIFont.mainFont(size: 16.0,
                                                            weight: .semibold),
                                      range: NSRange(location: 0,
                                                     length: countString.count))
        
        followersButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    func updateFollowingButton(count: Int) {
        
        let countString = String(count)
        
        let attributedString = NSMutableAttributedString(string: "\(countString) following",
                                                        attributes: [NSAttributedString.Key.font: UIFont.mainFont(size: 16.0,
                                                                                                                  weight: .regular)])
        attributedString.addAttribute(NSAttributedString.Key.font,
                                      value: UIFont.mainFont(size: 16.0,
                                                            weight: .semibold),
                                      range: NSRange(location: 0,
                                                     length: countString.count))
        
        followingButton.setAttributedTitle(attributedString, for: .normal)
    }
}
