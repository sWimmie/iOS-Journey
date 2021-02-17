//
//  ViewController.swift
//  Super Mario Calculator
//
//  Created by Wim van Deursen on 15/02/2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var commaBtn: UIButton!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var numBtnSound: AVAudioPlayer!
    var clearBtnSound: AVAudioPlayer!
    var runningNumber = ""
    var currentOperation = Operation.Empty
    var leftValueString = ""
    var rightValueString = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numPath = Bundle.main.path(forResource: "mb_jump", ofType: "wav")
        let numSoundURL = URL(fileURLWithPath: numPath!)
        
        do{
            try numBtnSound = AVAudioPlayer(contentsOf: numSoundURL)
            numBtnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        let clearPath = Bundle.main.path(forResource: "mb_coin", ofType: "wav")
        let clearSoundURL = URL(fileURLWithPath: clearPath!)
        
        do {
            try clearBtnSound = AVAudioPlayer(contentsOf: clearSoundURL)
            clearBtnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func numberPressed(sender: UIButton) {
        playNumberButtonSound()
        runningNumber += "\(sender.tag)"
        outputLabel.text = runningNumber
    }
    
    @IBAction func commaPressed(sender: UIButton) {
        runningNumber += "."
        outputLabel.text = runningNumber
        commaBtn.isUserInteractionEnabled = false
    }
    
    @IBAction func dividePressed(sender: UIButton) {
        processOperation(operation: .Divide)
    }
    @IBAction func multiplyPressed(sender: UIButton) {
        processOperation(operation: .Multiply)
    }
    @IBAction func subtractPressed(sender: UIButton) {
        processOperation(operation: .Subtract)
    }
    @IBAction func addPressed(sender: UIButton) {
        processOperation(operation: .Add)
    }
    
    @IBAction func equalPressed(sender: UIButton) {
        if runningNumber == "" {
            
            if currentOperation == Operation.Multiply {
                result = "\(Double(leftValueString)! * (Double(rightValueString)!))"
            } else if currentOperation == Operation.Divide {
                result = "\(Double(leftValueString)! / (Double(rightValueString)!))"
            } else if currentOperation == Operation.Subtract {
                result = "\(Double(leftValueString)! - (Double(rightValueString)!))"
            } else if currentOperation == Operation.Add {
                result = "\(Double(leftValueString)! + (Double(rightValueString)!))"
            }

            leftValueString = result
            outputLabel.text = result
            result = ""

        } else {
             processOperation(operation: currentOperation)
        }
        
    }
    
    @IBAction func clearPressed(sender: UIButton) {
        if clearBtnSound.isPlaying {
            clearBtnSound.stop()
        }
        
        clearBtnSound.play()
        
        
        if runningNumber != "" {
            runningNumber = ""
            outputLabel.text = "0"
            commaBtn.isUserInteractionEnabled = true
        } else {
            leftValueString = ""
            rightValueString = ""
            result = ""
            outputLabel.text = "0"
            runningNumber = ""
            currentOperation = Operation.Empty
            commaBtn.isUserInteractionEnabled = true
            
        }
    }
    
    
    func playNumberButtonSound() {
        if numBtnSound.isPlaying {
            numBtnSound.stop()
        }
        numBtnSound.play()
    }
    
    func processOperation(operation: Operation) {
        if currentOperation != Operation.Empty {
            if runningNumber != "" {
                if leftValueString != "" {
                    rightValueString = runningNumber
                    runningNumber  = ""
                    commaBtn.isUserInteractionEnabled = true
                    
                    if currentOperation == Operation.Multiply {
                        result = "\(Double(leftValueString)! * (Double(rightValueString)!))"
                    } else if currentOperation == Operation.Divide {
                        result = "\(Double(leftValueString)! / (Double(rightValueString)!))"
                    } else if currentOperation == Operation.Subtract {
                        result = "\(Double(leftValueString)! - (Double(rightValueString)!))"
                    } else if currentOperation == Operation.Add {
                        result = "\(Double(leftValueString)! + (Double(rightValueString)!))"
                    }
                    
                    leftValueString = result
                    outputLabel.text = result
                    result = ""
                } else {
                    leftValueString = runningNumber
                    runningNumber = ""
                    commaBtn.isUserInteractionEnabled = true
                }
            }
            currentOperation = operation
        } else {
            leftValueString = runningNumber
            runningNumber = ""
            currentOperation = operation
            commaBtn.isUserInteractionEnabled  = true
        }
    }

}

