//
//  MapVC.swift
//  Rooms24india
//
//  Created by admin on 05/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapTitle: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    func openMaps()  {
        let coordinateOne = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 28.5355)!, longitude: CLLocationDegrees(exactly: 77.3910)!)
                let coordinateTwo = CLLocationCoordinate2D(latitude: CLLocationDegrees(exactly: 28.5904)!, longitude: CLLocationDegrees(exactly: 78.5718)!)
                self.getDirections(loc1: coordinateOne, loc2: coordinateTwo)
    }
    
  func getDirections(loc1: CLLocationCoordinate2D, loc2: CLLocationCoordinate2D) {
       let source = MKMapItem(placemark: MKPlacemark(coordinate: loc1))
       source.name = "Your Location"
       let destination = MKMapItem(placemark: MKPlacemark(coordinate: loc2))
       destination.name = "Destination"
       MKMapItem.openMaps(with: [source, destination], launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
    
    @IBAction func btnBackction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

}
