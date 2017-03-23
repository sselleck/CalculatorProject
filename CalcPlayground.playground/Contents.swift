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

//this func is finding the incoming precedence
func iPrecedence(_ oper: String) -> Int {
    var value: Int = 0
    
    if(oper == ")"){
        value = 4
    }
    if(oper == "*" || oper == "/"){
        value = 3
    }
    if(oper == "+" || oper == "-"){
        value = 2
    }
    if(oper == "("){
        value = 6
    }
    return value
}

//func is finding the precendce of the upcoming character
func sPrecedence(_ name: Character) -> Int {
    var value: Int = 0
    
    if(name == ")"){
        value = 4
    }
    if(name == "*" || name == "/"){
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

func infix(_ expression: [String]) -> Double {
    var numberStack = Stack<Double>()
    var operatorStack = Stack<Character>()
    var element:String

    var ans: Double = 0
    
    print(numberStack)
    print(expression)
    print(operatorStack)
    
    //For loop with continue to loop through all of the information in the stack
    for i in 0...expression.count-1{
        element = expression[i]
        if element == "(" {
            operatorStack.push(Character(element))
            print("Hello", element)
            //element = ""
        } else
        
        //print(expression[i])
        //Checks to see if whatever is coming in is an operator
        if element == "+" || element == "-" || element == "*" || element == "/" {
            //If the operator stack is empty or their is a precedence between the two it will push the element onto the stack
            if operatorStack.isEmpty() || sPrecedence(operatorStack.top()!) < iPrecedence(element){
                operatorStack.push(Character(element))
                print("Hello", element)
            }
            
            //This else statement will happen if there is a higher precedence between two operators such as a multiplcation, it will do the math and solve for the higher of the two
            else {
                ans = evaluate(&numberStack, &operatorStack)
                numberStack.push(ans)
                operatorStack.push(Character(element))
            }
        } else
        //print("Hello again!")
        //This if statement will check and deal with any operations within the parenthesis and then discard them.
        if element == ")" {
            while operatorStack.top() != "(" {
                ans = evaluate(&numberStack, &operatorStack)
                numberStack.push(ans)
            }
            operatorStack.pop()
        }
        //If it is a number it will just be pushed onto the number stack
        else{
            numberStack.push(Double(element)!)
        }
    }
    //This while statement will be hit to do the math on all the remaining numbers
    while !operatorStack.isEmpty(){
        ans = evaluate(&numberStack, &operatorStack)
        numberStack.push(ans)
    }
    print(numberStack.top()!)
    
    return numberStack.top()!
}

let infixExpr = ["(","6", "+", "2", ")", "-", "0.5"]
infix(infixExpr)
