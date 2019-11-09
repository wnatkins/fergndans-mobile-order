//
//  HomeViewController.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 9/28/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import UIKit




class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    let menu = ["Pizza", "Panuozzos", "Salads", "Desserts", "Drinks"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.dataSource = self
        myTableView.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath as IndexPath) as! MyCell
        cell.menuLabel.text = menu[indexPath.row]
        cell.menuLabel.font = UIFont.init(name: "AmaticSC-Bold", size: 30.0)
        cell.menuImage.image = UIImage(named: menu[indexPath.row].lowercased())
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = ItemPageViewController.fromStoryboard()
        controller.itemType = menu[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

class MyCell: UITableViewCell{
    @IBOutlet weak var menuLabel: UILabel!
    @IBOutlet weak var menuImage: UIImageView!
}


