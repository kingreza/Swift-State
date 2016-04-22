<h3>The Problem:</h3>

A quote goes through many phases before it is completed by a mechanic. Initially a customer request a quote, once received, our system attempts to automatically provide a quote for the customer. If our system doesn't have enough information, the quote becomes pending. At this state a member of our customer support team finds out what's needed to provide a ready quote. Once a quote is ready, the customer can use it to book an appointment. Once an appointment is booked a mechanic is assigned to the quote. We need to be able to retrieve this mechanic's information. When the appointment is completed we generate a receipt and send it to the customer.

We need a system that can provide us with an interface to get the price, get a customized message that's dependant on the quotes's state, and provide the receipt when the appointment is complete.

<h3>The solution:</h3>

We will define a context that will hold our quotes's current state. We will then define a class for every state in which our quote can be in and have our context be responsible for changing its state. Our context will also provide us with an interface for the common functionalities that we expect from our quote, regardless of the state it's in.

<!--more-->

Link to the repo for the completed project: <a href="https://github.com/kingreza/Swift-State">Swift - State</a>

Let's begin

From the description in the problem we can see that we need four specific functionality for our quote. 
<ol>
	<li>Get the price for the quote</li>
	<li>Get the message we want to show to the customer regarding the quote</li>
	<li>Get the assigned mechanic for the quote</li>
	<li>Get the receipt</li>
</ol>

It's obvious that not all these functionalities make sense if the quote is at some specific state. For example a pending quote will never have a receipt or a quote that has just been sent, will not have a mechanic assigned until it is approved by the customer.

Before going forward we should also understand what are the different states our quote can be in. We also want to know the basic flow from state to state. 

<a href="https://shirazian.files.wordpress.com/2016/04/suppliment.png"><img src="https://shirazian.files.wordpress.com/2016/04/suppliment.png" alt="suppliment" width="500" height="131" class="alignnone size-full wp-image-1018" /></a>

A quote begins when we receive a request from the customer. This is the beginning of its life cycle. The quote doesn't have a price, a mechanic or a receipt yet. We call this a submitted quote.

When a quote is submitted two things can happen. If our system can generate an automatic price for the quote then the quote becomes ready. However if our system doesn't have enough information or if the customer didn't provide something important, then the quote goes into a pending state. When a qoute is pending, someone from our customer support team needs to follow up on it and provide the needed information to turn it into a ready quote.

When a quote is ready, it has a price and is sent to the customer. If the customer decides to book an appointment based on the quote, they will pick a mechanic. At this point the quote has become an appointment. For the sake of consistency we will call this, a booked quote. 

When the mechanic completes the job, then the quote has become completed and can now generate a receipt.

Now that we have a clear understanding of the problem, what's needed and the different states a quote can be in, we can begin building our system. 

We begin by defining a protocol called State. This protocol enforces our state classes to supply the required functionality stated in the beginning. We need a way to get the price of the quote, we need the quote to give us a customized message to the customer regarding its status, we need to be able to get the assigned mechanic and have the quote provide a receipt when the work is completed.

````swift
protocol State {
  func getPrice(context: Context) -> Double?
  func getMessageToCustomer(context: Context) -> String
  func getAssignedMechanic(context: Context) -> Mechanic?
  func getReceipt(context: Context) -> Receipt?
}
````

Knowing our requirements, there isn't much in the protocol that stands out except the Context parameter that is passed to all our functions. 

What is context? Let's look at its code

````swift
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

  func getMechanic() -> Mechanic? {
    return state.getAssignedMechanic(self)
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
```` 

The context acts as an interface between the quotes's various states/functionalities and the outside world. In our example, the context also provides an interface for other classes to change our quotes's state. Here anyone can change a quotes's state if they can provide the parameters requested by the context. Depending on the system you are designing you can limit or extend this behaviour to fit your needs. 

Our Context, can gives us the message we want to send to the customer, it can provide us with the price, the assigned mechanic and the receipt when the job is completed. 

As we can see when a Context is generated, it comes with a local variable called state. This variable is initialized to be of SubmittedState type. The SubmittedState is one of five classes that are representative of the five different states our quote can be in. As we mentioned earlier, submitted is the initial state of a quote, it makes sense to have our Context start with its state set to the class that represents the submitted state. 

Let's look at the code behind our SubmittedState:

````swift
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
    print("a submitted quote doesn't have a price")
    return nil
  }

  func getReceipt(context: Context) -> Receipt? {
    print("a submitted quote doesn't have a receipt")
    return nil
  }
}

````

Naturally this class implemented the State protocol. Since no mechanic has been assigned to the quote yet, the SubmittedState returns nil when a mechanic is requested. We are also printing a message to the console so we know why we didn't get a Mechanic from our Context. The message sent to our customer "Your quote has been submitted and is being processed right now, please wait a few moments" is descriptive of the state the quote is in and lets the user know what will happen next. A submitted quote also has no price or receipt. 

Not a very exciting state for a quote to be in, but a good example that shows how our implemented class deals with the functions it needs to implement.

We need four more classes like this to cover all the states our quote can end up in. Here is the code for the rest of them:

````swift
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
````

These classes follow the same pattern. As defined earlier, if they can provide the price, mechanic or a receipt they do so. If not they will return nil. Adding a new states, is as simple as implementing the State class and providing the needed interactions within the Context object. Instead of multiple nested ifs or never ending case statements within a quote object, we can extend our quotes various states easier without the complications of hardcoding it.  

When our Context class is switching a quote's state, depending on the requirements set by that state, specific parameters are needed. For example, when a quote is being set to ready, we require a price, when it is being set to booked we need a mechanic and so on. Once the required parameters are provided, the new state is generated and the context's current state is assigned to the new state.

In our system, our context doesn't really do much internal computing or performs automatic state changes. It simply provides an interface for other classes to take on that responsibility. I personally thought this makes sense for this example, but you don't have to follow this pattern if it doesn't make sense for your specific circumstances. Your context object can be as involved as you want it to be.

Before we get to test this out, let's look at our Mechanic and Receipt classes.

````swift
class Mechanic {
  let name: String

  init(name: String) {
    self.name = name
  }
}

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

Nothing out of the ordinary here. Our Mechanic object is a simple struct with a name property. Our receipt object too is a simple struct with a delivered, total and customerName property. These values are each set by their respective initializer method.

Let's put it all together and see who it looks like. For our test case we are going to play out the following scenario:

John Lee recently heard of YourMechanic and decided to give it a try. He requests a quote but forgets to provide his car's trim information. Our system wasn't able to give him an instant ready quote so his submitted quote went into pending. Steve from our customer support team reviews the pending quote and fills out the car's trim information. The ready quote now has a price of $66.25. John Lee reviews the quote and decides to book Joe Murphy, one of our best mechanics to perform the needed services. When Joe Murphy completes the job a receipt is attached to the quote and the customer is informed of the another service completed by YourMechanic.

As you can see there are a lot of moving parts here that is not related to our quote and its status. Again the idea here is to build a simple solution, representative of the State design pattern so we are going to simulate what's not closely related to the patterns. 

Here is our main setup with the scenario coded out:

````swift

var context = Context()

print(context.getMessageToCustomer())

context.changeStateToPending()

print(context.getMessageToCustomer())

var price = 66.25
context.changeStateToReady(price)

print(context.getMessageToCustomer())

print(context.getPrice()!)

var attemptedReceipt = context.getReceipt()

var joe = Mechanic(name: "Joe Murphy")
context.changeStateToBooked(price, mechanic: joe)

print(context.getMessageToCustomer())

var receipt = Receipt(delivered: true, total: price, customerName: "John Lee")
context.changeStateToCompleted(price, mechanic: joe, receipt: receipt)

print(context.getMessageToCustomer())

````

Let's go through it step by step

````swift
var context = Context()

print(context.getMessageToCustomer())

````

We begin when John Lee submits a quote. We start by creating our Context. Our context's initial state is set to SubmittedQuote automatically. Then we call our getMessageToCustomer function on our context which returns the message we would send to the customer when a quote is first submitted. 

Since John Lee did not provide his car's trim information, his quote will have to be set to pending:

````swift
context.changeStateToPending()
print(context.getMessageToCustomer())
````  

We set the quotes's state to pending through our context. Since no new information needs to be passed, this is done by simply calling the changeStateToPending function, with no parameters. 

We then print the message we expect to send to the customer.

````swift
var price = 66.25
context.changeStateToReady(price)

print(context.getMessageToCustomer())
````  

This is where Steve from customer support reviews our pending quote. He sets the quote to ready and assigns the price. Again, we print the message we expect to send to the customer.

````swift
print(context.getPrice()!)
var attemptedReceipt = context.getReceipt()

var joe = Mechanic(name: "Joe Murphy")
context.changeStateToBooked(price, mechanic: joe)

print(context.getMessageToCustomer())
````

Our quote is now ready and has a price. However it does not have a receipt yet. To do a quick test we will try to print the price and get a receipt. We will see the result of these two calls in a bit. At this point John Lee decides to pick Joe Murphy as his mechanic. We change the state to booked and pass Joe as the assigned mechanic. 

````swift
var receipt = Receipt(delivered: true, total: price, customerName: "John Lee")
context.changeStateToCompleted(price, mechanic: joe, receipt: receipt)

print(context.getMessageToCustomer())
````

When the job is completed, we generate a receipt and set the quote to completed. 

Let's take a look at our output

````swift
Your quote has been submitted and is being processed right now, please wait a few moments
Your quote is currently pending, we will get back to you with a ready quote soon
Your quote is ready. The total for the services you have requested is: $66.25
66.25
a ready quote doesn't have a receipt
Your appointment has been booked with Joe Murphy.
Thank you for using YourMechanic.
Program ended with exit code: 0
````

As you can see, our quote goes through all its states successfully. It is able to provide what is requested if that is a viable option at that state and provides a message when it is not. The States themselves are not aware of each other and the flow from one state to another is confined in one place. Adding or removing a state is also fairly straightforward since none of the states or context code related to our quote object is actually in the quote object (Which if you noticed is absent from this solution all together)

Congratulations you have just implemented the State Design Pattern to solve a nontrivial problem

The repo for the complete project can be found here:<a href="https://github.com/kingreza/Swift-State"> Swift - State </a> Download a copy of it and play around with it. See if you can find ways to improve it. Here are some ideas to consider:

<ul>
	<li>Integrate a quote object the the context object</li>
        <li>In our example we pass the context to the functions defined within a state but never used the context itself, what would be a good example of when we would use the context?</li>
	<li>If a customer would like to make a warranty claim they can do so after a service is completed, provided the supply a receipt. How would you include this state with its requirement in our current model.</li>
        <li>Instead of calling changeStateToX have the context do so automatically when a price is set, a mechanic is assigned or a receipt is generated</li>
</ul>



