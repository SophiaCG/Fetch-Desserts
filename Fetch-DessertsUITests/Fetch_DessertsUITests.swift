//
//  Fetch_DessertsUITests.swift
//  Fetch-DessertsUITests
//
//  Created by Sophia Gorgonio on 9/3/24.
//

import XCTest

final class Fetch_DessertsUITests: XCTestCase {

    let app = XCUIApplication()

    func testContentViewElements() throws {
        app.launch()
        
        let navigationTitle = app.navigationBars["Desserts"]
        
        let collectionView = app.collectionViews.element
        
        let firstCell = collectionView.cells.element(boundBy: 0)
        let firstCellImage = firstCell.images.element
        let firstCellLabel = firstCell.staticTexts.element
        
        let secondCell = collectionView.cells.element(boundBy: 1)
        let secondCellImage = secondCell.images.element
        let secondCellLabel = secondCell.staticTexts.element

        XCTAssertTrue(navigationTitle.exists)
        
        XCTAssertTrue(collectionView.exists, "Collection view does not exist")
        
        XCTAssertTrue(firstCell.exists, "First cell does not exist")
        XCTAssertTrue(firstCellLabel.exists, "Label in the first cell does not exist")
        XCTAssertEqual(firstCellLabel.label, "Apam balik")
        XCTAssertTrue(firstCellImage.exists, "Image in the first cell does not exist")

        XCTAssertTrue(secondCell.exists, "Second cell does not exist")
        XCTAssertTrue(secondCellLabel.exists, "Label in the second cell does not exist")
        XCTAssertEqual(secondCellLabel.label, "Apple & Blackberry Crumble")
        XCTAssertTrue(secondCellImage.exists, "Image in the second cell does not exist")
    }
    
    func testDetailViewFirstRecipe() throws {
        app.launch()
        app.collectionViews.staticTexts["Apam balik"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let instructionsLabel = app.scrollViews.staticTexts.element(boundBy: 2)
        let backButton = app.navigationBars["_TtGC7SwiftUI19UIHosting"].buttons["Desserts"]

        XCTAssertTrue(elementsQuery.staticTexts["Instructions"].exists)
        XCTAssertTrue(instructionsLabel.exists)
        XCTAssertEqual(instructionsLabel.label, "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm.")
        XCTAssertTrue(elementsQuery.staticTexts["Ingredients"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Milk:"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["200ml"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["Oil:"].exists)
        XCTAssertTrue(elementsQuery.staticTexts["60ml"].exists)
        
        XCTAssert(backButton.exists)
        backButton.tap()
        XCTAssertTrue(app.navigationBars["Desserts"].exists)
        XCTAssertFalse(instructionsLabel.exists)
    }
}
