//
//  Practice2App.swift
//  Practice2
//
//  Created by Jose Britto Saaji on 2025-03-25.
//

import SwiftUI

@main
struct Practice2App: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
