//
//  main.swift
//  Mechanic - State
//
//  Created by Reza Shirazian on 2016-04-19.
//  Copyright © 2016 Reza Shirazian. All rights reserved.
//

import Foundation


// John Lee request a quote. A context is created.
var context = Context()

// Inform the customer
print(context.getMessageToCustomer())

// Quote goes to pending because we are missing some information about the quote
context.changeStateToPending()

// Inform the customer
print(context.getMessageToCustomer())

// Our talented customer service team figures out what's missing and turns the quote into ready.
var price = 66.25
context.changeStateToReady(price)

// Inform the customer
print(context.getMessageToCustomer())

// Log the price
print(context.getPrice()!)

// Try to get the receipt for the quote
var attemptedReceipt = context.getReceipt()

// The customer is amazed by our low prices and decides to
// book an appointment with our top mechanic Joe Murphy
var joe = Mechanic(name: "Joe Murphy")
context.changeStateToBooked(price, mechanic: joe)

// Inform the customer
print(context.getMessageToCustomer())

// Another successfull appointment. We create a receipt and give it to the customer
var receipt = Receipt(delivered: true, total: price, customerName: "John Lee")
context.changeStateToCompleted(price, mechanic: joe, receipt: receipt)

// Inform the customer
print(context.getMessageToCustomer())
