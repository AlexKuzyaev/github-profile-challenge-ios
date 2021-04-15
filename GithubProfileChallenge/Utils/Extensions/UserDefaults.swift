//
//  UserDefaults.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 14.04.2021.
//

import Foundation

extension UserDefaults {

    // MARK: - Apollo cache set time

    var apolloCacheSetTime: Double? {
        get { return value(forKey: #function) as? Double }
        set { set(newValue, forKey: #function) }
    }
}
