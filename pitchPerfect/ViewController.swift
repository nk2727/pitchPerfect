//
//  ViewController.swift
//  pitchPerfect
//
//  Created by Nicole on 3/17/16.
//  Copyright © 2016 Nicole. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(sender: AnyObject) {
        
        recordingLabel.text="Recording in progress"
        
        stopRecordingButton.enabled = true
        recordButton.enabled=false
    }

    @IBAction func stopRecording(sender: AnyObject) {
        recordingLabel.text="Tap to record"
        
        stopRecordingButton.enabled = false
        recordButton.enabled=true

            }
    override func viewWillAppear(animated: Bool) {
        print("viewWillAppear called")
    }
}

