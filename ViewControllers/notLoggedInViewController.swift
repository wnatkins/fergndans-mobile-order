//
//  notLoggedInViewController.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 9/30/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import UIKit

class notLoggedInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Helper.styleFilledButton(loginButton)
        Helper.styleFilledButton(signUpButton)
        // Do any additional setup after loading the view.
    }
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> notLoggedInViewController {
      let controller = storyboard.instantiateViewController(withIdentifier: "notLoggedIn") as! notLoggedInViewController
      return controller
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    
    
    
    
    
    

}
