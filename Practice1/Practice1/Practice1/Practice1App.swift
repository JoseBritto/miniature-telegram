//
//  Practice1App.swift
//  Practice1
//
//  Created by Jose Britto Saaji on 2025-03-24.
//

import SwiftUI

@main
struct Practice1App: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
