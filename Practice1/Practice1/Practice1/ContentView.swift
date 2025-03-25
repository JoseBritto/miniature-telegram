//
//  ContentView.swift
//  Practice1
//
//  Created by Jose Britto Saaji on 2025-03-24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @StateObject private var locationManager = LocationManager()
    
    @Environment(\.managedObjectContext)
    var context
    
    @FetchRequest(sortDescriptors: [])
    var items:FetchedResults<Item>
    
    @FetchRequest(sortDescriptors: [])
    var locations:FetchedResults<LocationEntity>
    
    @FetchRequest(sortDescriptors: [])
    var timedLocations:FetchedResults<LocationWithTime>

    
    var body: some View {
        VStack {
            
            if let coords = locationManager.lastLocation {
                Button("Save Location") {
                    let time = Date()
                    let loc = LocationEntity(context: context)
                    loc.latitude = coords.latitude
                    loc.longitude = coords.longitude
                    print("Data")
                    print(coords.latitude)
                    print(coords.longitude)
                    let timedLoc = LocationWithTime(context: context)
                    timedLoc.location = loc
                    timedLoc.timestamp = time
                    try? context.save()
                }
                Text("Locations: ")
                List {
                    ForEach(timedLocations, id:\.self) {
                        timedLoc in
                            Text(String(timedLoc.timestamp?.timeIntervalSince1970 ?? 0))
                    }
                }
            }
            else {
                Text("Fetching Locations")
            }
            
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
        }
    }
}




/*VStack {
 Button(action: {
 let time = Date()
 let item = Item(context: context)
 item.timestamp = time;
 try? context.save()
 }, label: {
 Text("Add Current Time")
 })
 if let coords = locationManager.lastLocation {
 Text("Location available")
 Button(action: {
 var latitude = coords.latitude
 var longitude = coords.longitude
 let loc = LocationEntity(context: context)
 loc.latitude = latitude
 loc.longitude = longitude
 try? context.save()
 }, label: {
 Text("Add Current Coords \n \(coords.latitude) \(coords.longitude)")
 })
 }
 else {
 Button("Get Location") {
 locationManager.checkLocationAuthorization()
 }
 }*/
