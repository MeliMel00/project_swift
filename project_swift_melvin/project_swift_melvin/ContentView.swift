import SwiftUI

struct ContentView: View {
    @State private var showingNewRecipeView = false
    @State private var recipes = RecipeData.recipes

    var body: some View {
        NavigationView {
            List {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe, recipes: $recipes)) {
                        RecipeRow(recipe: recipe)
                    }
                }
            }
            .navigationBarTitle("MyRecipeat", displayMode: .inline)
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




//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct Recipe: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var imageUrl: String
    var ingredients: String
    var duration: Int
}
