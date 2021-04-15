//
//  UIImageView.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 13.04.2021.
//

import UIKit

extension UIImageView {
    
    // MARK: - Public Methods

    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard
                let data = try? Data(contentsOf: url),
                let image = UIImage(data: data)
            else {
                return
            }
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
