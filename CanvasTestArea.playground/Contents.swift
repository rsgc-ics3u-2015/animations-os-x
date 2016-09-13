/*:
 
 # playground
 
 *noun*: a place where people can play
 
 ##
 
 Use this playground to experiment with the Canvas class.
 
 Your goals are to:
 
 * learn something about order of statements (does order matter?)
 * get familiar with using a Playground

 Have fun!

*/
// These are some required statements to make this playground work.
import Cocoa
import XCPlayground

// Create a new canvas
let canvas = Canvas(width: 300, height: 500)

// Draw a circle at the origin with radius of 50 pixels
canvas.drawEllipse(centreX: 0, centreY: 0, width: 50, height: 50)

// View the current state of the canvas
canvas

/*:
 ## Reflect
 
 What does this tell you about the location of the origin on the canvas?
 */

// Draw an ellipse no fill in the middle of the canvas
canvas.drawShapesWithFill = false
canvas.drawEllipse(centreX: 150, centreY: 250, width: 50, height: 100)

// View the current state of the canvas
canvas

/*:
 ## Reflect
 
 What if you changed the size of your canvas?
 
 Would the arguments to *drawEllipse* still place the ellipse at the middle of the canvas?
 
 */
// Draw a rectangle with red fill and no border in bottom left corner of canvas
canvas.fillColor = Color(hue: 0, saturation: 80, brightness: 90, alpha: 100)
canvas.drawShapesWithFill = true
canvas.drawShapesWithBorders = false
canvas.drawRectangle(bottomRightX: 250, bottomRightY: 0, width: 50, height: 50, borderWidth: 5)

// View the current state of the canvas
canvas

// Draw a thick vertical line from top of canvas to middle
canvas.drawLine(fromX: 150, fromY: 500, toX: 150, toY: 250, lineWidth: 10)

// View the current state of the canvas
canvas

// Draw circles with increasing size near the bottom of the canvas
canvas.drawShapesWithFill = false
canvas.drawShapesWithBorders = true
for diameter in 1...5 {
    
    canvas.drawEllipse(centreX: 150, centreY: 100, width: diameter*10, height: diameter*10)
    
}

// View the current state of the canvas
canvas

// Text with emoji works too – draw a winky face in the top left corner
canvas.drawText(message: "😜", size: 48, x: 0, y: 425)
canvas.drawText(message: "Yasss", size: 24, x: 0, y: 375)

// View the current state of the canvas
canvas


// This code is necessary to see the result in the Assistant Editor at right
XCPlaygroundPage.currentPage.liveView = canvas
