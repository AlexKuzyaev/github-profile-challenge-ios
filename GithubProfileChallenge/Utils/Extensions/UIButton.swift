//
//  UIButton.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 13.04.2021.
//

import UIKit

extension UIButton {
    
    // MARK: - Public Methods
    
    func underline() {
        guard let text = self.titleLabel?.text else { return }
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttribute(NSAttributedString.Key.underlineColor,
                                      value: self.titleColor(for: .normal)!,
                                      range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor,
                                      value: self.titleColor(for: .normal)!,
                                      range: NSRange(location: 0, length: text.count))
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: text.count))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
