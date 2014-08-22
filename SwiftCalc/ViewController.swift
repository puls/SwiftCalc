//
//  ViewController.swift
//  SwiftCalc
//
//  Created by Jim Puls on 7/7/14.
//  Copyright (c) 2014 Jim Puls. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var storedValue = 0.0
    var displayedValue : Double {
    get {
        return (displayedString as NSString).doubleValue
    }
    set {
        displayedString = (newValue as NSNumber).stringValue
    }
    }
    
    var displayedString : String = "0" {
    didSet {
        if isSuspendingUpdates {
            return
        }
        
        while (displayedString.hasPrefix("0") && displayedValue != 0.0) {
            displayedString = (displayedString as NSString).substringFromIndex(1)
        }
        
        if outputLabel {
            outputLabel!.text = displayedString
        }
    }
    }
    
    typealias Operator = (Double, Double) -> Double
    var currentOperation : Operator?
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for aView in view.subviews as [UIView] {
            if aView is UIButton {
                aView.layer.borderWidth = 0.5
            }
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    var isSuspendingUpdates = false
    func suspendingUpdates(block : () -> ()) {
        isSuspendingUpdates = true
        block()
        isSuspendingUpdates = false
    }
    
    func chooseOperation(operation : Operator) {
        currentOperation = operation
        storedValue = displayedValue
        suspendingUpdates {
            self.displayedValue = 0.0
        }
    }
    
    @IBOutlet var outputLabel: UILabel?

    @IBAction func zero(sender: UIButton) {
        displayedString += "0"
    }

    @IBAction func one(sender: UIButton) {
        displayedString += "1"
    }
    
    @IBAction func two(sender: UIButton) {
        displayedString += "2"
    }

    @IBAction func three(sender: UIButton) {
        displayedString += "3"
    }
    
    @IBAction func four(sender: UIButton) {
        displayedString += "4"
    }
    
    @IBAction func five(sender: UIButton) {
        displayedString += "5"
    }
    
    @IBAction func six(sender: UIButton) {
        displayedString += "6"
    }
    
    @IBAction func seven(sender: UIButton) {
        displayedString += "7"
    }
    
    @IBAction func eight(sender: UIButton) {
        displayedString += "8"
    }
    
    @IBAction func nine(sender: UIButton) {
        displayedString += "9"
    }
    
    @IBAction func decimal(sender: UIButton) {
        displayedString += "."
    }

    @IBAction func equals(sender: UIButton) {
        if let op = currentOperation {
            displayedValue = op(storedValue, displayedValue)
        }
        currentOperation = nil
    }
    
    @IBAction func plus(sender: UIButton) {
        chooseOperation(+)
    }
    
    @IBAction func minus(sender: UIButton) {
        chooseOperation(-)
    }
    
    @IBAction func multiply(sender: UIButton) {
        chooseOperation(*)
    }
    
    @IBAction func divide(sender: UIButton) {
        chooseOperation(/)
    }
    
    @IBAction func percent(sender: UIButton) {
        displayedValue /= 100.0
    }
    
    @IBAction func negate(sender: UIButton) {
        displayedValue *= -1
    }
    
    @IBAction func clear(sender: UIButton) {
        storedValue = 0.0
        displayedValue = 0.0
        currentOperation = nil
    }
}

