//
//  UILabel.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 14.04.2021.
//

import UIKit

extension UILabel {
    
    // MARK: - Public Methods
    
  func addCharacterSpacing(kernValue: Double) {
    
    guard let labelText = text, labelText.count > 0 else {
        return
    }
    
    let attributedString = NSMutableAttributedString(string: labelText)
    attributedString.addAttribute(NSAttributedString.Key.kern,
                                  value: kernValue,
                                  range: NSRange(location: 0, length: attributedString.length - 1))
    attributedText = attributedString
  }
}
