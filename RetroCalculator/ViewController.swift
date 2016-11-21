//
//  ViewController.swift
//  RetroCalculator
//
//  Created by Omar Wilson on 11/19/16.
//  Copyright © 2016 Omar Wilson. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    enum Operation: String {
        case Devide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightValStr = ""
    var runningNumber = ""
    var result = ""
    
    var btnSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        }   catch let err as NSError {
            print(err.debugDescription)
        }
        outputLbl.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



@IBAction func numberPressed(sender: UIButton) {
    playSound()
    
    runningNumber += "\(sender.tag)"
    outputLbl.text = runningNumber
}
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        btnSound.play()
}
    
    @IBAction func onDevidePressed(sender: AnyObject){
        processOperation(operation: .Devide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject){
        processOperation(operation: .Multiply)
    }
    @IBAction func onSubtractPressed(sender: AnyObject){
        processOperation(operation: .Subtract)
    }
    @IBAction func onAddPressed(sender: AnyObject){
        processOperation(operation: .Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject){
        processOperation(operation: currentOperation)
    }

    func processOperation(operation: Operation) {
        playSound()
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                }   else if currentOperation == Operation.Devide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                }   else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }   else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
            
        } else {
            //This is for the first time an operator is pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
    }
}

