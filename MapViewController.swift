//
//  MapViewController.swift
//  BitGrayTrial
//
//  Created by Jefferson Vélez Escobar on 13/02/17.
//  Copyright © 2017 Jefferson Vélez Escobar. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    
    @IBOutlet var map: MKMapView!
    var mapViewPresenter = MapViewPresenter()
    var activityIndicator = UIActivityIndicatorView()
    var alert = UIAlertController()
    var randomUser : User?
    var furtherUser: User?
    var closestUser: User?

    override func viewDidLoad() {
        super.viewDidLoad()

        map.delegate = self
        mapViewPresenter.mapView = self
        mapViewPresenter.viewShouldStart()

    }
 
    @IBAction func placeRandomUser(_ sender: Any) {
        self.placeUserButtonTapped()
    }
    
}

extension MapViewController: MapView {
    
    func placeUserButtonTapped(){
        mapViewPresenter.getUsers()
    }
    func launchView(){
        loadUsers()
    }
    func setUsers(_ randomUser: User,_ furtherUser: User,_ closestUser: User) {
        self.randomUser = randomUser
        self.furtherUser = furtherUser
        self.closestUser = closestUser
    }
    func placeUsers(){
        drawUsers()
    }
    func launcActivityIndicator(){
        self.activityIndicator.center = self.view.center
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        self.activityIndicator.tintColor = UIColor.green
        self.view.addSubview(self.activityIndicator)
        disableViewElements()
        self.activityIndicator.startAnimating()
    }
    func hideActivityIndicator(){
        self.activityIndicator.stopAnimating()
        self.enableViewElements()
    }
    func alertUser(){
        handleAlertView()
    }
}




