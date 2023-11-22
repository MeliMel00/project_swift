//
//  RecipeDetailView.swift
//  project_swift_melvin
//
//  Created by CHEVALLIER Melvin on 21/11/2023.
//

import Foundation
import SwiftUI

struct RecipeDetailView: View {
    @State private var isEditing = false
    @State private var editedRecipe: Recipe
    
    var recipe: Recipe
    
    @Binding var recipes: [Recipe]

    init(recipe: Recipe, recipes: Binding<[Recipe]>) {
        self.recipe = recipe
        self._recipes = recipes
        self._editedRecipe = State(initialValue: recipe)
    }

    var body: some View {
        VStack {
            if isEditing {
                Form() {
                    TextField("Name", text: $editedRecipe.name)
                    TextField("Image URL", text: $editedRecipe.imageUrl)
                    TextField("Calories (min)", text: Binding(
                        get: { String(editedRecipe.calories) },
                        set: { if let newValue = Double($0) { editedRecipe.calories = newValue } }
                    ))
                }
//                Form {
//                    Section(
//                        header: Text("Recipe Details")) {
//                        TextField("Name", text: $editedRecipe.name)
//                        TextField("Image URL", text: $editedRecipe.imageUrl)
////                        TextField("Ingredients", text: $editedRecipe.ingredients)
//                        TextField("Calories (min)", text: Binding(
//                            get: { String(editedRecipe.duration) },
//                            set: { if let newValue = Int($0) { editedRecipe.duration = newValue } }
//                        ))
//                        .keyboardType(.numberPad)
//
//                    }
//                }
                HStack {
                    Button("Save") {
                        if let index = recipes.firstIndex(where: { $0.id == editedRecipe.id }) {
                            recipes[index] = editedRecipe
                        }
                        isEditing.toggle()
                    }
                    Button("Cancel") {
                        isEditing.toggle()
                        editedRecipe = recipe
                    }
                }
                .padding()
            } else {
                ScrollView {
                    VStack(spacing: 10) {
                        VStack {
                            AsyncImage(url: URL(string: editedRecipe.imageUrl)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(height: 300)
                        }
                        .padding(.bottom, 10)

                        VStack(alignment: .leading, spacing: 8) {
                            Text(editedRecipe.name)
                                .font(.title)
                            Text("Calories: \(forTrailingZero(temp: recipe.calories.rounded()))")
                                .font(.subheadline)
                            
                        }
                        Spacer()
                        VStack {
                            Text("Ingrédients:")
                               .font(.headline)
                            ForEach(recipe.ingredients, id: \.self) { ingredient in
                                       Text(ingredient)
                                   }
                               }
                        HStack() {
                            Button("Edit") {
                                isEditing.toggle()
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.blue)
                            .cornerRadius(8)
                            
                            Button("Delete") {
                                recipes.removeAll { $0.id == editedRecipe.id }
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.red)
                            .cornerRadius(8)
                        }
                        .padding()
                    }
                    .padding(15)
                }
            }
        }
        .navigationBarTitle(editedRecipe.name, displayMode: .inline)
       
        
    }
}
