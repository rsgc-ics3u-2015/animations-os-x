//
//  Sketch.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Foundation

class Sketch : NSObject {

    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas : Canvas
    
    // Declare any properties you need for your sketch below this comment, but before init()
    var x = 0
    var s = 1
    var backgroundRed : Bool = false // Boolean to toggle whether background is red

    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 300)
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 60
        
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw() {
                
        // Horizontal position of circle
        x = x + s
        
        // Bounce when hitting wall
        if (x > canvas.width || x < 0) {
            s *= -1
        }
        
        // "Clear" the background
        canvas.drawShapesWithBorders = false
        canvas.fillColor = Color(hue: 0, saturation: 0, brightness: 0, alpha: 10)
        // Decide what color to make the background
        if (backgroundRed == true) {
            canvas.fillColor = Color(hue: 0, saturation: 80, brightness: 90, alpha: 100)
        } else {
            canvas.fillColor = Color(hue: 0, saturation: 0, brightness: 0, alpha: 10)
        }
        canvas.drawRectangle(bottomRightX: 0, bottomRightY: 0, width: canvas.width, height: canvas.height)
        
        
        // Draw a circle that moves across the screen
        canvas.drawShapesWithBorders = false
        canvas.fillColor = Color(hue: Float(canvas.frameCount), saturation: 80, brightness: 90, alpha: 100)
        canvas.drawEllipse(centreX: x, centreY: canvas.height / 2, width: 25, height: 25)
        
        // Draw some text on the screen
        canvas.textColor = Color(hue: 0, saturation: 0, brightness: 100, alpha: 100) // white
        canvas.drawText(message: "Hello, world!")
        
        // Draw some more text on the screen
        canvas.textColor = Color(hue: 60, saturation: 80, brightness: 90, alpha: 100) // yellow
        canvas.drawText(message: "Current frame: \(canvas.frameCount)", size: 12, x: canvas.width / 16, y: canvas.height - canvas.height / 8)

        // Text with emoji works too
        canvas.drawText(message: "😜", size: 48, x: canvas.width - canvas.width / 4, y: canvas.height - canvas.height / 4)
        
        // Draw a circle where the mouse pointer is
        canvas.drawShapesWithBorders = false
        canvas.drawShapesWithFill = true
        canvas.fillColor = Color(hue: 0, saturation: 0, brightness: 100, alpha: 100)
        canvas.drawEllipse(centreX: Int(canvas.mouseX), centreY: Int(canvas.mouseY), width: 5, height: 5)

    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        // When the mouse is pressed, change the background color that will be used.
        if backgroundRed == true {
            backgroundRed = false
        } else {
            backgroundRed = true
        }
        
    }
    
}