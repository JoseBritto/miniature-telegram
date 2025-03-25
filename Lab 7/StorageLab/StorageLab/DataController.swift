//
//  DataController.swift
//  StorageLab
//
//  Created by Tech on 2025-03-11.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "StorageLab");
    
    init() {
        container.loadPersistentStores{
            description, error in
            if let e = error{
                print("CoreData failed to load: \(e.localizedDescription)")
            }
        }
    }
}
