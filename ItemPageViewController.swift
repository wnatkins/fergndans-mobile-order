//
//  ItemPageViewController.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 10/1/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import UIKit
import Firebase


class ItemPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTable: UITableView!
    
    var menuItems: [Menu] = []
    var cartItems: [Menu] = []
    var itemType: String?
    var count: Int = 0
    //let db = Firestore.firestore()
    private var documents: [DocumentSnapshot] = []
    private var listener : ListenerRegistration!
    let picker = UIPickerView()
    
    fileprivate func baseQuery() -> Query {
        if itemType == "Pizza"{
            return Firestore.firestore().collection("specialtypizzas")
        }
        else{
            return Firestore.firestore().collection(itemType!.lowercased())
        }
    }
    fileprivate var query: Query? {
           didSet {
               if let listener = listener {
                   listener.remove()
               }
           }
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = itemType
        self.query = baseQuery()
        myTable.delegate = self
        myTable.dataSource = self
        self.listener =  query?.addSnapshotListener { (documents, error) in
                   guard let snapshot = documents else {
                       print("Error fetching documents results: \(error!)")
                       return
                   }
                   let results = snapshot.documents.map { (document) -> Menu in
                       if let thing = Menu(menudict: document.data()) {
                           return thing
                       } else {
                           fatalError("Unable to initialize type \(Menu.self) with dictionary \(document.data())")
                       }
                   }
                   self.menuItems = results
                   self.documents = snapshot.documents
                   self.myTable.reloadData()
               }
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           self.listener.remove()
    }
    
    
        
    static func fromStoryboard(_ storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)) -> ItemPageViewController {
      let controller = storyboard.instantiateViewController(withIdentifier: "itemPage") as! ItemPageViewController
      return controller
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath as IndexPath) as! ItemCell
        let item = menuItems[indexPath.row]
        cell.name.text = item.name
        cell.priceLabel.text = item.price
        cell.name.font = UIFont.init(name: "AmaticSC-Bold", size: 20.0)
        cell.priceLabel.font = UIFont.init(name: "Amatic SC", size: 20.0)
        cell.descLabel.text = item.desc
        cell.descLabel.font = UIFont.init(name: "AmaticSC-Bold", size: 15.0)
        let imageName = item.name.lowercased().replacingOccurrences(of: " ", with: "")
        cell.itemImage.image = UIImage(named: imageName)
        Helper.styleFilledButton(cell.addToCart)
        cell.tapped = { [unowned self] (selectedCell) -> Void in
            let path = tableView.indexPathForRow(at: cell.center)!
            Items.sharedInstance.array.append(self.menuItems[path.row])
        }
        return cell
    }
    
    
    
    @IBAction func addCartTapped(_ sender: Any) {
        Counter.sharedInstance.count += 1
        tabBarController?.tabBar.items?.last?.badgeValue = String(Counter.sharedInstance.count)
    }
    
    
    

}

class ItemCell: UITableViewCell{
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var itemImage: UIImageView!
    var tapped: ((ItemCell) -> Void)?
    
    
    
    @IBAction func addCartTapped(_ sender: Any) {
        tapped?(self)
    }
    
    
    
}
