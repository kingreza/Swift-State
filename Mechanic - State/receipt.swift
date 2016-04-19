//
//  receipt.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation

class Receipt {
  var delivered: Bool
  var total: Double
  var customerName: String

  init(delivered: Bool, total: Double, customerName: String) {
    self.delivered = delivered
    self.total = total
    self.customerName = customerName
  }
}
