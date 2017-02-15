//
//  MapViewService.swift
//  BitGrayTrial
//
//  Created by Jefferson Vélez Escobar on 13/02/17.
//  Copyright © 2017 Jefferson Vélez Escobar. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import SystemConfiguration


class MapViewService {

    let urlServices = "http://jsonplaceholder.typicode.com/users"
    var jsonMap = JsonMap()
    var furtherDistance: Float = 0

    func loadUsers(_ callBack:@escaping () -> Void){
        
        Alamofire.request(urlServices).responseArray { (response: DataResponse<[User]>) in
            
            switch response.result {
            case .success:
                if response.result.value != nil {
                    self.jsonMap.users = response.result.value!
                    callBack()
                } else {
                    print("Request Error")
                }
            case .failure(let error):
                print(error)
                print("Data should be loaded from local")
            }
        }
    }
    
    func isConnectionAvailble()->Bool{
        
        let rechability = SCNetworkReachabilityCreateWithName(kCFAllocatorDefault, "www.google.com")
        var flags : SCNetworkReachabilityFlags = SCNetworkReachabilityFlags()
        if SCNetworkReachabilityGetFlags(rechability!, &flags) == false {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        return (isReachable && !needsConnection)
    }
    
    func getRandomUser() -> User{
        
        let range = (self.jsonMap.users?.count)! - 1
        let randomNumber = arc4random_uniform(UInt32(range))
        let randomUser = self.jsonMap.users![Int(randomNumber)]
        print("El usuario generado aleatoria/ es: ", randomUser.name ?? "Random Name")
        return randomUser
    }
    
    func getClosestUserTo(randomUser: User) -> User{
    
        let randomUserLat = ((randomUser.address?.geo?.lat)! as NSString).floatValue
        let randomUserLng = ((randomUser.address?.geo?.lng)! as NSString).floatValue
        var closestUser: User?
        var closestDistance: Float = furtherDistance
        
        for user in self.jsonMap.users! {
            let userLat = ((user.address?.geo?.lat)! as NSString).floatValue
            let userLng = ((user.address?.geo?.lng)! as NSString).floatValue
            let distance = getDistanceFromLatLonInKm(userLat, userLng, randomUserLat, randomUserLng)
            if distance != 0 {
                if distance < closestDistance {
                    closestDistance = distance
                    closestUser = user
                }
            }
        }
        
        print("La distancia menor es: ",closestDistance)
        print("El usuarion de menor distancia es: ",closestUser?.name ?? "Default")
        
        return closestUser!
    }
    
    func getFurtherUserTo(randomUser: User) -> User{
        
        let randomUserLat = ((randomUser.address?.geo?.lat)! as NSString).floatValue
        let randomUserLng = ((randomUser.address?.geo?.lng)! as NSString).floatValue
        var furtherUser: User?
        var furtherDistance: Float = 0.0
        
        for user in self.jsonMap.users! {
            let userLat = ((user.address?.geo?.lat)! as NSString).floatValue
            let userLng = ((user.address?.geo?.lng)! as NSString).floatValue
            let distance = getDistanceFromLatLonInKm(userLat, userLng, randomUserLat, randomUserLng)
            if distance != 0 {
                if distance > furtherDistance {
                    furtherDistance = distance
                    self.furtherDistance = furtherDistance
                    furtherUser = user
                }
            }
        }
        
        print("La distancia mayor es: ",furtherDistance)
        print("El usuarion de mayor distancia es: ",furtherUser?.name ?? "Default")
        
        return furtherUser!
    }
    
    private func getDistanceFromLatLonInKm(_ lat1: Float,_ lon1: Float,_ lat2: Float,_ lon2: Float) -> Float {
        let R: Float = 6371 // Radius of the earth in km
        let dLat = degToRad(lat2-lat1)  // degTorad below
        let dLon = degToRad(lon2-lon1)
        let a = sin(dLat/2) * sin(dLat/2) +
            cos(degToRad(lat1)) * cos(degToRad(lat2)) *
            sin(dLon/2) * sin(dLon/2)
        let c = 2 * atan2(sqrt(a), sqrt(1-a))
        let d = R * c // Distance in km
        return d
    }
    
    private func degToRad(_ deg: Float) -> Float {
        return deg * (Float.pi/180)
    }
    
    
}
