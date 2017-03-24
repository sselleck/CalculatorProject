//
//  ViewController.swift
//  This app was created to make a fully functioning calculator that will accept negative numbers, decimals, parathenesses, and all operators.

//  Created by Samantha Selleck and Alex Wise on 1/28/17.
//  Copyright © 2017 S. Selleck. All rights reserved.
//

import UIKit

struct Stack <Element>{
    var items = [Element]()
    
    //This will append the new item onto the stack
    mutating func push(_ newItem: Element){
        items.append(newItem)
    }
    
    //This will remove the top item from the stack
    mutating func pop() -> Element?{
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    //This will tells us what item is on the top of the stack
    func top() -> Element?{
        return items.last
    }
    
    //This will indicate if the stack is empty
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    //This function will remove all items from the stack
    mutating func clearStack(){
        while !items.isEmpty{
            items.removeLast()
        }
    }
}

class ViewController: UIViewController {
    
    @IBOutlet var solutionLabel: UILabel! //variable for the solution output
    @IBOutlet var clearButton: UIButton! //clear button outlet to change title 
    
    var numberStack = Stack<Double>() //Stack to hold numbers
    var operatorStack = Stack<Character>() //Stack to hold the operators
    var answer: Double = 0 //Variable to hold the solutions an expression
    var Num: Double = 0 //Variable to hold numbers input by user
    var display: String = "" //String to display numbers
    var i:Int = 0 //This will check to see if a ) was used and will then hit a test to work properly
    var erase: Bool = false //Boolean flag to indicate clear or all clear
    var a: Int = 1//variable for decimal tracking
    var count: Double = 10// variable used to decrement numbers beyond decimal
    var swap: Bool = false //keeps track of whether allclear button has switched to clear

    //This function will simply be called on to display the answer/solution
    func displayAnswer(_ solutionString: String){
        solutionLabel.text = solutionString
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    //function to add two double
    func add(_ a: Double,_ b: Double) ->Double // function to add two doubles
    {
        return a+b
    }
    //function to subtract two double
    func sub(_ a: Double,_ b: Double)->Double
    {
        return a-b
    }
    //function to multiple two double
    func mult(_ a: Double,_ b: Double) ->Double
    {
        return a*b
    }
    //function to divide two doubles
    func div(_ a: Double,_ b: Double) ->Double
    {
        return a/b
    }

    //Function that will calculate the expression
    func doMath(_ a: Double,_ b: Double,_ op:Character)->Double
    {
        var answer: Double = 0
        if op == "+" {
            answer = add(a,b)
        }
        else if op == "-"{
            answer = sub(a,b)
        }
        else if op == "x"{
            answer = mult(a,b)
        }
        else if op == "÷"{
            answer = div(a,b)
        }
        return answer;
    }

    //this func is finding the incoming precedence
    func iPrecedence(_ oper: Character) -> Int {
        var value: Int = 0
        
        if(oper == ")"){
            value = 4
        }
        if(oper == "x" || oper == "÷"){
            value = 3
        }
        if(oper == "+" || oper == "-"){
            value = 2
        }
        if(oper == "("){
            value = 1
        }
        return value
    }
    
    //func is finding the precendce of the upcoming character
    func sPrecedence(_ name: Character) -> Int {
        var value: Int = 0
    
        if(name == ")"){
            value = 4
        }
        if(name == "x" || name == "÷"){
            value = 3
        }
    
        if(name == "+" || name == "-"){
            value = 2
        }
        if(name == "("){
            value = 1
        }
    
        //if there is no character return 0
        return value
    }

    //This function will pop two numbers and one operator to perform calculations and return solution
    func evaluate (_ numStack: inout Stack<Double>, _ opStack: inout Stack<Character>) -> Double{
        var B: Double
        var A: Double
        var Answer: Double
        var C: Character
        
        B = numStack.pop()!
        A = numStack.pop()!
        C = opStack.pop()!
        
        Answer = doMath(A, B, C)
        
        return Answer
    }
    
    //This action function be called when the user hits a number button
    @IBAction func numbersHit (_ sender: UIButton){
        var ac: Bool = false
        let numClick = sender.titleLabel?.text
        var s: Double = 0
        
        s = Double(numClick!)!
        
        //This will handle decimals
        if a == 0 {
            Num = Num + (s / count) //Appends the decimal value
            count *= 10 //for each additional decimal place the value must be divided a factor of 10
        }
        
        //Otherwise, it will be append to the existing number in the ones place
        else {
            Num = (Num*10) + Double(numClick!)!
        }
        
        display = String(Num)
        
        //Tells function if it should switch the all clear button to clear
        if swap == false {
            ac = clear(clearButton)
        }
        
        //Displays the value
        displayAnswer(display)
        
        i = 0
    }
    
    //Function will indicate to numbersHit function if the decimals is required
    @IBAction func decimal(_ sender: UIButton){
        a = 0
    }
    
    //Function will deal with the action of any operator buttons being hit
    @IBAction func operatorsHit (_ sender: UIButton){
        //This will check incase if the last key hit was the ) and it will not push the current value of Num; otherwise it will be pushed
        if i != 1 {
            numberStack.push(Num)
            Num = 0
        }
        
        //reset a and count to take in a new number
        a = 1
        count = 10
        let opClick = sender.titleLabel?.text
        var ans: Double = 0
        
        //Checks to see if whatever is coming in is an operator
        if opClick == "+" || opClick == "-" || opClick == "x" || opClick == "÷" {
            //If the operator stack is empty or their is a precedence between the two it will push the element onto the stack
            if operatorStack.isEmpty() || sPrecedence(operatorStack.top()!) < iPrecedence(Character(opClick!)){
                operatorStack.push(Character(opClick!))
            }
                
                //This else statement will happen if there is a higher precedence between two operators such as a multiplcation, it will do the math and solve for the higher of the two
            else {
                ans = evaluate(&numberStack, &operatorStack)
                numberStack.push(ans)
                operatorStack.push(Character(opClick!))
            }
        }
        
        
        display = String(numberStack.top()!)
        displayAnswer(display)
        i = 0
    }
    
    //Function will deal with the left parathenesses
    @IBAction func leftParHit (_ sender: UIButton){
        //reset a and count to take in a new number
        a = 1
        count = 10

        let lParClick = sender.titleLabel?.text
        
        //Pushes the ( on to the operator stack
        operatorStack.push(Character(lParClick!))
        i = 0
    }
    
    //Function will deal with the right parathenesses
    @IBAction func rightParHit (_ sender: UIButton){
        //reset a and count to take in a new number
        a = 1
        count = 10
        numberStack.push(Num)
        Num = 0
        var ans: Double = 0
        
        //Do math within the parathenesses until the ( is found
        while operatorStack.top() != "(" {
            ans = evaluate(&numberStack, &operatorStack)
            numberStack.push(ans)
        }
        
        operatorStack.pop()!
        display = String(numberStack.top()!)
        displayAnswer(display)
    
        i = 1
    }
    
    //Action to change the sign of a number
    @IBAction func negativeSign (_ sender: UIButton){
        var negNum: Double
        //reset a and count to take in a new number
        a = 1
        count = 10
        
        //Pushes th value on to the number stack
        numberStack.push(Num)
        
        //Pops the last value in number stack and changes the sing and returns the new value
        negNum = numberStack.pop()!
        negNum *= -1
        Num = negNum
        //numberStack.push(negNum)
        print("Stack:", numberStack)
        display = String(negNum)
        
        displayAnswer(display)
        
        i = 0
    }
    
    //Action to clear the display and/or both stacks
    @IBAction func clearButton(_ sender: UIButton) {
        //reset a and count to take in a new number
        a = 1
        count = 10
        var ac: Bool = false
        display = "0"
        displayAnswer(display)
        //Indicates that both the display and the stack should clear
        if erase == false {
            //ac = clear(sender)
            Num = 0
            answer = 0
            numberStack.clearStack() //clears the num stakc
            operatorStack.clearStack() // clears the operator stack
            swap = true

            
            display = "0"
            displayAnswer(display) //Displays 0
        }
        
        //Indicates that only the display should be cleared
        else {
            ac = clear(sender)
            Num = 0
            answer = 0
            
            display = "0"
            displayAnswer(display)
            swap = false
            erase = false
            
            sender.setTitle("A/C", for: .normal) //Sets the title to A/C

        }
    }
    
    //This function will return the boolean type of whether the button is clear or all clear
    func clear(_ sender: UIButton) -> Bool {
        if erase == true {
            
        }
        else{
            erase = true
            sender.setTitle("C", for: .normal)
            swap = true
        }
        return erase
    }
    
    //Action function will display the solution when the equals button has been struck
    @IBAction func displayOutput(_ sender: UIButton){
        //reset a and count to take in a new number
        a = 1
        count = 10
        numberStack.push(Num) //pushes Num onto numberstack
        Num = 0
        var ans: Double = 0
        
        //This while statement will be hit to do the math on all the remaining numbers
        while !operatorStack.isEmpty() {
            ans = evaluate(&numberStack, &operatorStack)
            numberStack.push(ans)
        }
        
        display = String(numberStack.top()!)
        displayAnswer(display)
        
        i = 1
    }
}
