//
//  NetworkCacheManager.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 14.04.2021.
//

import Foundation
import ApolloSQLite

final class NetworkCacheManager {
    
    // MARK: - Constants
    
    private enum Constants {
        static let cacheLifetime: Double = 24.0 * 60.0 * 60.0 // 24 hours in seconds
        static let sqliteName: String = "github_profile_challenge.sqlite"
    }
    
    // MARK: - Static Methods
        
    static func getSQLiteCache() -> SQLiteNormalizedCache {
        let documentsPath = NSSearchPathForDirectoriesInDomains(
            .documentDirectory,
            .userDomainMask,
            true).first!
        let documentsURL = URL(fileURLWithPath: documentsPath)
        let sqliteFileURL = documentsURL.appendingPathComponent(Constants.sqliteName)

        let sqliteCache = try! SQLiteNormalizedCache(fileURL: sqliteFileURL)
        return sqliteCache
    }
    
    // MARK: - Public Methods
    
    func setCacheTime(time: Double?) {
        UserDefaults.standard.apolloCacheSetTime = time
    }
    
    func updateCachePolicy() {
        guard let cacheTime = UserDefaults.standard.apolloCacheSetTime else {
            return
        }
        
        let currentTime: Double = Date().timeIntervalSince1970
        if currentTime - cacheTime > Constants.cacheLifetime {
            setCacheTime(time: nil)
            Network.shared.apollo.clearCache()
        }
    }
}
