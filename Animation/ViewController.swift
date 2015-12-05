//
//  ViewController.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var timer = NSTimer()
    var frameCount = 0
    var c = Canvas(width: 480, height: 270)
    
    @IBOutlet var canvasView: NSImageCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        timer = NSTimer.scheduledTimerWithTimeInterval(0.016, target: self, selector: Selector("draw"), userInfo: nil, repeats: true)
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func draw() {
        
        // Keep track of how many frames drawn
        frameCount++
        
        // Draw a rectangle with no fill
        c.drawShapesWithBorders = false
        c.fillColor = Color(hue: Float(frameCount), saturation: 80, brightness: 90, alpha: 100)
        c.drawEllipse(centreX: frameCount, centreY: 135, width: 25, height: 25)
        
        // Show the image from the canvas
        canvasView.image = nil
        canvasView.image = c.canvas.image
        
    }


}

