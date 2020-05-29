//
//  AddPlaceVC.swift
//  FoursquareClone
//
//  Created by MAKAN on 28.05.2020.
//  Copyright © 2020 YUNUS MAKAN. All rights reserved.
//

import UIKit

//var globalName = ""
//var globalType = ""
//var globalAtmasphere = ""
//var globalImage = UIImage()

 
class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameText: UITextField!
    @IBOutlet weak var placeTypeText: UITextField!
    @IBOutlet weak var placeAtmosphereText: UITextField!
    @IBOutlet weak var placeImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        placeImageView.isUserInteractionEnabled = true //gorsele tiklanabilir anlamina gelir
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    
    @objc func chooseImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
        
        
    }
    
    //RESIM SECILDIKTEN SONRA NE OLACAGINI BELIRLEYEN FINKSIYON.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
         
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
   
    @IBAction func nextButtonClicked(_ sender: Any) {
        
        //globalName = placeNameText.text!  global seklinda haritaya aktarma islemi
        
        if placeNameText.text != "" && placeTypeText.text != "" && placeAtmosphereText.text != ""{
            if let chosenImage = placeImageView.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameText.text!
                placeModel.placeType = placeTypeText.text!
                placeModel.placeAtmasphere = placeAtmosphereText.text!
                placeModel.placeImage = chosenImage
                
            }
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        
        }else {
            let alert = UIAlertController(title: "Error", message: "Place/Name/Type/Atmosphere?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            present(alert, animated: true, completion: nil)
            
        }
        
    }
    
}
