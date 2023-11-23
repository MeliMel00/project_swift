//
//  Network.swift
//  project_swift_melvin
//
//  Created by CHEVALLIER Melvin on 22/11/2023.
//

import Foundation

struct EdamamResponse: Codable {
    let hits: [Hit]
}

struct Hit: Codable {
    let recipe: RecipeInfo
}

struct RecipeInfo: Codable {
    let label: String
    let ingredients: [Ingredient]
    let image: String
    let calories: Double
}

struct Ingredient: Codable {
    let text: String
}

extension URL {
    func appending(parameters: [String: String]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        return components.url!
    }
}

class Network: ObservableObject {
        @Published var recipes: [Recipe] = []
    
   
    
    func fetchRecipes() {
        let appId = ApiConfig.appId
        let appKey = ApiConfig.appKey
        let baseURL = ApiConfig.baseURL

        let query = "random"
        let parameters = ["q": query, "app_id": appId, "app_key": appKey]

        guard let url = URL(string: baseURL)?.appending(parameters: parameters) else {
            print("URL invalide")
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Erreur de requête: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("Aucune donnée reçue")
                return
            }

            DispatchQueue.main.async {
                do {
                    let decodedData = try JSONDecoder().decode(EdamamResponse.self, from: data)
                    self.recipes = decodedData.hits.enumerated().map { (index, hit) in
                        return Recipe(id: index, name: hit.recipe.label, ingredients: hit.recipe.ingredients.map { $0.text }, imageUrl: hit.recipe.image, calories: hit.recipe.calories)
                    }
                } catch let decodingError {
                    print("Error decoding JSON: \(decodingError)")
                }
            }
        }.resume()
    }
        
}


