//
//  NYTAPIClient.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTApiClient {
    static func getTopics(completion: @escaping (Result<[BookTopics], AppError>)->()) {
        let endpointURLString = "https://api.nytimes.com/svc/books/v3//lists/names.json?api-key=\(ApiKey.apiKey)"
        guard let url = URL(string: endpointURLString) else {
            completion(.failure(.badURL(endpointURLString)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result{
            case .failure(let error):
                completion(.failure(.networkClientError(error)))
            case .success(let data):
                do{
                    let searchResearch = try JSONDecoder().decode(SearchResult.self, from: data)
                    let topics = searchResearch.results
                    completion(.success(topics))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
    
    static func getBooks(from topic: BookTopics, completion: @escaping (Result<[Books],AppError>)->()) {
        
        
        let endpointURL = "https://api.nytimes.com/svc/books/v3/lists/current/\(topic.listNameEncoded).json?api-key=\(ApiKey.apiKey)"
        
        guard let url = URL(string: endpointURL) else {
            completion(.failure(.badURL(endpointURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
                
            case .success(let data):
                do {
                   let books = try JSONDecoder().decode(FilteredBooks.self, from: data)
                    let filteredBooks = books.results.books
                    completion(.success(filteredBooks))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
