//
//  NYTBookStruct.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation

struct SearchResult: Codable & Equatable {
               
    let results: [BookTopic]
               
}
struct BookTopic: Codable & Equatable{
    let listname: String
    let listNameEncoded: String
    let updated: String
}
extension BookTopic {
    
    enum CodingKeys: String,CodingKey {
        case listname = "list_name"
        case listNameEncoded = "list_name_encoded"
        case updated
    }
    
}

struct FilteredBooks: Codable & Equatable {
    let numResults: Int
    let results: Details
  


    enum CodingKeys: String,CodingKey {
    case numResults = "num_results"
    case results
   
}
}

struct Details: Codable & Equatable {
        let displayname: String
        let bestsellersDate: String
        let books : [Book]
    }
extension Details {
    enum CodingKeys: String, CodingKey {
        case displayname = "display_name"
        case bestsellersDate = "bestsellers_date"
        case books
    }
}

struct Book: Codable & Equatable{
    let rank: Int
    let title: String
    let publisher: String
    let author: String
    let contributor: String
    let bookImage: String
    let buyLinks: [Links]
    
    
}

extension Book {
    enum CodingKeys: String, CodingKey {
        case rank
        case contributor
        case title
        case publisher
        case author
        case bookImage = "book_image"
        case buyLinks = "buy_links"
    }
    
}

struct Links: Codable & Equatable{
    let name: String
    let url: String
}
