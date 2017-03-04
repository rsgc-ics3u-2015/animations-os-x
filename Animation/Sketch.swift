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
    
    // Declare constants
    let north = 0
    let northEast = 1
    let east = 2
    let southEast = 3
    let south = 4
    let southWest = 5
    let west = 6
    let northWest = 7
    
    // Set the step size (travel distance per iteration)
    let stepSize = 5
    
    // Set the pixel size
    let diameter = 7
    
    // Generate a starting position
    var x = 0
    var y = 0
    
    // This runs once, equivalent to setup() in Processing
    override init() {
        
        // Create canvas object – specify size
        canvas = Canvas(width: 500, height: 300)
        
        // The frame rate can be adjusted; the default is 60 fps
        canvas.framesPerSecond = 60
        
        // Set starting position
        x = random(from: 50, toButNotIncluding: canvas.width - 50)
        y = random(from: 50, toButNotIncluding: canvas.height - 50)
        
        // No borders
        canvas.drawShapesWithBorders = false
        
    }
    
    // Runs repeatedly, equivalent to draw() in Processing
    func draw() {
        
        // Generate a random direction
        var direction = random(from: 0, toButNotIncluding: 8)
        
        // Reverse direction if edge reached
        if x + stepSize > canvas.width {
            direction = west
        }
        if x - stepSize < 0 {
            direction = east
        }
        if y + stepSize > canvas.height {
            direction = south
        }
        if y - stepSize < 0 {
            direction = north
        }
        
        // Change position based on direction and step size
        if direction == north {
            y = y + stepSize
        } else if direction == northEast {
            x = x + stepSize
            y = y + stepSize
        } else if direction == east {
            x = x + stepSize
        } else if direction == southEast {
            x = x + stepSize
            y = y - stepSize
        } else if direction == south {
            y = y - stepSize
        } else if direction == southWest {
            x = x - stepSize
            y = y - stepSize
        } else if direction == west {
            x = x - stepSize
        } else if direction == northWest {
            x = x - stepSize
            y = y + stepSize
        }
        
        // Draw the agent in it's new position
        canvas.fillColor = Color(hue: 0, saturation: 0, brightness: 0, alpha: 25)
        canvas.drawEllipse(centreX: x, centreY: y, width: diameter, height: diameter)
    }
    
    // Respond to the mouseDown event
    func mouseDown() {
        
        
    }

}
