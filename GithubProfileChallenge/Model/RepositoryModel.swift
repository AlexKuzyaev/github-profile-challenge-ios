//
//  RepositoryModel.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import Foundation
import ObjectMapper

final class RepositoryModel: ImmutableMappable {
    
    // MARK: - MappingKeys

    private enum MappingKeys {
        static let username = "owner.login"
        static let avatarUrl = "owner.avatarUrl"
        static let title = "name"
        static let description = "description"
        static let starsCount = "stargazerCount"
        static let languageName = "primaryLanguage.name"
        static let languageColor = "primaryLanguage.color"
    }
    
    // MARK: - Public Properties
    
    let username: String
    let avatarUrlString: String
    let title: String
    let description: String
    let starsCount: Int
    let languageName: String
    let languageColor: String
    
    // MARK: - Computed Properties
    
    var avatarUrl: URL? {
        return URL(string: avatarUrlString)
    }
    
    // MARK: - Init
    
    init(username: String, avatarUrlString: String, title: String, description: String, starsCount: Int, languageName: String, languageColor: String) {
        self.username = username
        self.avatarUrlString = avatarUrlString
        self.title = title
        self.description = description
        self.starsCount = starsCount
        self.languageName = languageName
        self.languageColor = languageColor
    }
    
    // MARK: - ImmutableMappable

    init(map: Map) throws {
        username = try map.value(MappingKeys.username)
        avatarUrlString = try map.value(MappingKeys.avatarUrl)
        title = try map.value(MappingKeys.title)
        description = (try? map.value(MappingKeys.description)) ?? ""
        starsCount = try map.value(MappingKeys.starsCount)
        languageName = (try? map.value(MappingKeys.languageName)) ?? ""
        languageColor = (try map.value(MappingKeys.languageColor)) ?? ""
    }

    func mapping(map: Map) {
        username >>> map[MappingKeys.username]
        avatarUrlString >>> map[MappingKeys.avatarUrl]
        title >>> map[MappingKeys.title]
        description >>> map[MappingKeys.description]
        starsCount >>> map[MappingKeys.starsCount]
        languageName >>> map[MappingKeys.languageName]
        languageColor >>> map[MappingKeys.languageColor]
    }
}
