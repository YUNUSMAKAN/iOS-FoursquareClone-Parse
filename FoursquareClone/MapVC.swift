//
//  MapVC.swift
//  FoursquareClone
//
//  Created by MAKAN on 28.05.2020.
//  Copyright © 2020 YUNUS MAKAN. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveButtomClicked))
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backButtomClicked))
        
    }
    
    @objc func saveButtomClicked(){
        //PARSE SAVE
        
    }
    
    @objc func backButtomClicked(){
        
        //navigationController?.popViewController(animated: true) burada bunu kullanarak geri gidemeyiz direk navigation arkasindan oldugu icin.
        self.dismiss(animated: true, completion: nil)
        
    }

    

}
