//
//  SearchViewControllerTest.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 岡優志 on 2021/05/16.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck
import XCTest

final class SearchViewControllerTest: XCTestCase {
    func test正しく検索が実行される() {
        let navigationController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! UINavigationController
        let searchViewController = navigationController.viewControllers.first as! SearchViewController
        searchViewController.loadViewIfNeeded()
        
        let request = SearchRequestSpy()
        searchViewController.searchRequest = request
        
        XCTAssertFalse(request.invokedSearch)
        
        searchViewController.searchBar.text = "Swift"
        searchViewController.searchBarSearchButtonClicked(searchViewController.searchBar)
        
        XCTAssertTrue(request.invokedSearch)
        XCTAssertEqual(request.invokedKeyword, "Swift")
    }
    
    func testKeywordIsNil() {
        let navigationController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! UINavigationController
        let searchViewController = navigationController.viewControllers.first as! SearchViewController
        searchViewController.loadViewIfNeeded()
        
        let request = SearchRequestSpy()
        searchViewController.searchRequest = request
        
        XCTAssertFalse(request.invokedSearch)
        
        searchViewController.searchBar.text = nil
        searchViewController.searchBarSearchButtonClicked(searchViewController.searchBar)
        
        XCTAssertFalse(request.invokedSearch)
        XCTAssertNil(request.invokedKeyword)
    }
    
    func testResponseSuccess() {
        let navigationController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController() as! UINavigationController
        let searchViewController = navigationController.viewControllers.first as! SearchViewController
        searchViewController.loadViewIfNeeded()
        
        let request = SearchRequestSpy()
        let entity = RepositoryEntity(language: "Swift",
                           stargazersCount: 999,
                           wachersCount: 500,
                           forksCount: 300,
                           openIssuesCount: 777,
                           fullName: "shu223",
                           owner: .init(avatarUrl: URL(string: "https://example.com/")!)
                           )
        request.stubbedResponse = RepositoryResponse(items: [
            entity
        ])
        searchViewController.searchRequest = request
        
        XCTAssertFalse(request.invokedSearch)
        XCTAssertEqual(searchViewController.repositories, [])
        
        searchViewController.searchBar.text = "Swift"
        searchViewController.searchBarSearchButtonClicked(searchViewController.searchBar)
        
        XCTAssertTrue(request.invokedSearch)
        XCTAssertEqual(request.invokedKeyword, "Swift")
        XCTAssertEqual(searchViewController.repositories, [entity])
    }
}
