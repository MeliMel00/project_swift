//
//  Recipe.swift
//  project_swift_melvin
//
//  Created by CHEVALLIER Melvin on 22/11/2023.
//

import Foundation


struct Recipe: Identifiable, Decodable {
    var id: Int?
    var name: String
    var ingredients: [String]
    var imageUrl : String
    var calories : Double

}
