//
//  DataController.swift
//  Practice2
//
//  Created by Jose Britto Saaji on 2025-03-25.
//

import CoreData
import Foundation

class DataController : ObservableObject {
    
    let container = NSPersistentContainer(name: "Practice2");
    
    init() {
        container.loadPersistentStores {
            description, error in
            if let e = error{
                print("CoreData failed to load: \(e.localizedDescription)")
            }
        }
    }
}
