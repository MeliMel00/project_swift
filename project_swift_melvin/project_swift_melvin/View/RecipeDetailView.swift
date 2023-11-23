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
                Form {
                    Section(header: Text("Edit Name")) {
                        TextField("Name", text: $editedRecipe.name)
                        
                    }
                    Section(header: Text("Edit Image")){
                        TextField("Image URL", text: $editedRecipe.imageUrl)
                    }
                    Section(header: Text("Edit Ingredients")){
                        ForEach(0..<editedRecipe.ingredients.count, id: \.self) { index in
                                HStack {
                                    TextField("Ingredient \(index + 1)", text: $editedRecipe.ingredients[index])

                                    if editedRecipe.ingredients.count > 1 {
                                        Button(action: {
                                            editedRecipe.ingredients.remove(at: index)
                                        }) {
                                            Image(systemName: "minus.circle.fill")
                                                .foregroundColor(.red)
                                        }
                                    }
                                }
                            }

                            Button(action: {
                                editedRecipe.ingredients.append("")
                            }) {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text("Add Ingredient")
                                }
                            }
                    }
                    Section(header: Text("Edit calories")) {
                        TextField("Calories (min)", text: Binding(
                            get: { String(editedRecipe.calories) },
                            set: { if let newValue = Double($0) { editedRecipe.calories = newValue } }
                        ))
                        .keyboardType(.numberPad)
                    }
                }
                HStack() {
                    Button("Save") {
                        guard
                            !editedRecipe.name.isEmpty,
                            !editedRecipe.imageUrl.isEmpty,
                            editedRecipe.ingredients.allSatisfy({ !$0.isEmpty }),
                            Double(editedRecipe.calories) > 0
                        else {
                            return
                        }

                        let nonEmptyIngredients = editedRecipe.ingredients.filter { !$0.isEmpty }
                        editedRecipe.ingredients = nonEmptyIngredients

                        if let index = recipes.firstIndex(where: { $0.id == editedRecipe.id }) {
                            recipes[index] = editedRecipe
                        }
                        isEditing.toggle()
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.blue)
                    .cornerRadius(8)
                    
                    Button("Cancel") {
                        isEditing.toggle()
                        editedRecipe = recipe
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 16)
                    .background(Color.red)
                    .cornerRadius(8)
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            AsyncImage(url: URL(string: editedRecipe.imageUrl)) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(maxHeight: 500)
                        }
                        .padding(.bottom, 10)

                        VStack(alignment: .leading) {
                            Text(editedRecipe.name)
                                .font(.title)
                            Text("Calories: \(forTrailingZero(temp: recipe.calories.rounded()))")
                                .font(.subheadline)

                            Spacer()

                            Text("Ingrédients:")
                                .font(.headline)
                                .padding(.bottom, 8)
                            ForEach(recipe.ingredients, id: \.self) { ingredient in
                                Text(ingredient)
                                    .padding(.bottom, 4)
                            }
                        }
                    }
                    .padding(8)
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
            }
        }
        .navigationBarTitle(editedRecipe.name, displayMode: .inline)
       
        
    }
}
