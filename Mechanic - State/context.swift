//
//  context.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class Context {
  private var state: State = SubmittedState()

  func getMessageToCustomer() -> String {
    return state.getMessageToCustomer(self)
  }

  func getPrice() -> Double? {
    return state.getPrice(self)
  }

  func getReceipt() -> Receipt? {
    return state.getReceipt(self)
  }

  func changeStateToReady(price: Double) {
    state = ReadyState(price: price)
  }

  func changeStateToPending() {
    state = PendingState()
  }

  func changeStateToBooked(price: Double, mechanic: Mechanic) {
    state = BookedState(price: price, mechanic: mechanic)
  }

  func changeStateToCompleted(price: Double, mechanic: Mechanic, receipt: Receipt) {
    state = CompletedState(price: price, mechanic: mechanic, receipt: receipt)
  }

}
