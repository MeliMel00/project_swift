import SwiftUI

struct ContentView: View {
    @State private var recipes = [
        Recipe(name: "Spaghetti Bolognese", imageUrl: "https://images.unsplash.com/photo-1595295333158-4742f28fbd85?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHNwYWdoZXR0aXxlbnwwfHwwfHx8MA%3D%3D", ingredients: "Pâtes, sauce tomate, viande hachée, oignons", duration: 30),
        Recipe(name: "Salade César", imageUrl: "https://images.unsplash.com/photo-1547496502-affa22d38842?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHNhbGFkZSUyMGNlc2FyfGVufDB8fDB8fHww", ingredients: "Laitue, poulet, croûtons, parmesan", duration: 15),
    ]
    @State private var showingNewRecipeView = false

    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        RecipeRow(recipe: recipe)
                    }
                }
            }
            .navigationBarTitle("Ma App", displayMode: .inline)
            .navigationBarItems(
                trailing: HStack {
                    Button(action: {
                        self.showingNewRecipeView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .sheet(isPresented: $showingNewRecipeView) {
                        NewRecipeView(recipes: $recipes)
                    }
                }
            )
        }
    }
}

struct RecipeRow: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: recipe.imageUrl))
            { image in
                image.resizable()
                .cornerRadius(8)
                .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 75, height: 75)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text("Ingrédients: \(recipe.ingredients)")
                    .font(.subheadline)
                Text("Durée: \(recipe.duration) minutes")
                    .font(.subheadline)
            }
        }
    }
}

struct RecipeDetailView: View {
    var recipe: Recipe
    
    var body: some View {
        VStack {
            Text(recipe.name)
                .font(.largeTitle)
            AsyncImage(url: URL(string: recipe.imageUrl))
            { image in
                image.resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(8)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 200, height: 200)
            
            Text(recipe.ingredients)
            Text("\(recipe.duration) min")
        }
        .navigationBarTitle(recipe.name, displayMode: .inline)
    }
}

struct NewRecipeView: View {
    @State private var recipeName = ""
    @State private var recipeImageUrl = ""
    @State private var recipeIngredients = ""
    @State private var recipeDuration = ""
    @Binding var recipes: [Recipe] // Added binding for updating ContentView
    @Environment(\.presentationMode) var presentationMode // Added presentationMode

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
                    Button("Ajouter la recette") {
                        // Check that required fields are filled
                        guard !recipeName.isEmpty, !recipeImageUrl.isEmpty, !recipeIngredients.isEmpty, let duration = Int(recipeDuration) else {
                            return
                        }

                        // Add the new recipe to the list
                        let newRecipe = Recipe(name: recipeName, imageUrl: recipeImageUrl, ingredients: recipeIngredients, duration: duration)
                        recipes.append(newRecipe)

                        // Dismiss the modal view
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Nouvelle Recette", displayMode: .inline)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Recipe: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var ingredients: String
    var duration: Int
}
