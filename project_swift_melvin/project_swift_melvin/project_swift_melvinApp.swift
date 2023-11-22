//
//  project_swift_melvinApp.swift
//  project_swift_melvin
//
//  Created by CHEVALLIER Melvin on 20/11/2023.
//

import SwiftUI

@main
struct project_swift_melvinApp: App {
    var network = Network()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(network)
        }
    }
}
