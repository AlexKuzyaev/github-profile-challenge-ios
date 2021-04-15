//
//  ProfileModel.swift
//  GithubProfileChallenge
//
//  Created by Alexander Kuzyaev on 11.04.2021.
//

import Foundation
import ObjectMapper

final public class ProfileModel: ImmutableMappable {
    
    // MARK: - MappingKeys

    private enum MappingKeys {
        static let name = "name"
        static let username = "login"
        static let avatarUrl = "avatarUrl"
        static let email = "email"
        static let followersCount = "followers.totalCount"
        static let followingCount = "following.totalCount"
        static let pinnedRepositories = "pinnedItems.nodes"
        static let topRepositories = "topRepositories.nodes"
        static let starredRepositories = "starredRepositories.nodes"
    }
    
    // MARK: - Public Properties
    
    var name: String
    var username: String
    var avatarUrlString: String
    var email: String
    var followersCount: Int
    var followingCount: Int
    var pinnedRepositories: [RepositoryModel]
    var topRepositories: [RepositoryModel]
    var starredRepositories: [RepositoryModel]
    
    // MARK: - Computed Properties
    
    var avatarUrl: URL? {
        return URL(string: avatarUrlString)
    }
    
    // MARK: - Init
    
    internal init(name: String, username: String, avatarUrlString: String, email: String, followersCount: Int, followingCount: Int, pinnedRepositories: [RepositoryModel], topRepositories: [RepositoryModel], starredRepositories: [RepositoryModel]) {
        self.name = name
        self.username = username
        self.avatarUrlString = avatarUrlString
        self.email = email
        self.followersCount = followersCount
        self.followingCount = followingCount
        self.pinnedRepositories = pinnedRepositories
        self.topRepositories = topRepositories
        self.starredRepositories = starredRepositories
    }
    
    // MARK: - ImmutableMappable

    public init(map: Map) throws {
        name = try map.value(MappingKeys.name)
        username = try map.value(MappingKeys.username)
        avatarUrlString = try map.value(MappingKeys.avatarUrl)
        email = try map.value(MappingKeys.email)
        followersCount = try map.value(MappingKeys.followersCount)
        followingCount = try map.value(MappingKeys.followingCount)
        pinnedRepositories = try map.value(MappingKeys.pinnedRepositories)
        topRepositories = try map.value(MappingKeys.topRepositories)
        starredRepositories = try map.value(MappingKeys.starredRepositories)
    }

    public func mapping(map: Map) {
        name >>> map[MappingKeys.name]
        username >>> map[MappingKeys.username]
        avatarUrlString >>> map[MappingKeys.avatarUrl]
        email >>> map[MappingKeys.email]
        followersCount >>> map[MappingKeys.followersCount]
        followingCount >>> map[MappingKeys.followingCount]
        pinnedRepositories >>> map[MappingKeys.pinnedRepositories]
        topRepositories >>> map[MappingKeys.topRepositories]
        starredRepositories >>> map[MappingKeys.starredRepositories]
    }
}
