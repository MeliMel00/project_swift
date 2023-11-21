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
    @State private var recipeDuration = ""
    @Binding var recipes: [Recipe]
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nouvelle Recette")) {
                    TextField("Nom de la recette", text: $recipeName)
                    TextField("URL de l'image", text: $recipeImageUrl)
                    TextField("Ingrédients", text: $recipeIngredients)
                    TextField("Durée en minutes", text: $recipeDuration)
                        .keyboardType(.numberPad)
                }
                Section {
                    Button("Ajouter la recette")
                    {
                        
                        guard !recipeName.isEmpty, !recipeImageUrl.isEmpty, !recipeIngredients.isEmpty, let duration = Int(recipeDuration) else {
                            return
                        }
                        let newRecipe = Recipe(name: recipeName, imageUrl: recipeImageUrl, ingredients: recipeIngredients, duration: duration)
                        recipes.append(newRecipe)
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Nouvelle Recette", displayMode: .inline)
        }
    }
}
