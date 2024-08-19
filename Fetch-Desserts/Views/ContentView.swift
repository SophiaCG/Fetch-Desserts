//
//  ContentView.swift
//  Fetch-Desserts
//
//  Created by Sophia Gorgonio on 8/16/24.
//

import SwiftUI

/// The main view that displays a list of desserts and handles loading and error states.
struct ContentView: View {
    /// The view model that manages the meal data and state for this view.
    @StateObject private var viewModel = MealViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                // Display a loading indicator if meals are being loaded
                if viewModel.isLoadingMeals {
                    ProgressView("Loading Meals...")
                }
                // Display an error message if fetching meals failed
                else if let errorMessage = viewModel.mealListErrorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                // Display the list of meals alphabetically if loading is complete and no errors occurred
                else {
                    List(viewModel.meals.sorted(by: { ($0.strMeal ?? "") < ($1.strMeal ?? "") })) { meal in
                        NavigationLink(destination: MealDetailView(mealID: meal.idMeal, viewModel: viewModel)) {
                            HStack {
                                // Custom ImageView that fetches the image using async/await
                                AsyncImageView(urlString: meal.strMealThumb ?? "")
                                    .frame(width: 125, height: 100)
                                    .clipped()
                                    .cornerRadius(5)
                                
                                // Display the meal name
                                Text(meal.strMeal ?? "")
                                    .font(.headline)
                                    .padding(.leading, 10)
                            }
                        }
                        // Hide the row separator for a cleaner look
                        .listRowSeparator(.hidden)
                    }
                }
            }
            .navigationTitle("Desserts") // Set the navigation bar title
            .task {
                // Fetch meals when the view appears
                await viewModel.fetchMeals()
            }
        }
    }
}
