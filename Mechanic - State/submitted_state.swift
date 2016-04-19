//
//  submitted_state.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class SubmittedState: State {

  func getAssignedMechanic(context: Context) -> Mechanic? {
    print("a submitted quote doesn't have a mechanic assigned yet")
    return nil
  }

  func getMessageToCustomer(context: Context) -> String {
    return "Your quote has been submitted and is " +
    "being processed right now, please wait a few moments"
  }

  func getPrice(context: Context) -> Double? {
    print("a submitted quote doesn't have a receipt")
    return nil
  }

  func getReceipt(context: Context) -> Receipt? {
    print("a submitted quote doesn't have a receipt")
    return nil
  }
}
