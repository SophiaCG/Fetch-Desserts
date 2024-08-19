//
//  AsyncImageView.swift
//  Fetch-Desserts
//
//  Created by Sophia Gorgonio on 8/18/24.
//

import SwiftUI

/// A custom view for asynchronously loading and displaying an image from a URL.
/// If the image is not yet loaded, a `ProgressView` is shown as a placeholder.
/// - Parameters:
///   - urlString: A string representing the URL of the image to load.
struct AsyncImageView: View {
    /// The state variable that holds the loaded `UIImage`.
    @State private var uiImage: UIImage? = nil
    
    /// The URL string of the image to load.
    let urlString: String
    
    var body: some View {
        Group {
            // Display the image if it has been loaded
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            } else {
                // Show a progress view while the image is being loaded
                ProgressView()
                    .task {
                        await loadImage()
                    }
            }
        }
    }
    
    /// Asynchronously loads an image from the provided URL.
    func loadImage() async {
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        do {
            // Fetch image data asynchronously
            let (data, _) = try await URLSession.shared.data(from: url)
            // Convert data to UIImage
            if let image = UIImage(data: data) {
                uiImage = image
            } else {
                print("Failed to convert data to image")
            }
        } catch {
            print("Error loading image: \(error.localizedDescription)")
        }
    }
}
