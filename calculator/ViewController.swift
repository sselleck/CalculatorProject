//
//  ViewController.swift
//  calculator
//
//  Created by Samantha Selleck and Alex Wise on 1/28/17.
//  Copyright © 2017 S. Selleck. All rights reserved.
//

import UIKit

struct Stack <Element>{
    var items = [Element]()
    mutating func push(_ newItem: Element){
        items.append(newItem)
    }
    
    mutating func pop() -> Element?{
        guard !items.isEmpty else {
            return nil
        }
        return items.removeLast()
    }
    
    func top() -> Element?{
        return items.last
    }
    
    func isEmpty() -> Bool {
        return items.isEmpty
    }
    
    mutating func clearStack(){
        while !items.isEmpty{
            items.removeLast()
        }
    }
}
class ViewController: UIViewController {
    
    @IBOutlet var solutionLabel: UILabel! //variable for the solution output
    
    var numberStack = Stack<Double>()
    var operatorStack = Stack<Character>()
    var finalAnswer = Double()
    var answer: Double = 0
    var number: String = ""
    var Num: Double = 0
    var display: String = ""
    var i:Int = 0 //This will check to see if a ) was used and will then hit a test to work properly
    
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
    
    @IBAction func numbersHit (_ sender: UIButton){
        let numClick = sender.titleLabel?.text
        Num = (Num*10) + Double(numClick!)!
        display = String(Num)
        
        /*case ".":
         var count: Double = 10
         var i: Double = 0
         while clicked  == "6"{//!= "+" ||  clicked != "-" || clicked != "x" || clicked != "÷" || clicked != "(" || clicked != ")" || clicked != "±" {
         i += Double(clicked!)!/count
         currentOput.append(String(i))
         displayAnswer(Double(currentOput)!)
         count *= 10
         print("Dec", currentOput)
         }
         equation.append(clicked! + String(i))
         */
        displayAnswer(display)
        i = 0
    }
    
    @IBAction func operatorsHit (_ sender: UIButton){
        //This will check incase if the last key hit was the ) and it will not push the current value of Num; otherwise it will be pushed
        if i != 1 {
            numberStack.push(Num)
            Num = 0
        }
        print("Stack", numberStack)
        let opClick = sender.titleLabel?.text
        print("oper title", opClick!)
        var ans: Double = 0
        //Checks to see if whatever is coming in is an operator
        if opClick == "+" || opClick == "-" || opClick == "x" || opClick == "÷" {
            //If the operator stack is empty or their is a precedence between the two it will push the element onto the stack
            if operatorStack.isEmpty() || sPrecedence(operatorStack.top()!) < iPrecedence(Character(opClick!)){
                operatorStack.push(Character(opClick!))
                print("Operator", opClick!)
            }
                
                //This else statement will happen if there is a higher precedence between two operators such as a multiplcation, it will do the math and solve for the higher of the two
            else {
                print("hello")
                ans = evaluate(&numberStack, &operatorStack)
                numberStack.push(ans)
                operatorStack.push(Character(opClick!))
            }
        }
        print("HELLO", display)
        print("top", numberStack)
        display = String(numberStack.top()!)
        displayAnswer(display)
        i = 0
    }
    
    @IBAction func leftParHit (_ sender: UIButton){
        let lParClick = sender.titleLabel?.text
        operatorStack.push(Character(lParClick!))
        print("Left Par", lParClick!)
        i = 0
    }
    
    @IBAction func rightParHit (_ sender: UIButton){
        numberStack.push(Num)
        Num = 0
        var ans: Double = 0
        while operatorStack.top() != "(" {
            ans = evaluate(&numberStack, &operatorStack)
            numberStack.push(ans)
        }
        //print("ans", ans)
        operatorStack.pop()!
        display = String(numberStack.top()!)
        displayAnswer(display)
        print("display", numberStack)
        i = 1
    }
    
    @IBAction func negativeSign (_ sender: UIButton){
        numberStack.push(Num)
        var negNum: Double
        negNum = numberStack.pop()!
        negNum *= -1
        numberStack.push(negNum)
        display = String(negNum)
        displayAnswer(display)
        i = 0
    }
    
    @IBAction func clear(_ sender: UIButton) {
        Num = 0
        numberStack.clearStack()
        operatorStack.clearStack()
        answer = 0
        print(operatorStack, numberStack)
        display = "0"
        displayAnswer(display)
        i = 0
    }
    
    @IBAction func displayOutput(_ sender: UIButton){
        numberStack.push(Num)
        Num = 0
        var ans: Double = 0
        //This while statement will be hit to do the math on all the remaining numbers
        while !operatorStack.isEmpty() {
            print("Evaluate While loop")
            ans = evaluate(&numberStack, &operatorStack)
            numberStack.push(ans)
        }
        display = String(numberStack.top()!)
        displayAnswer(display)
        i = 0
    }
}
