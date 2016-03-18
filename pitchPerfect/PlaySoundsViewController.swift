//
//  PlaySoundsView.swift
//  Pitch Perfect
//
//  Created by Ra Ra Ra on 3/11/15.
//  Copyright (c) 2015 Ra Ra Ra. All rights reserved.
//

import UIKit
import AVFoundation

protocol PlaySoundsDelegate {
    func playSoundsGetRecordingURL() -> NSURL
}
class PlaySoundsViewController: UIViewController {
    
    var delegate: PlaySoundsDelegate!
    var audioPlayer: AVAudioPlayer!
    var audioFile: AVAudioFile!
    var audioEngine = AVAudioEngine()
    
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var darthButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var slowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupPlayer()
        audioFile = AVAudioFile(forReading: delegate.playSoundsGetRecordingURL(), error: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        stopAll()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        audioPlayer.stop()
    }
    
    private func setupPlayer() {
        
        var error: NSError?
        let url = delegate.playSoundsGetRecordingURL()
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        audioPlayer.volume = 1
        audioPlayer.enableRate = true
        audioPlayer.prepareToPlay()
    }
    
    @IBAction func didPressStop(sender: UIButton) {
        stopAll()
    }
    
    private func stopAll() {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        if audioEngine.running {
            audioEngine.stop()
        }
        audioEngine.reset()
        
    }
    
    @IBAction func didPressChipmunk(sender: UIButton) {
        
        stopAll()

        playAtPitch(1000)
    }
    
    /**
    Plays the audio file at a certain pitch
    
    :param: pitch The pitch to play. Should be between -2400 and 2400
    */
    private func playAtPitch(pitch: Float) {
        
        let playerNode = AVAudioPlayerNode()
        audioEngine.attachNode(playerNode)
        
        let timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(playerNode, to: timePitch, format: audioFile.processingFormat)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format: audioFile.processingFormat)
        
        playerNode.scheduleFile(audioFile, atTime: nil) {}
        var error = NSErrorPointer()
        audioEngine.startAndReturnError(error)
        playerNode.play()
    }
    
    @IBAction func didPressDarth(sender: UIButton) {
        stopAll()
        playAtPitch(-1000)
    }
    
    @IBAction func didPressFast(sender: UIButton) {
        stopAll()
        audioPlayer.rate = 2.0
        play()
    }
    
    @IBAction func didPressSlow(sender: UIButton) {
        stopAll()
        audioPlayer.rate = 0.5
        play()
    }
    
    private func play() {
        audioPlayer.play()
    }
}
