//
//  Sketch.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Foundation

class Sketch {

    // Declare variables and constants to be used by methods below here
    var c : Canvas
    var fps : Int = 60
    var frameCount = 0
    var x = 0
    var s = 1

    // This is equivalent to the setup() function in Processing
    init() {
        
        // Create canvas object – specify size
        c = Canvas(width: 700, height: 100)
        
    }
    
    // This is equivalent to the draw() function in Processing
    func draw() {
        
        // Keep track of how many frames have been drawn
        frameCount++
        
        // Horizontal position of circle
        x = x + s
        
        // Bounce when hitting wall
        if (x > 480 || x < 0) {
            s *= -1
        }
        
        // Clear the background
        c.drawShapesWithBorders = false
        c.fillColor = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
        c.drawRectangle(bottomRightX: 0, bottomRightY: 0, width: c.width, height: c.height)
        
        // Draw a circle that moves across the screen
        c.drawShapesWithBorders = false
        c.fillColor = Color(hue: Float(frameCount), saturation: 80, brightness: 90, alpha: 100)
        c.drawEllipse(centreX: x, centreY: 135, width: 25, height: 25)
        
    }
    
}