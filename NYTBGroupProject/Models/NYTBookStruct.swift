//
//  NYTBookStruct.swift
//  NYTBGroupProject
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
               
    let results: [BookTopics]
               
}
struct BookTopics: Codable {
    let listname: String
    let listNameEncoded: String
    let updated: String
}
extension BookTopics {
    
    enum CodingKeys: String,CodingKey {
        case listname = "list_name"
        case listNameEncoded = "list_name_encoded"
        case updated
    }
    
}

struct FilteredBooks: Codable {
    let numResults: Int
    let results: Details
  


    enum CodingKeys: String,CodingKey {
    case numResults = "num_results"
    case results
   
}
}

struct Details: Codable {
        let displayname: String
        let bestsellersDate: String
        let books : [Books]
    }
extension Details {
    enum CodingKeys: String, CodingKey {
        case displayname = "display_name"
        case bestsellersDate = "bestsellers_date"
        case books
    }
}

struct Books: Codable {
    let rank: Int
    let title: String
    let publisher: String
    let author: String
    let contributor: String
    let bookImage: String
    let buyLinks: [Links]
    
    
}

extension Books {
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

struct Links: Codable {
    let name: String
    let url: String
}
