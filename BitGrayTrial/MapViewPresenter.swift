//
//  MapViewPresenter.swift
//  BitGrayTrial
//
//  Created by Jefferson Vélez Escobar on 13/02/17.
//  Copyright © 2017 Jefferson Vélez Escobar. All rights reserved.
//

import Foundation
import UIKit

protocol MapView{
    
    func launchView()
    func setUsers(_ randomUser: User,_ furtherUser: User,_ closestUser: User)
    func placeUsers()
    func launcActivityIndicator()
    func hideActivityIndicator()
    func alertUser()
}

class MapViewPresenter{

    var mapView: MapView?
    var mapViewService = MapViewService()
    var randomUser: User?
    var closestUser: User?
    var furtherUser: User?
    
    func viewShouldStart(){
        mapView?.launchView()
    }
    func loadUsers(){
        if mapViewService.isConnectionAvailble() {
            mapView?.launcActivityIndicator()
            mapViewService.loadUsers { () in
                self.getUsers()
            }
        }else{
            mapView?.alertUser()
        }
    }
    func getUsers(){
        self.randomUser = self.mapViewService.getRandomUser()
        self.furtherUser = self.mapViewService.getFurtherUserTo(randomUser: self.randomUser!)
        self.closestUser = self.mapViewService.getClosestUserTo(randomUser: self.randomUser!)
        mapView?.setUsers(self.randomUser!, self.furtherUser!, self.closestUser!)
        mapView?.placeUsers()
        mapView?.hideActivityIndicator()
    }
    func checkUsersReloading(_ action: UIAlertAction){
        switch action.style{
        case .default:
            self.loadUsers()
        case .cancel:
            print("cancel")
        case .destructive:
            print("destructive")
        }
    }
    
}
