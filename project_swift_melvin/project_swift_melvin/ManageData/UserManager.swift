//
//  UserManager.swift
//  project_swift_melvin
//
//  Created by CHEVALLIER Melvin on 23/11/2023.
//

import Foundation

class UserManager: ObservableObject {
    @Published var user: User

    init() {
        // Default values, change as needed
        user = User(firstName: "", lastName: "", email: "")
        loadUser()
    }

    func saveUser() {
        if let encodedData = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encodedData, forKey: "user")
        }
    }

    func loadUser() {
        if let savedData = UserDefaults.standard.data(forKey: "user") {
            if let loadedUser = try? JSONDecoder().decode(User.self, from: savedData) {
                user = loadedUser
            }
        }
    }
}
