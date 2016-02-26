//
//  ViewController.swift
//  TestMyDouble
//
//  Created by Karl Damkjær Hansen on 24/02/16.
//  Copyright © 2016 Karl Damkjær Hansen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DRDoubleDelegate {
    
    // MARK: Properties
    
    var MyDouble = DRDouble()
    var doubleIsConnected = false
    var driveSetpointActive = false
    var variableDriveActive = false
    var counter: Int = 0
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var turnDegreesTextbox: UITextField!
    @IBOutlet weak var poleHeightPercentTextbox: UITextField!
    @IBOutlet weak var kickstandStateTextbox: UITextField!
    @IBOutlet weak var batteryPercentTextbox: UITextField!
    @IBOutlet weak var batteryIsFullyChargedTextbox: UITextField!
    @IBOutlet weak var firmwareVersionTextbox: UITextField!
    @IBOutlet weak var leftEncoderDeltaInchesTextbox: UITextField!
    @IBOutlet weak var rightEncoderDeltaInchesTextbox: UITextField!
    @IBOutlet weak var xDeltaInchesTextbox: UITextField!
    @IBOutlet weak var yDeltaInchesTextbox: UITextField!
    @IBOutlet weak var headingDeltaRadiansTextbox: UITextField!
    @IBOutlet weak var serialTextbox: UITextField!
    @IBOutlet weak var driveSlider: UISlider!
    @IBOutlet weak var variableDriveSlider: UISlider!

    
    
    // MARK: Initializer
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.MyDouble.delegate = self
    }
    
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if doubleIsConnected {
            connectedLabel.text = "Connected"
        } else {
            connectedLabel.text = "Not Connected"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: DRDoubleDelegate
    
    func doubleDidConnect(theDouble: DRDouble){
        // This function may be called before the view is set up.
        // In that case we cannot set the label.
        if connectedLabel != nil {
            connectedLabel.text = "Connected"
        }
        doubleIsConnected = true
        print("\(counter++) Double did connect")
    }
    
    func doubleDidDisconnect(theDouble: DRDouble){
        if connectedLabel != nil {
            connectedLabel.text = "Not Connected"
        }
        doubleIsConnected = false
        print("\(counter++) Double did disconnect")
    }
    
    func doubleStatusDidUpdate(theDouble: DRDouble){
        poleHeightPercentTextbox.text = String(MyDouble.poleHeightPercent)
        kickstandStateTextbox.text = String(MyDouble.kickstandState)
        batteryPercentTextbox.text = String(MyDouble.batteryPercent)
        batteryIsFullyChargedTextbox.text = String(MyDouble.batteryIsFullyCharged)
        firmwareVersionTextbox.text = MyDouble.firmwareVersion
        leftEncoderDeltaInchesTextbox.text = String(MyDouble.leftEncoderDeltaInches)
        rightEncoderDeltaInchesTextbox.text = String(MyDouble.rightEncoderDeltaInches)
        xDeltaInchesTextbox.text = String(MyDouble.xDeltaInches)
        yDeltaInchesTextbox.text = String(MyDouble.yDeltaInches)
        headingDeltaRadiansTextbox.text = String(MyDouble.headingDeltaRadians)
        serialTextbox.text = MyDouble.serial
        
        print("\(counter++) Status did update")
    }
    
    func doubleDriveShouldUpdate(theDouble: DRDouble){
        if driveSetpointActive {
            if driveSlider.value > 0 {
                MyDouble.drive(.Forward, turn: 0.0)
            } else if driveSlider.value < 0 {
                MyDouble.drive(.Backward, turn: 0.0)
            } else {
                MyDouble.drive(.Stop, turn: 0.0)
            }
        } else if variableDriveActive {
            MyDouble.variableDrive(variableDriveSlider.value, turn: 0.0)
        } else {
            MyDouble.drive(.Stop, turn: 0.0)
        }
    }
    
    func doubleTravelDataDidUpdate(theDouble: DRDouble){
        leftEncoderDeltaInchesTextbox.text = String(MyDouble.leftEncoderDeltaInches)
        rightEncoderDeltaInchesTextbox.text = String(MyDouble.rightEncoderDeltaInches)
        xDeltaInchesTextbox.text = String(MyDouble.xDeltaInches)
        yDeltaInchesTextbox.text = String(MyDouble.yDeltaInches)
        headingDeltaRadiansTextbox.text = String(MyDouble.headingDeltaRadians)
        print("\(counter++) Travel data did update")
    }
    
    // MARK: Button Actions

    @IBAction func buttonPoleUpClick(sender: UIButton) {
        MyDouble.poleUp()
    }
    
    @IBAction func buttonPoleDownClick(sender: UIButton) {
        MyDouble.poleDown()
    }
    
    @IBAction func buttonStopPoleClick(sender: UIButton) {
        MyDouble.poleStop()
    }

    @IBAction func buttonDeployKickstandClick(sender: UIButton) {
        MyDouble.deployKickstands()
    }
    
    @IBAction func buttonRetractKickstandClick(sender: UIButton) {
        MyDouble.retractKickstands()
    }
    
    @IBAction func buttonTurnByDegreesClick(sender: UIButton) {
        if let text = turnDegreesTextbox.text {
            MyDouble.turnByDegrees((text as NSString).floatValue)
        }
    }
    
    @IBAction func buttonStartTravelDataClick(sender: UIButton) {
        MyDouble.startTravelData()
        print("\(counter++) Called start travel data")
    }
    
    @IBAction func buttonStopTravelDataClick(sender: UIButton) {
        MyDouble.stopTravelData()
        print("\(counter++) Called stop travel data")
    }
    
    @IBAction func buttonRequestStatusUpdateClick(sender: UIButton) {
        MyDouble.requestStatusUpdate()
    }
    
    @IBAction func sliderDriveTouchDown(sender: UISlider) {
        driveSetpointActive = true
    }
    
    @IBAction func sliderDriveTouchUpInside(sender: UISlider) {
        driveSetpointActive = false
        MyDouble.drive(.Stop, turn: 0.0)
    }
    
    @IBAction func sliderDriveTouchUpOutside(sender: UISlider) {
        driveSetpointActive = false
        MyDouble.drive(.Stop, turn: 0.0)
    }
    
    @IBAction func sliderVariableDriveTouchDown(sender: UISlider) {
        variableDriveActive = true
    }
    
    @IBAction func sliderVariableDriveTouchUpInside(sender: UISlider) {
        variableDriveActive = false
        MyDouble.drive(.Stop, turn: 0.0)
    }
    
    @IBAction func sliderVariableDriveTouchUpOutside(sender: UISlider) {
        variableDriveActive = false
        MyDouble.drive(.Stop, turn: 0.0)
    }
    
}

