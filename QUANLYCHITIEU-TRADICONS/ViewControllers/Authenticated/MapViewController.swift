//
//  MapViewController.swift
//  QUANLYCHITIEU-TRADICONS
//
//  Created by trinh truong vu on 9/10/18.
//  Copyright © 2018 TRUONGVU. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation



class MapViewController: UIViewController {
    let mapView: GMSMapView = {
        let mapView = GMSMapView()
        
        return mapView
    }()
    
    var makers: [String: GMSMarker] = [:]
    
    let locitionManager: CLLocationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.setupView()
        self.setupConstaints()
        
        
        mapView.isMyLocationEnabled = true
        locitionManager.requestWhenInUseAuthorization()
        locitionManager.startUpdatingLocation()
        locitionManager.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        FIRManager.shared.userRef.observe(.value) { (snapshot) in
            guard let usersDict = snapshot.value as? [String: Any] else{return}
            
//            self.users.removeAll()
//            self.makers.forEach({ (maker) in
//                maker.map = nil
//            })
//           self.makers.removeAll()
            
            for (_, value) in usersDict {
                
                if let userDict = value as? [String: Any],
                    let id = userDict["id"] as? String,
                    let email = userDict["email"] as? String,
                    let location = userDict["location"] as? [String: Any]
                    
                {
                 let locationUser = CLLocationCoordinate2D(latitude: location["latitude"] as? Double ?? 0, longitude: location["longitude"] as? Double ?? 0)
                    if let exstiedMaker = self.makers[id]{
                        exstiedMaker.position = locationUser
                    }
                        
                    else {
                        let userMaker = GMSMarker(position: locationUser)
                        userMaker.map = self.mapView
                        userMaker.snippet = "\(id) - \(email)"
                        userMaker.icon = GMSMarker.markerImage(with: UIColor.random())
                        self.makers[id] = userMaker
                    }
                
                }
//                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate func setupView(){
        
        self.view.addSubview(mapView)
        
    }
    
    fileprivate func setupConstaints(){
        mapView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }

}
extension MapViewController: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location = locations.first else {return}
        
        let camera = GMSCameraPosition.camera(withTarget: location.coordinate, zoom: 15)
        mapView.animate(to: camera)
        
        FIRManager.shared.myUserRef.child("location").setValue([
            "latitude" : location.coordinate.latitude,
            "longitude" : location.coordinate.longitude
            ])
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red:   .random(),
                       green: .random(),
                       blue:  .random(),
                       alpha: 1.0)
    }
}
