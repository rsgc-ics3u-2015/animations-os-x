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
    var sketch = Sketch()
    
    @IBOutlet var canvasView: NSImageCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize the timer used to drive the sketch
        timer = NSTimer.scheduledTimerWithTimeInterval(1/Double(sketch.fps), target: self, selector: Selector("timedDraw"), userInfo: nil, repeats: true)
        
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        
        // Before the view appears, resize to match the size of the canvas we are painting on
        // See: http://stackoverflow.com/questions/27578085/resizing-window-to-view-controller-size-in-storyboard
        preferredContentSize = NSSize(width: sketch.c.width, height: sketch.c.height)
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func timedDraw() {
        
        // Call the draw() method on the Sketch object
        sketch.draw()
        
        // Show the image from the canvas
        canvasView.image = nil
        canvasView.image = sketch.c.canvas.image
        
        
    }
    
    
}

