//
//  SignUpViewController.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 9/21/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

extension UIViewController{
    func hideKeyboardOnTapOnView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

class SignUpViewController: UIViewController {
   
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var user: Users!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTapOnView()
        errorLabel.alpha = 0
        activityIndicator.hidesWhenStopped = true

        Helper.styleTextField(firstNameTextField)
        Helper.styleTextField(lastNameTextField)
        Helper.styleTextField(emailTextField)
        Helper.styleTextField(phoneNumberTextField)
        Helper.styleTextField(passwordTextField)
        Helper.styleFilledButton(signUpButton)
    }
    
    
    
    
    //validate text field info is valid and return error message otherwise
    func validateFields() -> String?{
        //check fields are filled
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            return "Please fill in all fields."
        }
        return nil
    }
    
    
    @IBAction func signUpPressed(_ sender: Any) {
        //Validate the Fields
        let error = validateFields()
        if error != nil{
            //show error message
            showError(error!)
            
        }
        else{
            self.activityIndicator.startAnimating()
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let phoneNumber = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                //Check for errors
                
                if err != nil{
                    self.activityIndicator.stopAnimating()
                    self.showError("Error creating user.")
                }
                else{
                    let db = Firestore.firestore()
                    db.collection("users").document(result!.user.uid).setData(["firstName":firstName, "lastName":lastName, "phoneNumber":phoneNumber, "email":email]) { (error) in
                        if error != nil{
                            self.showError("Error saving user data.")
                        }
                        else{
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                        
                    }
                }
            }
    }
        
}
    
    func showError(_ message:String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
   // }
    

}
