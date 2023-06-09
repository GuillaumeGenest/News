//
//  UITests_News_test.swift
//  NewsUITests
//
//  Created by Guillaume Genest on 08/06/2023.
//

import XCTest
@testable import News

final class UITests_News_test: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func test_ContentView_CategoryButtonView_DisplayNewCategory() throws {
        
        let scrollViewsQuery = XCUIApplication().scrollViews
        let elementsQuery = scrollViewsQuery.otherElements
        elementsQuery.staticTexts["Business"].tap()
        elementsQuery.staticTexts["Technology"].tap()
        let generalElement = scrollViewsQuery.otherElements.containing(.staticText, identifier:"General").element
        generalElement.swipeLeft()
        elementsQuery.staticTexts["Science"].tap()
                                                
    }
    
    func test_ContentView_NavigationView() throws {
        
        
    }
    
    
    func test_ContentView_MenuLanguage_Changelanguage() throws {
        XCUIApplication().buttons["gearshape"].tap()
    }
}
