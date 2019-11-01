//
//  CityViewController.swift
//  Lab4
//
//  Created by Cody Tavenner on 2/18/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit
import MapKit

class CityViewController: UIViewController {
    var selectedCity:String?

    @IBOutlet weak var cityIMG: UIImageView!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var cityTitle: UILabel!
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var search: UITextField!
    @IBOutlet weak var showLat: UITextField!
    @IBOutlet weak var showLong: UITextField!
    @IBOutlet weak var mapType: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        let geoCoder = CLGeocoder();
        let city = selectedCity!
        CLGeocoder().geocodeAddressString(city, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Geocode failed: \(error!.localizedDescription)")
                } else if placemarks!.count > 0 {
                    let placemark = placemarks![0]
                    let location = placemark.location
                    let coords = location!.coordinate
                    self.showLat.text = String(location!.coordinate.latitude)
                    self.showLong.text = String(location!.coordinate.longitude)
                    print(location)
                    
                    let span = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
                    let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                    self.map.setRegion(region, animated: true)
                    let ani = MKPointAnnotation()
                    ani.coordinate = placemark.location!.coordinate
                    ani.title = placemark.locality
                    ani.subtitle = placemark.subLocality
                    
                    self.map.addAnnotation(ani)
                    
                    
                }
        })
        
        if selectedCity! == "Tempe" {
            cityIMG.image = UIImage(named: "tempe.jpeg")
            cityTitle.text = "Tempe"
            cityDescription.text = "Tempe is a city located in Arizona."
        }
        else if selectedCity! == "Chandler"{
            cityIMG.image = UIImage(named: "chandlet.jpeg")
            cityTitle.text = "Chandler"
            cityDescription.text = "Chandler is a city located in Arizona."
        }
        else if selectedCity! == "Gilbert"{
            cityIMG.image = UIImage(named: "gilbert.jpeg")
            cityTitle.text = "Gilbert"
            cityDescription.text = "Gilbert is a city located in Arizona."
        }
        else if selectedCity! == "San Diego"{
            cityIMG.image = UIImage(named: "san diego.jpeg")
            cityTitle.text = "San Diego"
            cityDescription.text = "San Diego is a city located in Southern California."
        }
        else if selectedCity! == "Denver"{
            cityIMG.image = UIImage(named: "denver.jpeg")
            cityTitle.text = "Denver"
            cityDescription.text = "Denver is a city located in Colorado."
        }
        else{
            cityIMG.image = UIImage(named: "tempe.jpeg")
            cityTitle.text = selectedCity
            cityDescription.text = "This is a new city."
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func showResults(_ sender: UIButton) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = self.search.text
        request.region = map.region
        let search = MKLocalSearch(request: request)
        
        search.start { response, _ in
            guard let response = response else {
                return
            }
            print(response.mapItems)
            var matchingItems:[MKMapItem] = []
            matchingItems = response.mapItems
            for i in 1...matchingItems.count - 1
            {
                let place = matchingItems[i].placemark
                let ani = MKPointAnnotation()
                ani.coordinate = place.location!.coordinate
                ani.title = place.name
                ani.subtitle = place.subLocality
                
                self.map.addAnnotation(ani)
                
            }
            
        }
    }
    
    @IBAction func chooseType(_ sender: UISegmentedControl) {
        switch(mapType.selectedSegmentIndex)
        {
        case 0:
            map.mapType = MKMapType.standard
            
        case 1:
            map.mapType = MKMapType.satellite
            
        default:
            map.mapType = MKMapType.standard
        }
    }
}
