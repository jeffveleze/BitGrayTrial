//
//  AnotationHelper.swift
//  BitGrayTrial
//
//  Created by Jefferson Vélez Escobar on 14/02/17.
//  Copyright © 2017 Jefferson Vélez Escobar. All rights reserved.
//

import Foundation
import MapKit

class AnotationHelper: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let id: Int
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, id: Int, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.id = id
        self.coordinate = coordinate
    
        super.init()
    }
    
    var subtitle: String? {
        return locationName!
    }
    
    func pinColor() -> UIColor  {
        
        switch id {
        case 1:
            return UIColor.red
        case 2:
            return UIColor.blue
        case 3:
            return UIColor.black
        case 4:
            return UIColor.yellow
        case 5:
            return UIColor.brown
        case 6:
            return UIColor.green
        case 7:
            return UIColor.gray
        case 8:
            return UIColor.orange
        case 9:
            return UIColor.white
        default:
            return UIColor.red
        }
    }
}
