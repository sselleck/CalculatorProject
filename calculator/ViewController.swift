//
//  ViewController.swift
//  calculator
//
//  Created by Samantha Selleck and Alex Wise on 1/28/17.
//  Copyright © 2017 S. Selleck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var solutionLabel: UILabel! //variable for the solution output
    @IBOutlet var operators: UILabel!  //variable for all the operators
    @IBOutlet var numbers: UILabel!  //var's for the numbers
    @IBOutlet var leftP: UILabel! //var for the open par. (
    @IBOutlet var rightP: UILabel! //var for the close par. )
    @IBOutlet var clear: UILabel! //var for the clear button
    
    
    @IBAction func displayOutput(_ sender: UIButton) {
        
        
    
    }
    
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

    
    
   
}

