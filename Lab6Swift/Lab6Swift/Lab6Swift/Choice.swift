//
//  Choice.swift
//  NavigationInSwiftUI
//
//  Created by Hardik Kumar . on 2025-02-14.
//

import Foundation
struct Choice:Identifiable,Hashable{
    var id = UUID()
    let name:String
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
