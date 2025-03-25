//
//  DataController.swift
//  Practice1
//
//  Created by Jose Britto Saaji on 2025-03-24.
//

import CoreData
import Foundation

class DataController : ObservableObject {
    
    let container = NSPersistentContainer(name: "Practice1");
    
    init() {
        container.loadPersistentStores { 
            description, error in
            if let e = error{
                print("CoreData failed to load: \(e.localizedDescription)")
            }
        }
    }
}
