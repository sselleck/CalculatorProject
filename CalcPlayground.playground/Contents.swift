//Created by the greatest ladies Alex Wise and Samantha Selleck
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
}

//a function named add with two parameters that are ints
func add(_ a: Double,_ b: Double) ->Double // -> Int is how you return a value within the func and the _(space) allows you to not have to write a:3 when calling the func.
{
    return a+b
}
//function to subtract two ints
func sub(_ a: Double,_ b: Double)->Double
{
    return a-b
}
//function to multiple two ints
func mult(_ a: Double,_ b: Double) ->Double
{
    return a*b
}
//function to divide two ints
func div(_ a: Double,_ b: Double) ->Double
{
    return a/b
}

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

func postfixEvaluate(equation: [String]) -> Double {
    var result = 0.0
    
    var calculator = Stack<Double>()
    var item: String
    
    for i in 0...equation.count-1{
        print(equation[i])
        item = equation[i]
        if item == "+" || item == "-" || item == "*" || item == "/"{
            let val2 = calculator.pop()!
            let val1 = calculator.pop()!
            result = doMath(val1, val2, Character(item))
            calculator.push(result)
        }
        else {
            calculator.push(Double(item)!)
        }
        
        
    }
    
    return result
}

var postFixExpr =  ["2.3", "1.5", "-2.6", "*", "+"]
var intStack:Stack<Double>

//initailize stack?

var answer = postfixEvaluate(equation: postFixExpr)

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
    print(numberStack.top()!)
    
    return numberStack.top()!
}

let infixExpr = ["3.2", "+", "2.34", "*", "2"]
infix(infixExpr)







