//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by MAKAN on 29.05.2020.
//  Copyright © 2020 YUNUS MAKAN. All rights reserved.
//

import Foundation
import UIKit

class PlaceModel{
    
    //SINGLETON YAPISI
    static let sharedInstance = PlaceModel() // paylasilan obje(sharedInstance) kim kullanilsa kullanasin bu objeyi elde edebilecek.
    
    var placeName = ""
    var placeType = ""
    var placeAtmasphere = ""
    var placeImage = UIImage()
    
    
    private init () { }
    
    
}
