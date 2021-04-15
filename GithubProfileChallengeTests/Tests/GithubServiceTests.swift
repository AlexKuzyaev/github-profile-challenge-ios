//
//  GithubServiceTests.swift
//  GithubProfileChallengeTests
//
//  Created by Alexander Kuzyaev on 14.04.2021.
//

import XCTest
@testable import GithubProfileChallenge

class GithubServiceTests: XCTestCase {
    
    // MARK: - Private Properties
    
    private var loginFactory: GithubLoginFactory!
    private var sut: GithubService!
    
    // MARK: - XCTestCase

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = GithubService()
        loginFactory = GithubLoginFactory()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        loginFactory = nil
    }
    
    // MARK: - Tests

    func testValidLogin() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var tmpResult: Result<ProfileModel, Error> = .failure(CustomError.unknownError)
        let expectation = self.expectation(description: "validLogin")
        
        sut.getProfile(login: loginFactory.produce()) { (result) in
            tmpResult = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        assertIsSuccess(tmpResult)
    }
    
    func testInvalidLogin() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        var tmpResult: Result<ProfileModel, Error> = .success(ProfileModel(name: "", username: "", avatarUrlString: "", email: "", followersCount: 0, followingCount: 0, pinnedRepositories: [], topRepositories: [], starredRepositories: []))
        let expectation = self.expectation(description: "invalidLogin")
        
        sut.getProfile(login: "qwe123!@#") { (result) in
            tmpResult = result
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
        assertIsFailure(tmpResult)
    }
}

// MARK: - Private Methods

private extension GithubServiceTests {
    
    func assertIsSuccess<T, E>(
        _ result: Result<T, E>,
        then assertions: (T) -> Void = { _ in },
        message: (E) -> String = { "Expected to be a success but got a failure with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Error {
        switch result {
        case .failure(let error):
            XCTFail(message(error), file: file, line: line)
        case .success(let value):
            assertions(value)
        }
    }
    
    func assertIsFailure<T, E>(
        _ result: Result<T, E>,
        then assertions: (E) -> Void = { _ in },
        message: (T) -> String = { "Expected to be a failure but got a success with \($0) "},
        file: StaticString = #filePath,
        line: UInt = #line
    ) where E: Error {
        switch result {
        case .failure(let error):
            assertions(error)
        case .success(let value):
            XCTFail(message(value), file: file, line: line)
        }
    }
}
