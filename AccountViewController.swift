//
//  AccountViewController.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 9/21/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import UIKit
import FirebaseAuth
import Foundation
import FirebaseUI
import Firebase

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var user: [Users] = []
    var current: Users!
    private var documents: [DocumentSnapshot] = []
    private var listener : ListenerRegistration!
    @IBOutlet weak var myTable: UITableView!
    let controller = notLoggedInViewController.fromStoryboard()
    var handle: AuthStateDidChangeListenerHandle!
    var activeUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user{
                if(self.activeUser != user){
                    self.activeUser = user
                    Firestore.firestore().collection("users").document(user.uid).getDocument { (document, error) in
                            if let current = document.flatMap({
                                $0.data().flatMap({ (data) in
                                    return Users(userdict: data)
                                })
                            }) {
                                self.user.append(current)
                                print("User: \(current)")
                            } else {
                                print("Document does not exist")
                            }
                        self.myTable.reloadData()
                    }
                }
            }
            else{
                self.navigationController?.pushViewController(self.controller, animated: true)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let firstCell = tableView.dequeueReusableCell(withIdentifier: "accountCell", for: indexPath as IndexPath) as! accountCell
        let item = user[0]
        firstCell.firstName.text = item.firstName
        firstCell.lastName.text = item.lastName
        firstCell.email.text = item.email
        firstCell.phoneNumber.text = item.phoneNumber
        firstCell.firstName.font = UIFont.init(name: "Amatic SC", size: 20.0)
        firstCell.lastName.font = UIFont.init(name: "Amatic SC", size: 20.0)
        firstCell.email.font = UIFont.init(name: "Amatic SC", size: 20.0)
        firstCell.phoneNumber.font = UIFont.init(name: "Amatic SC", size: 20.0)
        Helper.styleFilledButton(firstCell.logOutButton)
        return firstCell
    }
    
    @IBAction func logOutTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you would like to log out?", message: "You cannot place mobile orders if you log out!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            do {
                try Auth.auth().signOut()
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true)
        }))
    }
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> AccountViewController {
      let controller = storyboard.instantiateViewController(withIdentifier: "AccountViewController") as! AccountViewController
      return controller
    }
}



class accountCell: UITableViewCell{
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var logOutButton: UIButton!
}
