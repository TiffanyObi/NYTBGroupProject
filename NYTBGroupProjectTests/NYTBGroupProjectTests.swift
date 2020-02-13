//
//  NYTBGroupProjectTests.swift
//  NYTBGroupProjectTests
//
//  Created by Tiffany Obi on 2/5/20.
//  Copyright © 2020 Tiffany Obi. All rights reserved.
//

import XCTest
import NetworkHelper
@testable import NYTBGroupProject

class NYTBGroupProjectTests: XCTestCase {
    
//    var topic : BookTopics?
    
//    func topics(){
//        NYTApiClient.getTopics { [weak self] (result) in
//            switch result{
//            case .failure:
//                break
//            case .success(let topics):
//                //assert
//                self?.topic = topics[0]
//            }
//        }
//    }

  func testBookTopicSearch() {
      
      
      let exp = XCTestExpectation(description: "search found") //need this
      
    let nYTimesEndpoint = "https://api.nytimes.com/svc/books/v3//lists/names.json?api-key=\(ApiKey.apiKey)"
      
      let request = URLRequest(url: URL(string: nYTimesEndpoint)!)
      
      //act
      NetworkHelper.shared.performDataTask(with: request) { (result) in
          
          switch result {
              
          case .failure(let appError):
              XCTFail("appError: \(appError)")
              
          case .success(let data):
              exp.fulfill() //need this
              //assert
              XCTAssertGreaterThan(data.count, 12_000, "data should be greater than \(data.count)")
              
          }
      }
      
      wait(for: [exp], timeout: 5.0) // wait for 5 seconds. //need this
  }
    
    
    func testBookTopicResutlts() {
        
        
        let exp = XCTestExpectation(description: "search found") //need this
        
      let nYTimesEndpoint = "https://api.nytimes.com/svc/books/v3/lists/current/combined-print-and-e-book-fiction.json?api-key=\(ApiKey.apiKey)"
        
        let request = URLRequest(url: URL(string: nYTimesEndpoint)!)
        
        //act
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            
            switch result {
                
            case .failure(let appError):
                XCTFail("appError: \(appError)")
                
            case .success(let data):
                exp.fulfill() //need this
                //assert
                XCTAssertGreaterThan(data.count, 23_000, "data should be greater than \(data.count)")
                
            }
        }
        
        wait(for: [exp], timeout: 5.0) // wait for 5 seconds. //need this
    }
      
    
    func testBookTopicModel() {
        
        
        struct SearchResult: Codable {
                
                let results: [BookTopics]
                
            }
            struct BookTopics: Codable {
                let list_name: String
                let updated: String
            }
            let json = """
            {
               "results": [
               {
                   "list_name": "Combined Print and E-Book Fiction",
                   "display_name": "Combined Print & E-Book Fiction",
                   "list_name_encoded": "combined-print-and-e-book-fiction",
                   "oldest_published_date": "2011-02-13",
                   "newest_published_date": "2020-02-09",
                   "updated": "WEEKLY"
               },
               {
                   "list_name": "Combined Print and E-Book Nonfiction",
                   "display_name": "Combined Print & E-Book Nonfiction",
                   "list_name_encoded": "combined-print-and-e-book-nonfiction",
                   "oldest_published_date": "2011-02-13",
                   "newest_published_date": "2020-02-09",
                   "updated": "WEEKLY"
               }]
            }
            """.data(using: .utf8)!
            
            // act
            let books = try! JSONDecoder().decode(SearchResult.self, from: json)
            
            // assert
        XCTAssertEqual(books.results.count, 2)
        }
        
    
    func testTopicBookResultsModel() {
        
        
        struct SearchResult: Codable {
                
                let results: Details
                
            }
            struct Details: Codable {
                let books : [Books]
            }
        
        struct Books: Codable {
            let title: String
        }
            let json = """
              {
                          "results": {
                              "list_name": "Combined Print and E-Book Fiction",
                              "list_name_encoded": "combined-print-and-e-book-fiction",
                              "bestsellers_date": "2020-01-25",
                              "published_date": "2020-02-09",
                              "published_date_description": "latest",
                              "next_published_date": "",
                              "previous_published_date": "2020-02-02",
                              "display_name": "Combined Print & E-Book Fiction",
                              "normal_list_ends_at": 15,
                              "updated": "WEEKLY",
                              "books": [{
                                      "rank": 1,
                                      "rank_last_week": 0,
                                      "weeks_on_list": 1,
                                      "asterisk": 0,
                                      "dagger": 0,
                                      "primary_isbn10": "1250209765",
                                      "primary_isbn13": "9781250209764",
                                      "publisher": "Flatiron",
                                      "description": "A bookseller flees Mexico for the United States with her son while pursued by the head of a drug cartel.",
                                      "price": 0,
                                      "title": "AMERICAN DIRT",
                                      "author": "Jeanine Cummins",
                                      "contributor": "by Jeanine Cummins",
                                      "contributor_note": "",
                                      "book_image": "https://s1.nyt.com/du/books/images/9781250209764.jpg",
                                      "book_image_width": 326,
                                      "book_image_height": 495,
                                      "amazon_product_url": "https://www.amazon.com/American-Dirt-Oprahs-Book-Club/dp/1250209765?tag=NYTBS-20",
                                      "age_group": "",
                                      "book_review_link": "https://www.nytimes.com/2020/01/17/books/review-american-dirt-jeanine-cummins.html",
                                      "first_chapter_link": "",
                                      "sunday_review_link": "",
                                      "article_chapter_link": "",
                                      "isbns": [{
                                              "isbn10": "1250209765",
                                              "isbn13": "9781250209764"
                                          },
                                          {
                                              "isbn10": "1250772400",
                                              "isbn13": "9781250772404"
                                          }
                                      ],
                                      "buy_links": [{
                                              "name": "Amazon",
                                              "url": "https://www.amazon.com/American-Dirt-Oprahs-Book-Club/dp/1250209765?tag=NYTBS-20"
                                          },
                                          {
                                              "name": "Apple Books",
                                              "url": "http://du-gae-books-dot-nyt-du-prd.appspot.com/buy?title=AMERICAN+DIRT&author=Jeanine+Cummins"
                                          },
                                          {
                                              "name": "Barnes and Noble",
                                              "url": "http://www.anrdoezrs.net/click-7990613-11819508?url=http%3A%2F%2Fwww.barnesandnoble.com%2Fw%2F%3Fean%3D9781250209764"
                                          },
                                          {
                                              "name": "Local Booksellers",
                                              "url": "http://www.indiebound.org/book/9781250209764?aff=NYT"
                                          }
                                      ],
                                      "book_uri": "nyt://book/ea1c7a1f-1743-57a8-b210-0150f87a4b47"
                                  },
                                  {
                                      "rank": 2,
                                      "rank_last_week": 1,
                                      "weeks_on_list": 72,
                                      "asterisk": 0,
                                      "dagger": 0,
                                      "primary_isbn10": "0735219095",
                                      "primary_isbn13": "9780735219090",
                                      "publisher": "Putnam",
                                      "description": "In a quiet town on the North Carolina coast in 1969, a young woman who survived alone in the marsh becomes a murder suspect.",
                                      "price": 0,
                                      "title": "WHERE THE CRAWDADS SING",
                                      "author": "Delia Owens",
                                      "contributor": "by Delia Owens",
                                      "contributor_note": "",
                                      "book_image": "https://s1.nyt.com/du/books/images/9780735219090.jpg",
                                      "book_image_width": 328,
                                      "book_image_height": 495,
                                      "amazon_product_url": "https://www.amazon.com/Where-Crawdads-Sing-Delia-Owens/dp/0735219095?tag=NYTBS-20",
                                      "age_group": "",
                                      "book_review_link": "",
                                      "first_chapter_link": "",
                                      "sunday_review_link": "",
                                      "article_chapter_link": "",
                                      "isbns": [{
                                              "isbn10": "0735219095",
                                              "isbn13": "9780735219090"
                                          },
                                          {
                                              "isbn10": "0735219117",
                                              "isbn13": "9780735219113"
                                          },
                                          {
                                              "isbn10": "0525640371",
                                              "isbn13": "9780525640370"
                                          },
                                          {
                                              "isbn10": "0593105419",
                                              "isbn13": "9780593105412"
                                          },
                                          {
                                              "isbn10": "0593187989",
                                              "isbn13": "9780593187982"
                                          }
                                      ],
                                      "buy_links": [{
                                              "name": "Amazon",
                                              "url": "https://www.amazon.com/Where-Crawdads-Sing-Delia-Owens/dp/0735219095?tag=NYTBS-20"
                                          },
                                          {
                                              "name": "Apple Books",
                                              "url": "http://du-gae-books-dot-nyt-du-prd.appspot.com/buy?title=WHERE+THE+CRAWDADS+SING&author=Delia+Owens"
                                          },
                                          {
                                              "name": "Barnes and Noble",
                                              "url": "http://www.anrdoezrs.net/click-7990613-11819508?url=http%3A%2F%2Fwww.barnesandnoble.com%2Fw%2F%3Fean%3D9780735219090"
                                          },
                                          {
                                              "name": "Local Booksellers",
                                              "url": "http://www.indiebound.org/book/9780735219090?aff=NYT"
                                          }
                                      ],
                                      "book_uri": "nyt://book/053b4109-4555-5aa1-9b39-cc40549bcdf0"
                                  }
                              ]
                          }
                      }
            """.data(using: .utf8)!
            
            // act
            let books = try! JSONDecoder().decode(SearchResult.self, from: json)
            
            // assert
        XCTAssertEqual(books.results.books.count, 2)
        }
        
    
    func testTopics(){
        //arrange
        let name = "Combined Print and E-Book Nonfiction"
        let exp = XCTestExpectation(description: "search found") //need this

        
        //act
        NYTApiClient.getTopics { (result) in
            switch result{
            case .failure:
                XCTFail()
            case .success(let topics):
                //assert
                exp.fulfill()
                XCTAssertEqual(topics.first?.listname, name)
            }
        }
        
        wait(for: [exp], timeout: 5.0)
    }
    
    
    
    func testBookUsingTopic() {

        let count = 5
        
        let exp = XCTestExpectation(description: "search found") //need this

        //act
    
        NYTApiClient.getBooks(from: "combined-print-and-e-book-nonfiction") { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                        XCTFail()

                    case .success(let books):
                        exp.fulfill()
                        XCTAssertGreaterThan(books.count, count)
                    }
                }
            
        
wait(for: [exp], timeout: 5.0)

    }

}
  


