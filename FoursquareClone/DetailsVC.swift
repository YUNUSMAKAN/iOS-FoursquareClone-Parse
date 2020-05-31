//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by MAKAN on 28.05.2020.
//  Copyright © 2020 YUNUS MAKAN. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsTypeLabel: UILabel!
    @IBOutlet weak var detailsAtmosphereLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    var chosenPlaceId = ""
    
    var chosenLatitude = Double()
    var chosenLongitude = Double()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        detailsMapView.delegate = self
        
    }
    
    func getDataFromParse(){
        //Parsedan secilenin bilgilerini cekme islemi.
               let query = PFQuery(className: "Places")
               query.whereKey("objectId", equalTo: chosenPlaceId) //filtreleme islemi
               query.findObjectsInBackground { (objects, error) in
                   if error != nil {
                       
                   }else{
                       if objects != nil {
                           if objects!.count > 0 {
                               let chosenPlaceObject = objects![0]
                            
                              //OBJECTS
                               
                               if let placeName = chosenPlaceObject.object(forKey: "name") as? String {
                                   self.detailsNameLabel.text = placeName
                               }
                               
                               if let placeType = chosenPlaceObject.object(forKey: "type") as? String {
                                   self.detailsTypeLabel.text = placeType
                               }
                               
                               if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String {
                                   self.detailsAtmosphereLabel.text = placeAtmosphere
                               }
                               
                               //Haritadaki bolgeyi gostermek icin gerekli latitude ve longitude aliriz.
                               if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String {
                                   if let placeLatitudeDouble = Double(placeLatitude) { //Aldigimiz degeri double a cevirdik.
                                       self.chosenLatitude = placeLatitudeDouble
                                   }
                               }
                               
                               if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String { // string olarak kaydettigimiz icin string cast ederiz.
                                   if let placeLongitudeDouble = Double(placeLongitude) { //Aldigimiz degeri double a cevirdik.
                                       self.chosenLongitude = placeLongitudeDouble
                                   }
                                   
                               }
                               
                               //Parse dan gorseli alma islemi.
                               if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject {
                                   imageData.getDataInBackground { (data, error) in
                                       if error == nil {
                                           if data != nil {
                                               self.detailsImageView.image = UIImage(data: data!)
                                               
                                           }
                                           
                                       }
                                   }
                               }
                            
                             //MAPS
                            let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
                            
                            let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                            
                            let region = MKCoordinateRegion(center: location, span: span)
                            
                            self.detailsMapView.setRegion(region, animated: true)
                            
                            //Add annotation
                            let annotation = MKPointAnnotation()
                            annotation.coordinate = location
                            annotation.title = self.detailsNameLabel.text!
                            annotation.subtitle = self.detailsTypeLabel.text!
                            self.detailsMapView.addAnnotation(annotation)
                            
                               
                           }
                       }
                   }
               }

           }
           

    //Navigasyon Ekleme islemi
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation is MKUserLocation {
            return nil
        }
        
        //Buton olusturlmasi
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true //sag tarafinda buton gostermesine izin verdik.
            let button = UIButton(type: .detailDisclosure) //Bu bir tane i isareti cikarir.
            pinView?.rightCalloutAccessoryView = button
            
        }else {
            pinView?.annotation = annotation
        }
        
        return pinView
        
    }
    
    //Butona tiklaninca google haritaya goturme islemi.
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if self.chosenLongitude != 0.0 && self.chosenLatitude != 0.0 {
            let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongitude)
            
            //CLGeocoder :Kordinatlar ve yerler arasindaki isimleri bize verir.
            CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                if let placemark = placemarks {
                    
                    if placemark.count > 0 {
                        
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.detailsNameLabel.text
                        
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]  //Araba ile nasil gidilecegini gosterir.
                        
                        mapItem.openInMaps(launchOptions: launchOptions)
                        
                    }
                }
            }
        }
    }

    
}
