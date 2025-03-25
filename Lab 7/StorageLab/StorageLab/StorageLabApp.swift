//
//  StorageLabApp.swift
//  StorageLab
//
//  Created by Tech on 2025-03-11.
//

import SwiftUI

@main
struct StorageLabApp: App {
    @StateObject private var dataController = DataController()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
