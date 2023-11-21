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
                    Section(header: Text("Recipe Details")) {
                        TextField("Name", text: $editedRecipe.name)
                        TextField("Image URL", text: $editedRecipe.imageUrl)
                        TextField("Ingredients", text: $editedRecipe.ingredients)
                        TextField("Duration (min)", text: Binding(
                            get: { String(editedRecipe.duration) },
                            set: { if let newValue = Int($0) { editedRecipe.duration = newValue } }
                        ))
                        .keyboardType(.numberPad)

                    }
                }
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
                            Text("Ingredients: \(editedRecipe.ingredients)")
                            Text("Duration: \(editedRecipe.duration) min")
                        }
                        Spacer()
                        
                        VStack {
                            Text("tuto 1 ")
                                .padding(.vertical, 8)
                                .font(.system(size: 20, weight: .bold))
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
                            Text("tuto 2 ")
                                .padding(.vertical, 8)
                                .font(.system(size: 20, weight: .bold))
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
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
                    }
                    .padding(15)
                }
            }
        }
        .navigationBarTitle(editedRecipe.name, displayMode: .inline)
    }
}
