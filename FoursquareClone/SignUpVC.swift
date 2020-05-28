//
//  ViewController.swift
//  FoursquareClone
//
//  Created by MAKAN on 20.05.2020.
//  Copyright © 2020 YUNUS MAKAN. All rights reserved.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        //PARSE VERI KAYDETME ISLEMI
        let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { (success, error) in
            if error != nil{
                print(error?.localizedDescription)
            }else {
                print("uploaded")
            }
        
        }
         
        //VERI CEKME ISLEMI
        let query = PFQuery(className: "Fruits")
        //query.whereKey("name", equalTo: "Apple") //filtreleme islemi.ismi elma olanlari getir dedik.
        query.whereKey("calories", greaterThan: 120) //kalorisi 120 den buyuk olanlari getir dedik.
        query.findObjectsInBackground { (objects, error) in
            if error != nil{
                print(error?.localizedDescription)
                
            }else{
                print(objects)
            }
            
        }
        */
      
        
    }
    
    
    //KULLANICI GIRIS
    @IBAction func signInClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { (user, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error" )
                }else {
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Username / Password ??")
        }
        
    }
    
    
    //KULLANICI KAYIT
    @IBAction func signUpClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!!!")
                } else {
                    //Segue
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                    
                }
            }
            
        }else {
            makeAlert(titleInput: "Error", messageInput: "Username/ Password ??")
            
        }
    }
    
    
        
    func makeAlert(titleInput: String , messageInput: String){
        
            let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
            alert.addAction(okButton)
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    
    
}

