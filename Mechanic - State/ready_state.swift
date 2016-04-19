//
//  ready.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class ReadyState: State {
  var price: Double

  init(price: Double) {
    self.price = price
  }

  func getAssignedMechanic(context: Context) -> Mechanic? {
    print("a ready quote doesn't have a mechanic assigned yet")
    return nil
  }

  func getMessageToCustomer(context: Context) -> String {
    return String.localizedStringWithFormat("Your quote is ready. The total for the services " +
      "you have requested is: $%.2f", self.price)
  }

  func getPrice(context: Context) -> Double? {
    return price
  }

  func getReceipt(context: Context) -> Receipt? {
    print("a ready quote doesn't have a receipt")
    return nil
  }
}
