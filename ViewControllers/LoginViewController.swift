//
//  LoginViewController.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 9/22/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

extension UIViewController{
    func hideKeyboardOnTapOnView2(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard2))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
    }
    @objc func dismissKeyboard2(){
        view.endEditing(true)
    }
}

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var loginEmailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()

        // Do any additional setup after loading the view.
    }
    
    func setUpElements(){
        errorLabel.alpha = 0
        Helper.styleFilledButton(loginButton)
        Helper.styleTextField(loginEmailTextField)
        Helper.styleTextField(passwordTextField)
    }
    
    
    @IBAction func loginPressed(_ sender: Any) {
        activityIndicator.startAnimating()
        let email = loginEmailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                   if error != nil {
                    self.activityIndicator.stopAnimating()
                       // Couldn't sign in
                       self.errorLabel.text = error!.localizedDescription
                       self.errorLabel.alpha = 1
                   }
        self.navigationController?.popToRootViewController(animated: true)
        }
    }
}
