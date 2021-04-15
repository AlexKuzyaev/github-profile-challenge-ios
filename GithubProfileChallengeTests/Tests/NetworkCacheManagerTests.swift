//
//  NetworkCacheManagerTests.swift
//  GithubProfileChallengeTests
//
//  Created by Alexander Kuzyaev on 14.04.2021.
//

import XCTest
@testable import GithubProfileChallenge

class NetworkCacheManagerTests: XCTestCase {
    
    // MARK: - Constants
    
    private enum Constants {
        static let day: Double = 24 * 60 * 60
    }
    
    // MARK: - Private Properties
    
    private var sut: NetworkCacheManager!
    
    // MARK: - XCTestCase

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = NetworkCacheManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    // MARK: - Tests

    func testLessThanOneDayCache() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        sut.setCacheTime(time: Date().timeIntervalSince1970 - Constants.day / 2.0)
        
        sut.updateCachePolicy()
        
        XCTAssert(UserDefaults.standard.apolloCacheSetTime != nil, "apolloCacheSetTime must not be nil")
    }
    
    func testMoreThanOneDayCache() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        sut.setCacheTime(time: Date().timeIntervalSince1970 - Constants.day * 2)
        
        sut.updateCachePolicy()
        
        XCTAssert(UserDefaults.standard.apolloCacheSetTime == nil, "apolloCacheSetTime must be nil")
    }
}
