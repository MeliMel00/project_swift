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
    @State private var recipeIngredients = ""
    @State private var recipeCalories = ""
    @Binding var recipes: [Recipe]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {            Form {
                Section(header: Text("Nouvelle Recette")) {
                    TextField("Nom de la recette", text: $recipeName)
                    TextField("URL de l'image", text: $recipeImageUrl)
                    TextField("Ingrédients", text: $recipeIngredients)
                    TextField("Nombre de calories", text: $recipeCalories)
                        .keyboardType(.numberPad)
                }
                Section {
                    Button("Ajouter la recette")
                    {

                        guard !recipeName.isEmpty, !recipeImageUrl.isEmpty, !recipeIngredients.isEmpty, let calorie = Double(recipeCalories) else {
                            return
                        }
                        let newRecipe = Recipe(name: recipeName, ingredients: [recipeIngredients], imageUrl: recipeImageUrl, calories: calorie)
                        recipes.append(newRecipe)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Nouvelle Recette", displayMode: .inline)
        }
    }
}
