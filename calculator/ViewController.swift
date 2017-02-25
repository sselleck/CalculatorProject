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
    var finalAnswer = Double()
    var currentOput: String = ""
    
    func displayAnswer(_ solutionValue: Double){
        solutionLabel.text = String(solutionValue)
    }

    //Action for the equal sign
    @IBAction func keyHit(_ sender: UIButton) {
        let clicked = sender.titleLabel?.text
        switch clicked!{
            case "0","1","2","3","4","5","6","7","8","9":
                currentOput.append(clicked!)
                displayAnswer(Double(currentOput)!)
        default:
            print("Uh oh. You done it now")
        }
    }
    
    @IBAction func clear(_ sender: UIButton) {
        numberStack.clearStack()
        operatorStack.clearStack()
    }
    
    var numberStack = Stack<Double>()
    var operatorStack = Stack<Character>()
    

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
    else if op == "*"{
        answer = mult(a,b)
    }
    else if op == "/"{
        answer = div(a,b)
    }
    return answer;
}

func precedence(_ oper: String, _ name: Character) -> Bool{
    var x: Int = 0
    var y: Int = 0
    if(name == "*" || name == "/"){
        x = 1
    }
    
    if(oper == "*" || oper == "/"){
        y = 1
    }
    
    if(x<=y){
        return true
    }
    else {
        return false
    }
}

func infix(_ expression: [String]) -> Double {
    var numberStack = Stack<Double>()
    var operatorStack = Stack<Character>()
    var element:String
    
    var B: Double
    var A: Double
    var Answer: Double
    var C: Character
    
    print(numberStack)
    print(expression)
    print(operatorStack)
    
    for i in 0...expression.count-1{
        element = expression[i]
        if element == "+" || element == "-" || element == "*" || element == "/"{
            if operatorStack.isEmpty() || precedence(element, operatorStack.top()!){
                operatorStack.push(Character(element))
            }
                
            else {
                B = numberStack.pop()!
                A = numberStack.pop()!
                C = operatorStack.pop()!
                
                Answer = doMath(A, B, C)
                numberStack.push(Answer)
                operatorStack.push(Character(element))
            }
        }
        else{
            numberStack.push(Double(element)!)
        }
    }
    while !operatorStack.isEmpty(){
        B = numberStack.pop()!
        A = numberStack.pop()!
        C = operatorStack.pop()!
        Answer = doMath(A, B, C)
        
        numberStack.push(Answer)
    }
    return numberStack.top()!
}
}
