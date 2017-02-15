//
//  ExtraViewsOnMapView.swift
//  BitGrayTrial
//
//  Created by Jefferson Vélez Escobar on 15/02/17.
//  Copyright © 2017 Jefferson Vélez Escobar. All rights reserved.
//

import Foundation
import UIKit

extension MapViewController {
    
    func enableViewElements(){
        self.view.endEditing(false)
        self.view.isUserInteractionEnabled = true
        self.navigationController?.view.isUserInteractionEnabled = true
    }
    func disableViewElements(){
        self.view.endEditing(true)
        self.view.isUserInteractionEnabled = false
        self.navigationController?.view.isUserInteractionEnabled = false
    }
    func handleAlertView(){
        let title = "Alerta"
        let retryTitle = "Reintentar"
        let message = "Necesitas una conexión a internet para tener una experiencia genial en la app! Asegúrate de tener una y presiona reintentar"
        self.alert = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: UIAlertControllerStyle.alert)
        self.present(alert, animated: true, completion: nil)
        self.alert.addAction(UIAlertAction(title: retryTitle, style: .default, handler: { action in
            self.mapViewPresenter.checkUsersReloading(action)
        }))
    }
    
    func loadUsers(){
        UIView.animateKeyframes(withDuration: 2.0, delay: 0.0, options: [UIViewKeyframeAnimationOptions.calculationModeLinear], animations: {
        }, completion: {finished in
            sleep(UInt32(0.5))
            self.mapViewPresenter.loadUsers()
        })
    }
}
