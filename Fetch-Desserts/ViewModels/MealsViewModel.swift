//
//  MealsViewModel.swift
//  Fetch-Desserts
//
//  Created by Sophia Gorgonio on 8/16/24.
//

import Foundation

/// ViewModel for managing meal data and state.
@MainActor
class MealViewModel: ObservableObject {
    // MARK: - Published Properties
    
    /// List of meals fetched from the API.
    @Published var meals: [Meals] = []
    
    /// Boolean indicating whether meal data is currently being loaded.
    @Published var isLoadingMeals: Bool = false
    
    /// Error message related to fetching the list of meals.
    @Published var mealListErrorMessage: String? = nil
    
    /// Details of a specific meal.
    @Published var mealDetail: MealDetails?
    
    /// Boolean indicating whether meal detail data is currently being loaded.
    @Published var isLoadingMealDetail: Bool = false
    
    /// Error message related to fetching the details of a meal.
    @Published var mealDetailErrorMessage: String? = nil
    
    // MARK: - Fetch Methods
    
    /// Fetches a list of meals from the API.
    /// - Returns: An async function that performs the data fetch and updates the published properties.
    func fetchMeals() async {
        isLoadingMeals = true
        mealListErrorMessage = nil
        
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            mealListErrorMessage = "Invalid URL"
            isLoadingMeals = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealResponse = try JSONDecoder().decode(MealsResponse.self, from: data)
            meals = mealResponse.meals
        } catch {
            mealListErrorMessage = "Failed to fetch meals: \(error.localizedDescription)"
        }
        
        isLoadingMeals = false
    }
    
    /// Fetches the details of a specific meal by its ID.
    /// - Parameter id: The unique identifier of the meal to fetch.
    /// - Returns: An async function that performs the data fetch and updates the published properties.
    func fetchMealDetail(by id: String) async {
        isLoadingMealDetail = true
        mealDetailErrorMessage = nil
        
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            mealDetailErrorMessage = "Invalid URL"
            isLoadingMealDetail = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealDetailResponse = try JSONDecoder().decode(MealDetailsResponse.self, from: data)
            mealDetail = mealDetailResponse.meals.first
        } catch {
            mealDetailErrorMessage = "Failed to fetch meal detail: \(error.localizedDescription)"
        }
        
        isLoadingMealDetail = false
    }
}
