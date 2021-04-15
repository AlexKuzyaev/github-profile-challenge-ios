//
//  UIFont.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import UIKit

extension UIFont {
    
    // MARK: - Class Methods
    
    class func mainFont(size: CGFloat, weight: UIFont.Weight) -> UIFont {
        switch weight {
        case .bold:
            return UIFont(name: Fonts.bold, size: size)!
        case .semibold:
            return UIFont(name: Fonts.semibold, size: size)!
        default:
            return UIFont(name: Fonts.regular, size: size)!
        }
    }
}

// MARK: - Private Methods

private extension UIFont {
    
    private func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]

        traits[.weight] = weight

        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName

        let descriptor = UIFontDescriptor(fontAttributes: attributes)

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

