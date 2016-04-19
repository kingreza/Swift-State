<h1>Design Patterns in Swift: State</h1>
This repository is part of a series. For the full list check out <a href="https://shirazian.wordpress.com/2016/04/11/design-patterns-in-swift/">Design Patterns in Swift</a>
<h3>The problem:</h3>
A quote goes through many phases before it becomes an appointment and is completed by a mechanic. Initially a customer request a quote, once processed we find out if we can automatically provide a quote for the customer. If our system doesn't have enough information, the quote becomes pending. At this state a member of our customer support team has to fill in the gap and finds out what's needed to provide a quote (a ready quote). Once a quote is ready a customer can use it to book an appointment (booked quote). Once an appointment is booked a mechanic is assigned to the quote. When the appointment is completed we generate a receipt and send it to the customer. 
We need a system that can provide us with an interface to get the price, customized message for the user regarding the quote's state, and the receipt.
<h3>The solution:</h3>

Link to the repo for the completed project: <a href="https://github.com/kingreza/Swift-Chain-Of-Responsibility"> Swift - Chain Of Responsibility </a>
