//
//  UserProfileView.swift
//  project_swift_melvin
//
//  Created by CHEVALLIER Melvin on 23/11/2023.
//

import Foundation
import SwiftUI

struct UserProfileView: View {
    @ObservedObject var userManager: UserManager

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Profile")) {
                    TextField("First Name", text: $userManager.user.firstName)
                    TextField("Last Name", text: $userManager.user.lastName)
                    TextField("Email", text: $userManager.user.email)
                }
            }
            .navigationBarTitle("User Profile", displayMode: .inline)
            .onDisappear {
                userManager.saveUser()
            }
        }
    }
}
