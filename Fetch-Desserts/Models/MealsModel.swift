//
//  MealsModel.swift
//  Fetch-Desserts
//
//  Created by Sophia Gorgonio on 9/3/24.
//

import Foundation

/// Represents a single meal, conforming to `Identifiable` and `Codable` protocols.
struct Meals: Identifiable, Codable {
    /// The unique identifier for the meal.
    let idMeal: String
    
    /// The name of the meal.
    let strMeal: String?
    
    /// A URL string pointing to an image of the meal.
    let strMealThumb: String?
    
    /// The unique identifier required by the `Identifiable` protocol.
    var id: String { idMeal }
}

/// Represents the response structure for a list of meals, conforming to `Codable` protocol.
struct MealsResponse: Codable {
    /// An array of `Meals` objects.
    let meals: [Meals]
}
