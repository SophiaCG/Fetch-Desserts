//
//  Fetch_DessertsTests.swift
//  Fetch-DessertsTests
//
//  Created by Sophia Gorgonio on 8/16/24.
//

import XCTest
@testable import Fetch_Desserts

@MainActor
final class Fetch_DessertsTests: XCTestCase {
    var viewModel: MealViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        viewModel = MealViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        try super.tearDownWithError()
    }
    
    // Test fetching meals
    func testFetchMeals() async {
        // Ensure meals array is empty before fetching
        XCTAssertTrue(viewModel.meals.isEmpty)
        
        // Perform the async fetchMeals call
        await viewModel.fetchMeals()
        
        // Assert that the meals array is populated after the fetch
        XCTAssertFalse(viewModel.meals.isEmpty)
        
        // You can also check for specific values
        XCTAssertEqual(viewModel.meals.first?.strMeal, "Apam balik")
    }

    // Test fetching meal details
    func testFetchMealDetail() async {
        // Use a known meal ID to fetch details
        let mealID = "52767"
        
        // Perform the async fetchMealDetail call
        await viewModel.fetchMealDetail(by: mealID)
        
        // Assert that the meal detail is not nil
        XCTAssertNotNil(viewModel.mealDetail)
        
        // Check specific values in meal details
        XCTAssertEqual(viewModel.mealDetail?.strMeal, "Bakewell tart")
        XCTAssertEqual(viewModel.mealDetail?.strInstructions, "To make the pastry, measure the flour into a bowl and rub in the butter with your fingertips until the mixture resembles fine breadcrumbs. Add the water, mixing to form a soft dough.\r\nRoll out the dough on a lightly floured work surface and use to line a 20cm/8in flan tin. Leave in the fridge to chill for 30 minutes.\r\nPreheat the oven to 200C/400F/Gas 6 (180C fan).\r\nLine the pastry case with foil and fill with baking beans. Bake blind for about 15 minutes, then remove the beans and foil and cook for a further five minutes to dry out the base.\r\nFor the filing, spread the base of the flan generously with raspberry jam.\r\nMelt the butter in a pan, take off the heat and then stir in the sugar. Add ground almonds, egg and almond extract. Pour into the flan tin and sprinkle over the flaked almonds.\r\nBake for about 35 minutes. If the almonds seem to be browning too quickly, cover the tart loosely with foil to prevent them burning.")
    }
}
