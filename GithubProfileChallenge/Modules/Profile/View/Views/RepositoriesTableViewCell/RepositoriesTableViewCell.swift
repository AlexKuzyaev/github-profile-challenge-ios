//
//  RepositoriesTableViewCell.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell {
    
    // MARK: - Constants

    private enum Constants {
        static let inset: CGFloat = 16.0
        static let cellHeight: CGFloat = 164.0
        static let horizontalCellWidth: CGFloat = 200.0
    }
    
    // MARK: - RepositoriesCellType
    
    enum RepositoriesCellType {
        case vertical
        case horizontal
    }
    
    // MARK: - Private Properties
    
    private var type: RepositoriesCellType!
    private var collectionView: UICollectionView!
    private var repositories: [RepositoryModel] = []
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(type: RepositoriesCellType) {
        self.init(frame: CGRect.zero)
        self.type = type
        configureViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func update(repositories: [RepositoryModel]) {
        self.repositories = repositories
        collectionView.reloadData()
    }
}

// MARK: - Private Methods

private extension RepositoriesTableViewCell {
    
    func configureViews() {
        configureCollectionView()
    }
    
    func configureCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = type == .vertical ? .vertical : .horizontal
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.contentInset = UIEdgeInsets(top: 0.0, left: Constants.inset,
                                                   bottom: 0.0, right: Constants.inset)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = type == .horizontal
        collectionView.backgroundColor = .clear
        collectionView.register(RepositoryCollectionCell.self,
                                forCellWithReuseIdentifier: String(describing: RepositoryCollectionCell.self))
        
        contentView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
                
        let constraints: [NSLayoutConstraint] = [
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.inset),
            collectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.inset),
            collectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension RepositoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RepositoryCollectionCell.self),
                                                          for: indexPath) as? RepositoryCollectionCell
        else {
            return UICollectionViewCell()
        }
        cell.update(repository: repositories[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension RepositoriesTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = type == .vertical ? UIScreen.main.bounds.width - Constants.inset * 2 : Constants.horizontalCellWidth
        return CGSize(width: width, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.inset
    }
}
