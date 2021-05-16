//
//  SearchRequestSpy.swift
//  iOSEngineerCodeCheckTests
//
//  Created by 岡優志 on 2021/05/16.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

@testable import iOSEngineerCodeCheck

final class SearchRequestSpy: SearchRequestProtocol {
    var invokedCancel: Bool = false
    func cancel() {
        invokedCancel = true
    }
    
    var invokedSearch: Bool = false
    var invokedKeyword: String?
    var stubbedResponse: RepositoryResponse?
    var stubbedError: Error?
    
    func search(keyword: String, completionHandler: @escaping (Result<RepositoryResponse, Error>) -> Void) {
        invokedSearch = true
        invokedKeyword = keyword
        if let stubbedResponse = stubbedResponse {
            completionHandler(.success(stubbedResponse))
        } else if let error = stubbedError {
            completionHandler(.failure(error))
        }
    }
}
