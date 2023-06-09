//
//  UnitTestingNews_Tests.swift
//  NewsTests
//
//  Created by Guillaume Genest on 08/06/2023.
//

import XCTest
@testable import News


final class UnitTestingNews_Tests: XCTestCase {
    var viewModel : NewsViewModel?
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = NewsViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func test_ViewModel_NewsArray_InitialisEmpty() throws {
        guard let vm = viewModel else {
                    XCTFail()
                    return
                }

        XCTAssertTrue(vm.news.isEmpty, "News array should be empty initially")
    }
    
    func test_ViewModel_getURL_GenerateCorrectURL() throws {
        guard let vm = viewModel else {
                    XCTFail()
                    return
        }
        let category = "technology"
        let country = "us"
        let apiKey = "851dfef8f907405e9003a45a4ef62401"
        let expectedURLString = "https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=\(apiKey)"

        let url = vm.getURL(category: category, country: country)
       
        // Then
        XCTAssertEqual(url?.absoluteString, expectedURLString, "URL should match the expected value")
        }
    
    
    func test_ViewModel_DecodesResponse_CheckifgetArticlesCouldDecode() throws{
        
        //Given
        
        let testjsonData = """
        {
            "articles": [
                {
                    "title": "Article 1",
                    "description": "Description 1"
                },
                {
                    "title": "Article 2",
                    "description": "Description 2"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        let newsAPIResulttestdecode = try? JSONDecoder().decode(NewsAPIResult.self, from: testjsonData)

        // Then
        XCTAssertNotNil(newsAPIResulttestdecode, "Decoding should succeed")
               XCTAssertEqual(newsAPIResulttestdecode?.articles.count, 2, "Should decode correct number of articles")
               XCTAssertEqual(newsAPIResulttestdecode?.articles[0].title, "Article 1", "Should decode correct title for article 1")
               XCTAssertEqual(newsAPIResulttestdecode?.articles[1].description, "Description 2", "Should decode correct description for article 2")
        XCTAssertNotNil(newsAPIResulttestdecode?.articles[0].title, "Article should have a title")
        XCTAssertNotNil(newsAPIResulttestdecode?.articles[0].description, "Article should have a description")
           }
    
    func test_ViewModel_getArticles_ReturnArrayofAritcles() throws {
        //Given
        let category = "general"
        let country = "fr"
        
        guard let vm = viewModel else {
                    XCTFail()
                    return
        }
        //When
        vm.getArticles(category: category, country: country)
        
        //Then
        XCTAssertEqual(vm.news.count, 0, "News array should be empty initially")
            
        let expectation = XCTestExpectation(description: "Fetch articles")
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(vm.news.count > 0, "News should be fetched")
                expectation.fulfill()
        }
            
            wait(for: [expectation], timeout: 5.0)
        
    }
    
    
}
