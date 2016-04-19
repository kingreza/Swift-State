//
//  booked_state.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class BookedState: State {

  var price: Double
  var mechanic: Mechanic

  init(price: Double, mechanic: Mechanic) {
    self.price = price
    self.mechanic = mechanic
  }

  func getAssignedMechanic(context: Context) -> Mechanic? {
    return mechanic
  }

  func getMessageToCustomer(context: Context) -> String {
    return "Your appointment has been booked with \(mechanic.name)."
  }

  func getPrice(context: Context) -> Double? {
    return price
  }

  func getReceipt(context: Context) -> Receipt? {
    print("a booked quote doesn't have a receipt")
    return nil
  }
}
