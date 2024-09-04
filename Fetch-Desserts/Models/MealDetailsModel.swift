//
//  MealDetailsModel.swift
//  Fetch-Desserts
//
//  Created by Sophia Gorgonio on 9/3/24.
//

import Foundation

/// Represents detailed information about a selected meal.
struct MealDetails: Codable, Identifiable {
    /// The unique identifier for the meal.
    let idMeal: String
    
    /// The name of the meal.
    let strMeal: String?
    
    /// Instructions for preparing the meal.
    let strInstructions: String?
    
    /// A URL string pointing to an image of the meal.
    let strMealThumb: String?
        
    // List of ingredients used in the meal. Each ingredient is optional and corresponds to an index from 1 to 20.
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strIngredient6: String?
    let strIngredient7: String?
    let strIngredient8: String?
    let strIngredient9: String?
    let strIngredient10: String?
    let strIngredient11: String?
    let strIngredient12: String?
    let strIngredient13: String?
    let strIngredient14: String?
    let strIngredient15: String?
    let strIngredient16: String?
    let strIngredient17: String?
    let strIngredient18: String?
    let strIngredient19: String?
    let strIngredient20: String?

    /// List of measures for the ingredients. Each measure is optional and corresponds to an index from 1 to 20.
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?
    let strMeasure6: String?
    let strMeasure7: String?
    let strMeasure8: String?
    let strMeasure9: String?
    let strMeasure10: String?
    let strMeasure11: String?
    let strMeasure12: String?
    let strMeasure13: String?
    let strMeasure14: String?
    let strMeasure15: String?
    let strMeasure16: String?
    let strMeasure17: String?
    let strMeasure18: String?
    let strMeasure19: String?
    let strMeasure20: String?
    
    /// Array of all ingredients, where each element corresponds to an index from 1 to 20.
    private var ingredients: [String?] {
        return [
            strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5,
            strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10,
            strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15,
            strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        ]
    }

    /// Array of all measures, where each element corresponds to an index from 1 to 20.
    private var measures: [String?] {
        return [
            strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5,
            strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10,
            strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15,
            strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
        ]
    }

    /// Computed property to provide pairs of ingredients and measures, excluding null values and only including pairs where both elements are non-empty.
    var ingredientMeasurePairs: [(ingredient: String, measure: String)] {
        var pairs: [(String, String)] = []

        for (ingredient, measure) in zip(ingredients, measures) {
            if let ingredient = ingredient, !ingredient.isEmpty,
               let measure = measure, !measure.isEmpty {
                pairs.append((ingredient: ingredient, measure: measure))
            }
        }

        return pairs
    }

    /// Computed property to provide a unique identifier for `Identifiable` conformance.
    var id: String { idMeal }
}

/// Response model for a meal detail API request.
struct MealDetailsResponse: Codable {
    /// Array of meal details returned from the API.
    let meals: [MealDetails]
}
