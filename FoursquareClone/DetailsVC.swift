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

class DetailsVC: UIViewController {

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
                               
                           }
                       }
                   }
               }

           }
           


    
}
