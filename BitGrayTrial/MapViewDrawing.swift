//
//  MapViewDisplaying.swift
//  BitGrayTrial
//
//  Created by Jefferson Vélez Escobar on 15/02/17.
//  Copyright © 2017 Jefferson Vélez Escobar. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController {
    
    func drawUsers(){
        
        let randomLat = CLLocationDegrees(((self.randomUser?.address?.geo?.lat)! as NSString).floatValue)
        let randomLng = CLLocationDegrees(((self.randomUser?.address?.geo?.lng)! as NSString).floatValue)
        let randomUserLocation = CLLocation(latitude: randomLat, longitude: randomLng)
        let randomTitle = self.randomUser?.name
        let randomLocationName = self.randomUser?.address?.street
        let randomId = self.randomUser?.id
        let randomString = "Random User"
        let furtherLat = CLLocationDegrees(((self.furtherUser?.address?.geo?.lat)! as NSString).floatValue)
        let furtherLng = CLLocationDegrees(((self.furtherUser?.address?.geo?.lng)! as NSString).floatValue)
        let furtherTitle = self.furtherUser?.name
        let furtherLocationName = self.furtherUser?.address?.street
        let furtherId = self.furtherUser?.id
        let furtherString = "Further User"
        let closestLat = CLLocationDegrees(((self.closestUser?.address?.geo?.lat)! as NSString).floatValue)
        let closestLng = CLLocationDegrees(((self.closestUser?.address?.geo?.lng)! as NSString).floatValue)
        let closestTitle = self.closestUser?.name
        let closestLocationName = self.closestUser?.address?.street
        let closestId = self.closestUser?.id
        let closestString = "Closest User"
        
        let randomUserAnotation = AnotationHelper(title: randomTitle!,
                                                  locationName: randomLocationName! + ": " + randomString,
                                                  id: randomId!,
                                                  coordinate:
                                                  CLLocationCoordinate2D(latitude: randomLat,
                                                                         longitude: randomLng))
        let furtherUserAnotation = AnotationHelper(title: furtherTitle!,
                                                   locationName: furtherLocationName! + ": " + furtherString,
                                                   id: furtherId!,
                                                   coordinate:
                                                   CLLocationCoordinate2D(latitude: furtherLat,
                                                                          longitude: furtherLng))
        
        let closestUserAnotation = AnotationHelper(title: closestTitle!,
                                                   locationName: closestLocationName! + ": " + closestString,
                                                   id: closestId!,
                                                   coordinate:
                                                   CLLocationCoordinate2D(latitude: closestLat,
                                                                          longitude: closestLng))
        
        cleanMap()
        centerMapOnLocation(location: randomUserLocation)
        map.addAnnotation(randomUserAnotation)
        map.addAnnotation(furtherUserAnotation)
        map.addAnnotation(closestUserAnotation)
    }
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 10.0,
                                                                  regionRadius * 10.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    func cleanMap() {
        let allAnnotations = self.map.annotations
        self.map.removeAnnotations(allAnnotations)
        
    }
}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? AnotationHelper {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            view.pinTintColor = annotation.pinColor()
            
            return view
        }
        return nil
    }
}
