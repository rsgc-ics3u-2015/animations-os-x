//
//  Sketch.swift
//  Animation
//
//  Created by Russell Gordon on 2015-12-05.
//  Copyright © 2015 Royal St. George's College. All rights reserved.
//

import Foundation

class Sketch {

    // NOTE: Every sketch must contain an object of type Canvas named 'canvas'
    //       Therefore, the line immediately below must always be present.
    let canvas : Canvas
    
    // Declare any properties you need for your sketch below this comment, but before init()
    var balls:[Ball] = [] // empty array of balls

    // This runs once, equivalent to setup() in Processing
    init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 900, height: 700)
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 60
        
        // create 100 bouncing balls
        for i in 0...99 {
            balls.insert(Ball(boundingWidth: canvas.width, boundingHeight: canvas.height), atIndex: i)
        }
        
        // No borders for these shapes
        canvas.drawShapesWithBorders = false
        
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw() {
        
        // "Clear" the background with a semi-transparent black rectangle
        canvas.fillColor = Color(hue: 0, saturation: 0, brightness: 0, alpha: 10)
        canvas.drawRectangle(bottomRightX: 0, bottomRightY: 0, width: canvas.width, height: canvas.height)
        
        // Update and draw each ball
        canvas.fillColor = Color(hue: Float(canvas.frameCount), saturation: 80, brightness: 90, alpha: 100)
        for ball in balls {
            
            ball.updatePosition(on: canvas)
            
        }
        
    }
    
}

// A bouncing ball
class Ball {
    var x : Int
    var y : Int
    var xSpeed : Int
    var ySpeed : Int
    
    // intialize a ball within boundaries given
    init(boundingWidth width: Int, boundingHeight height: Int) {
        
        // Random starting position somewhere on the cavas
        self.x = Int(arc4random_uniform(UInt32(width)))
        self.y = Int(arc4random_uniform(UInt32(height)))
        
        // Random speed of -1, -2, -3, 1, 2, 3, but not zero (all particles need to move)
        self.xSpeed = Int(arc4random_uniform(UInt32(6))) - 3
        self.ySpeed = Int(arc4random_uniform(UInt32(6))) - 3
        if self.xSpeed == 0 {
            self.xSpeed = 1
        }
        if self.ySpeed == 0 {
            self.ySpeed = 1
        }
        
    }
    
    // update the ball's position and then draw it
    func updatePosition(on canvas: Canvas) {
        
        // Change position
        x += xSpeed
        y += ySpeed
        
        // Bounce on left and right sides
        if x > canvas.width || x < 0 {
            xSpeed *= -1
        }
        
        // Bounce on top and bottom sides
        if y > canvas.height || y < 0 {
            ySpeed *= -1
        }
        
        // Draw the ball in it's new position
        canvas.drawEllipse(centreX: x, centreY: y, width: 5, height: 5)
        
    }
    
}