import SwiftUI

struct ContentView: View {
    @State private var showingNewRecipeView = false
    @State private var apiRecipes: [RecipeInfo] = []
    @EnvironmentObject var network: Network
    @StateObject private var userManager = UserManager()
    @State private var showingUserProfile = false
    var body: some View {
        NavigationView {
            List {
                ForEach(network.recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe, recipes: $network.recipes)) {
                        RecipeRow(recipe: recipe)
                    }
                }
                
            }
            .navigationBarTitle("MyRecipeat", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                                    showingUserProfile.toggle()
                                }) {
                                    Image(systemName: "person.crop.circle")
                                }
                                .sheet(isPresented: $showingUserProfile) {
                                    UserProfileView(userManager: userManager)
                                },
                trailing: HStack {
                    Button(action: {
                        self.showingNewRecipeView.toggle()
                    }) {
                        Image(systemName: "plus.circle.fill")
                    }
                    .sheet(isPresented: $showingNewRecipeView) {
                        NewRecipeView(recipes: $network.recipes)
                    }
                }
                    
            )
        }
        .onAppear {
            network.fetchRecipes(
            )
        }    }
}
func forTrailingZero(temp: Double) -> String {
    let tempVar = String(format: "%g", temp)
    return tempVar
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
                Text("Calories: \(forTrailingZero(temp: recipe.calories.rounded()))")
                    .font(.subheadline)
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}

//struct Recipe: Identifiable, Hashable {
//    var id = UUID()
//    var name: String
//    var imageUrl: String
//    var ingredients: String
//    var duration: Int
//}
