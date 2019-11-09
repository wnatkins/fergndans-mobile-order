//
//  CartViewController.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 10/21/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import UIKit
import Foundation
import SquareInAppPaymentsSDK

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SQIPCardEntryViewControllerDelegate {

    
    @IBOutlet weak var myTable: UITableView!
    var cartItems: [Menu] = []
    @IBOutlet weak var placeOrder: UIButton!
    var item: Menu!
    var item2: OrderLineItem!
    var fullfilment: OrderFulfillment!
    var fullfilmentDeets: [OrderFulfillment] = []
    var lineItems: [OrderLineItem] = []
    var newPayment: CreatePaymentRequest!
    var orderID: String!
    var total: Money!
    let encoder = JSONEncoder()
    let session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        Helper.styleFilledButton(placeOrder)
        
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
    
    
    
    @IBAction func placeOrderTapped(_ sender: Any) {
        item2 = OrderLineItem(quantity: "1", catalogObjectId: "CATALOGID")
        lineItems.append(item2)
        fullfilment = OrderFulfillment(uid: UUID().uuidString, type: "PICKUP", state: "PROPOSED", pickupDetails: OrderFulfillmentPickupDetails(recipient: OrderFulfillmentRecipient(customerId: "CUSTOMERID"), scheduleType: "ASAP", prepTimeDuration: "P1W3D"))
        fullfilmentDeets.append(fullfilment)
        let order = Order(locationId: "LOCATIONID", referenceId: UUID().uuidString, customerId: "CUSTOMERID", lineItems: lineItems, fulfillments: fullfilmentDeets)
        var orderRequest = CreateOrderRequest(order: order, idempotencyKey: UUID().uuidString)

        
        let url = URL(string: "https://connect.squareupsandbox.com/v2/locations/LOCATIONID/orders")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("ACCESS TOKEN PLACEHOLDER", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(orderRequest)
        request.httpBody = data
        
        let task = session.dataTask(with: request) { data, response, error in
            self.getData(data: data!)
        }
        task.resume()
        
        let cardController = makeCardEntryViewController()
        cardController.delegate = self
        self.navigationController?.pushViewController(cardController, animated: true)
        }
    
    func getData(data: Data){
        var test = try? JSONDecoder().decode(CreateOrderResponse.self, from: data)
        orderID = test?.order?._id
        total = test?.order?.totalMoney
        
   }
    func didChargeSuccessfully() {
        let alert = UIAlertController(title: "Your order was successful",
                                      message: "Go to your Square dashbord to see this order reflected in the sales tab.",
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }


    func makeCardEntryViewController() -> SQIPCardEntryViewController {
        // Customize the card payment form
        let theme = SQIPTheme()
        theme.errorColor = .red
        theme.tintColor = UIColor.orange
        theme.keyboardAppearance = .light
        theme.messageColor = UIColor.black
        theme.saveButtonTitle = "Pay"

        return SQIPCardEntryViewController(theme: theme)
    }


    func cardEntryViewController(_ cardEntryViewController: SQIPCardEntryViewController, didCompleteWith status: SQIPCardEntryCompletionStatus) {
        switch status{
        case .canceled:
            self.navigationController?.popToRootViewController(animated: true)
        
        case .success:
            self.didChargeSuccessfully()
        }
        self.navigationController?.popToRootViewController(animated: true)
    }

    func cardEntryViewController(_ cardEntryViewController: SQIPCardEntryViewController, didObtain cardDetails: SQIPCardDetails, completionHandler: @escaping (Error?) -> Void) {
        
        ChargeApi.processPayment(cardDetails.nonce) { (response, error) in
            if error == nil{
                completionHandler(nil)
                print(response as Any)
                return
            }
            else{
                completionHandler(error as! Error)
            }
        }
    }
}



    



class cartCell: UITableViewCell{
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
}
