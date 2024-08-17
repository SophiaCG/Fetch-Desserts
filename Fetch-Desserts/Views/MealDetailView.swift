//
//  MealDetailView.swift
//  Fetch-Desserts
//
//  Created by Sophia Gorgonio on 8/16/24.
//

import SwiftUI

/// View that displays the detailed information of a specific meal.
/// - Parameters:
///   - mealID: The unique identifier of the meal whose details are to be displayed.
///   - viewModel: The view model responsible for fetching and managing the meal details.
struct MealDetailView: View {
    /// The unique identifier of the meal to display details for.
    let mealID: String
    
    /// The view model that manages the meal data and state for this view.
    @ObservedObject var viewModel: MealViewModel
    
    var body: some View {
        Group {
            // Display a loading indicator if meal details are being loaded
            if viewModel.isLoadingMealDetail {
                ProgressView("Loading Meal Details...")
            }
            // Display an error message if fetching meal details failed
            else if let errorMessage = viewModel.mealDetailErrorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            // Display the meal details if loading is complete and no errors occurred
            else if let meal = viewModel.mealDetail {
                ScrollView {
                    VStack(alignment: .leading) {                        
                        // Display the meal name
                        Text(meal.strMeal)
                            .font(.largeTitle)
                            .bold()
                            .padding(.top)

                        // Display the meal thumbnail image asynchronously
                        AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: 250, alignment: .center)
                                .clipped()
                                .cornerRadius(5)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 250)
                                                                        
                        // Display the section title for instructions
                        Text("Instructions")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                        
                        // Display the meal instructions, or a default message if not available
                        Text(meal.strInstructions ?? "No instructions available.")
                            .padding(.bottom)
                                                
                        // Display the section title for ingredients
                        Text("Ingredients")
                            .font(.title2)
                            .bold()
                            .padding(.top)
                        
                        // Display each ingredient and its measure
                        ForEach(meal.ingredientMeasurePairs, id: \.ingredient) { pair in
                            HStack {
                                Text("\(pair.ingredient):")
                                    .bold()
                                Text(pair.measure)
                            }
                        }
                    }
                    .padding()
                }
            } else {
                // Display a placeholder text if no meal detail is available
                Text("Oops, something went wrong.")
            }
        }
        // Hides the navigation bar space
        .navigationBarTitleDisplayMode(.inline)
        // Fetch the meal details when the view appears
        .task {
            await viewModel.fetchMealDetail(by: mealID)
        }
    }
}
