//
//  MapVC.swift
//  FoursquareClone
//
//  Created by MAKAN on 28.05.2020.
//  Copyright © 2020 YUNUS MAKAN. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var choosenLatitude = ""
    var choosenLongitude = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtomClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtomClicked))
        
        //Haritada yer gosterme islemi.
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest //yerimizi ne kadar dogru bulucagini belirtiyoruz.
        locationManager.requestWhenInUseAuthorization()  //sadece kullandigim zaman gostermen yeterli dedik.
        locationManager.startUpdatingLocation() //kullanicinin bulundugu yeri guncelleriz.
        
        
        //HARITADA TIKLADIGI YERE PIN EKLEME.
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:))) //uzun basildiginda harekete gecer.
        recognizer.minimumPressDuration = 3 // kac saniye basilmasi gerekli onu belirttik.
        mapView.addGestureRecognizer(recognizer)
        
    }
    
    @objc func chooseLocation(gestureRecognizer : UIGestureRecognizer){
        
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            
            let touches = gestureRecognizer.location(in: self.mapView)
            let coordinates = self.mapView.convert(touches, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlaceModel.sharedInstance.placeName
            annotation.subtitle = PlaceModel.sharedInstance.placeType
            
            self.mapView.addAnnotation(annotation)
            
            self.choosenLatitude = String(coordinates.latitude)
            self.choosenLongitude = String(coordinates.longitude)
            
            
            
        }
        
    }
    
    //KULLANICININ YERI KAYDEDILDIKTEN SONRA NE OLUCAK?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //locationManager.stopUpdatingLocation() //Bu sekilde sadece lokasyon bir defa guncellenir her acildiginda tekrar guncellenmez.
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035) //Ne kadar kucuk yaparsak degerleri o derece zoom edicek.
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    @objc func saveButtomClicked(){
        //PARSE SAVE
        
    }
    
    @objc func backButtomClicked(){
        
        //navigationController?.popViewController(animated: true) burada bunu kullanarak geri gidemeyiz direk navigation arkasindan oldugu icin.
        self.dismiss(animated: true, completion: nil) // bu metod ile direk addplaceVc ye geceniliriz.
        
    }

    

}
