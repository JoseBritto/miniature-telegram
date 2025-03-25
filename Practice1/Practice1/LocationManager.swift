//
//  LocationManager.swift
//  Practice1
//
//  Created by Jose Britto Saaji on 2025-03-24.
//

import Foundation
import CoreLocation
import CoreData

final class LocationManager : NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var lastLocation: CLLocationCoordinate2D?
    
    
    var manager = CLLocationManager()


    func checkLocationAuthorization() {
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
                
            case .authorizedWhenInUse:
                lastLocation = manager.location?.coordinate
                
            case .authorizedAlways:
                lastLocation = manager.location?.coordinate
                
        case .restricted:
            print("Restricted")
        case .denied:
            print("Denied")
        @unknown default:
                print("No Location Access")
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.first?.coordinate
    }
    
    
    public func saveCurrentLoc(context: NSManagedObjectContext) {
        let time = Date()
        let loc = LocationEntity(context: context)
        loc.latitude = lastLocation?.latitude ?? 0
        loc.longitude = lastLocation?.longitude ?? 0
        let timedLoc = LocationWithTime(context: context)
        timedLoc.location = loc
        timedLoc.timestamp = time
        try? context.save()
    }
}
