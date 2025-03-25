//
//  ContentView.swift
//  Practice2
//
//  Created by Jose Britto Saaji on 2025-03-25.
//

import SwiftUI
import CoreData
import CoreMotion

struct ContentView: View {
    
    @StateObject private var motionManager = MotionManager()
    
    @Environment(\.managedObjectContext)
        var context
    
    @FetchRequest(sortDescriptors: [])
    var items:FetchedResults<Item>
    
    private let formatter: DateFormatter
    
    init () {
        self.formatter = DateFormatter()
        self.formatter.dateStyle = .medium
        self.formatter.timeStyle = .short
    }
    
    var body: some View {
        VStack {
            Text("Accelerometer Data")
                .font(.headline)
            
            Text("X: \(motionManager.accelerationX)")
            Text("Y: \(motionManager.accelerationY)")
            Text("Z: \(motionManager.accelerationZ)")
            
            List {
                ForEach(items, id: \.self) {
                    item in
                    HStack {
                        Text("X: \(String(format: "%.2f", item.x))")
                        Text("Y: \(String(format: "%.2f", item.y))")
                        Text("Z: \(String(format: "%.2f", item.z))")
                        let formattedDate = formatter.string(from: item.timestamp ?? Date())
                        Text("Time: \(formattedDate)")
                    }
                }
            }
        }
        .onAppear {
            let item = Item(context: context)
            item.x = motionManager.accelerationX
            item.y = motionManager.accelerationY
            item.z = motionManager.accelerationZ
            item.timestamp = Date()
            try? context.save()
        }
        .padding()
    }
}
