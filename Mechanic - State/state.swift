//
//  state.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

protocol State {
  func getPrice(context: Context) -> Double?
  func getMessageToCustomer(context: Context) -> String
  func getAssignedMechanic(context: Context) -> Mechanic?
  func getReceipt(context: Context) -> Receipt?
}
