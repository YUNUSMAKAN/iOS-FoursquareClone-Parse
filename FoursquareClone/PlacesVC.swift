//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by MAKAN on 27.05.2020.
//  Copyright © 2020 YUNUS MAKAN. All rights reserved.
//

import UIKit
import Parse

class PlacesVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutButtonClicked))
    }
    

    @objc func addButtonClicked(){
     //segue
        self.performSegue(withIdentifier: "toAddPlaceVC", sender: nil)
   

    }

    @objc func logoutButtonClicked(){
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK!", style: UIAlertAction.Style.default , handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil )
                
            }else {
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
        
        
    }
}
