//
//  completed_state.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class CompletedState: State {

  var price: Double
  var mechanic: Mechanic
  var receipt: Receipt

  init(price: Double, mechanic: Mechanic, receipt: Receipt) {
    self.price = price
    self.mechanic = mechanic
    self.receipt = receipt
  }

  func getAssignedMechanic(context: Context) -> Mechanic? {
    return mechanic
  }
  func getMessageToCustomer(context: Context) -> String {
    return "Thank you for using YourMechanic."
  }
  func getPrice(context: Context) -> Double? {
    return price
  }
  func getReceipt(context: Context) -> Receipt? {
    return receipt
  }
}
