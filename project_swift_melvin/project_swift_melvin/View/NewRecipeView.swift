//
//  NewRecipeView.swift
//  project_swift_melvin
//
//  Created by CHEVALLIER Melvin on 21/11/2023.
//

import Foundation
import SwiftUI

struct NewRecipeView: View {
    @State private var recipeName = ""
    @State private var recipeImageUrl = ""
    @State private var recipeIngredients: [String] = [""]
    @State private var recipeCalories = ""
    @Binding var recipes: [Recipe]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Name")) {
                    TextField("Recipe name", text: $recipeName)
                }
                Section(header: Text("Image")) {
                    TextField("Image Url", text: $recipeImageUrl)
                }
                Section(header: Text("Ingredients")){
                    ForEach(0..<recipeIngredients.count, id: \.self) { index in
                        HStack {
                            TextField("Ingredient \(index + 1)", text: $recipeIngredients[index])

                            if recipeIngredients.count > 1 {
                                Button(action: {
                                    recipeIngredients.remove(at: index)
                                }) {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }

                    Button(action: {
                        recipeIngredients.append("")
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Add ingredients")
                        }
                    }
                }
                Section(header: Text("Calories")) {
                    TextField("Count of calories", text: $recipeCalories)
                        .keyboardType(.numberPad)
                }
                Section {
                    Button("Add Recipe") {
                        guard !recipeName.isEmpty, !recipeImageUrl.isEmpty, recipeIngredients.allSatisfy({ !$0.isEmpty }), let calorie = Double(recipeCalories) else {
                               return
                           }
                        
                        let nonEmptyIngredients = recipeIngredients.filter { !$0.isEmpty }
                        
                        let newRecipe = Recipe(name: recipeName, ingredients: nonEmptyIngredients, imageUrl: recipeImageUrl, calories: calorie)
                        recipes.append(newRecipe)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("New Recipe", displayMode: .inline)
        }
    }
}
