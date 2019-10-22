//
//  CartViewController.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 10/21/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import UIKit
import Foundation

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var myTable: UITableView!

    var cartItems: [Menu] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        myTable.reloadData()
    }
    
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> CartViewController {
      let controller = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
      return controller
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Items.sharedInstance.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath as IndexPath) as! cartCell
        cell.name.text = Items.sharedInstance.array[indexPath.row].name
        cell.price.text = Items.sharedInstance.array[indexPath.row].price
        cell.name.font = UIFont.init(name: "AmaticSC-Bold", size: 20.0)
        cell.price.font = UIFont.init(name: "AmaticSC-Bold", size: 20.0)
        return cell
    }

}

class cartCell: UITableViewCell{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
}
