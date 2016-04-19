//
//  pending_state.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class PendingState: State {

  func getAssignedMechanic(context: Context) -> Mechanic? {
    print("a pending quote doesn't have a mechanic assigned yet")
    return nil
  }

  func getMessageToCustomer(context: Context) -> String {
    return "Your quote is currently pending, we will get back to you with a ready quote soon"
  }

  func getPrice(context: Context) -> Double? {
    print("a pending quote doesn't have a price yet")
    return nil
  }

  func getReceipt(context: Context) -> Receipt? {
    print("a pending quote doesn't have a receipt yet")
    return nil
  }
}
