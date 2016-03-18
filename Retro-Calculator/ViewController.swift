//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by adm-rbociek on 18/03/16.
//  Copyright © 2016 Home. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLbl: UILabel!
    
    enum Operation: String {
        case Add = "+"
        case Subtract = "-"
        case Multiply = "*"
        case Divide = "/"
        case Empty = "Empty"
    }
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    var currentOperation: Operation = .Empty
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
                btnSound.prepareToPlay()
            
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    @IBAction func clearPressed(sender: UIButton) {
        
        playSound()
        
        outputLbl.text = "0"
        
        leftValStr = ""
        rightValStr = ""
        currentOperation = .Empty
        
        result = ""
    }
    
    @IBAction func numberPressed(sender: UIButton!) {
        
        playSound()
        
        runningNumber += "\(sender.tag)"
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: UIButton) {
        playSound()
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: UIButton) {
        playSound()
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubtractPressed(sender: UIButton) {
        playSound()
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: UIButton) {
        playSound()
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: UIButton) {
        playSound()
        processOperation(currentOperation)
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation( op: Operation ) {
        
        btnSound.play()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                switch currentOperation {
                case .Add:
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                case .Subtract:
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                case .Multiply:
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                case .Divide:
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                case .Empty:
                    break
                }
                
                outputLbl.text = result
                leftValStr = result
                rightValStr = ""
                
                result = ""
            }
            
            currentOperation = op
            
            
        } else {
            leftValStr = runningNumber
            runningNumber = ""
            
            currentOperation = op
        }
    }
}

