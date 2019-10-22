//
//  Users.swift
//  Fergndans
//
//  Created by Whitney Atkinson on 9/27/19.
//  Copyright © 2019 Whitney Atkinson. All rights reserved.
//

import Foundation

struct Users {
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
        
      

      var userdict: [String: Any] {
        return [
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "phoneNumber": phoneNumber,]
      }
}

class Items {
    static let sharedInstance = Items()
    var array = [Menu]()
}

class Counter {
    static let sharedInstance = Counter()
    var count: Int = 0
}

struct Menu{
    var name: String
    var price: String
    var desc: String
    
    var menudict: [String: Any]{
        return [
            "name": name,
            "price": price,
            "desc": desc,]
    }
}

extension Menu{
    init?(menudict: [String : Any]) {
        guard   let name = menudict["name"] as? String,
            let price = menudict["price"] as? String,
            let desc = menudict["desc"] as? String
            else { return nil }
         
        self.init(name: name, price: price, desc: desc)
    }
}
extension Users{
    init?(userdict: [String : Any]) {
        guard   let firstName = userdict["firstName"] as? String,
            let lastName = userdict["lastName"] as? String,
            let email = userdict["email"] as? String,
            let phoneNumber = userdict["phoneNumber"] as? String
            else { return nil }
         
        self.init(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
    }
}
