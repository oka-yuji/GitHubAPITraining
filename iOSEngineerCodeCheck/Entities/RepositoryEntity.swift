//
//  RepositoryEntity.swift
//  iOSEngineerCodeCheck
//
//  Created by 岡優志 on 2021/05/16.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

struct RepositoryResponse: Codable, Hashable {
    let items: [RepositoryEntity]
}

struct RepositoryEntity: Codable, Hashable {
    let language: String?
    let stargazersCount: Int?
    let wachersCount: Int?
    let forksCount: Int?
    let openIssuesCount: Int?
    let fullName: String?
    let owner: Owner?
    
    struct Owner: Codable, Hashable {
        let avatarUrl: URL?
    }
}
