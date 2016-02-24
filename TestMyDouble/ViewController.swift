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
    @IBOutlet weak var connectedLabel: UILabel!
    @IBOutlet weak var turnDegreesTextbox: UITextField!
    @IBOutlet weak var poleHeightPercentTextbox: UITextField!
    @IBOutlet weak var kickstandStateTextbox: UITextField!
    @IBOutlet weak var batteryPercentTextbox: UITextField!
    @IBOutlet weak var batteryIsFullyChargedTextbox: UITextField!

    
    
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
    }
    
    func doubleDidDisconnect(theDouble: DRDouble){
        if connectedLabel != nil {
            connectedLabel.text = "Not Connected"
        }
        doubleIsConnected = false
    }
    
    func doubleStatusDidUpdate(theDouble: DRDouble){
        poleHeightPercentTextbox.text = String(MyDouble.poleHeightPercent)
        kickstandStateTextbox.text = String(MyDouble.kickstandState)
        batteryPercentTextbox.text = String(MyDouble.batteryPercent)
        batteryIsFullyChargedTextbox.text = String(MyDouble.batteryIsFullyCharged)
    }
    
    func doubleDriveShouldUpdate(theDouble: DRDouble){
        
    }
    
    func doubleTravelDataDidUpdate(theDouble: DRDouble){
        
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
}

