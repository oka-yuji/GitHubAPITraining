//
//  SearchRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by 岡優志 on 2021/05/16.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol SearchRequestProtocol {
    func cancel()
    func search(keyword: String, completionHandler: @escaping (Result<RepositoryResponse, Error>) -> Void)
}

final class SearchRequestImpl: SearchRequestProtocol {
    private var task: URLSessionTask?
    
    func cancel() {
        task?.cancel()
    }
    
    func search(keyword: String, completionHandler: @escaping (Result<RepositoryResponse, Error>) -> Void) {
        let url = "https://api.github.com/search/repositories?q=\(keyword)"
          task = URLSession.shared.dataTask(with: URL(string: url)!) { (data, res, err) in
              if let data = data {
                  let jsonDecoder = JSONDecoder()
                  jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                  do {
                      let response: RepositoryResponse = try jsonDecoder.decode(RepositoryResponse.self, from: data)
                      DispatchQueue.main.async {
                        completionHandler(.success(response))
                      }
                  } catch {
                    DispatchQueue.main.async {
                        completionHandler(.failure(error))
                    }
                  }
              } else if let error = err {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
              }
          }
      // これ呼ばなきゃリストが更新されません
      task?.resume()
    }
}
