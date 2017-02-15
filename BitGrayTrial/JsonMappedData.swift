//
//  MappedData.swift
//  BitGrayTrial
//
//  Created by Jefferson Vélez Escobar on 13/02/17.
//  Copyright © 2017 Jefferson Vélez Escobar. All rights reserved.
//

import Foundation
import ObjectMapper


class JsonMap {

    var users: [User]?
    init() {
    }
}

class User: Mappable {
    
    var name: String?
    var address: Address?
    var id: Int?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        name <- map["name"]
        address <- map["address"]
        id <- map["id"]
    }
}

class Address: Mappable {
    
    var geo: Geo?
    var street: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        geo <- map["geo"]
        street <- map["street"]
    }
}

class Geo: Mappable {
    
    var lat: String?
    var lng: String?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        lat <- map["lat"]
        lng <- map["lng"]
    }
}
