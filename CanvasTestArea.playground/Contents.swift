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
import PlaygroundSupport

// Create a new canvas
let canvas = Canvas(width: 300, height: 500)

// Draw a circle at the origin with radius of 50 pixels
canvas.drawEllipse(centreX: 0, centreY: 0, width: 50, height: 50)

// View the current state of the canvas
canvas


/*:
 ## Reflect
 
 Look at the code above that was used to draw a circle at the origin.
 
 Then look at the visual output, or result, of that code, also above.
 
 What does this tell you about the location of the origin on the canvas?
 
 */

// Draw an ellipse with no fill in the middle of the canvas
canvas.drawShapesWithFill = false
canvas.drawEllipse(centreX: 150, centreY: 250, width: 50, height: 100)

// View the current state of the canvas
canvas

/*:
 ## Reflect
 
 For the ellipse just drawn, look at the *arguments* for the **centreX** and **centreY** *parameters*.
 
 What if you changed the size of your canvas?
 
 Would the ellipse still draw in the middle of the canvas, if it was resized?
 
 Try making the height of the canvas 700 pixels.
 
 Now try changing the **centreY** argument to `canvas.height / 2`
 
 What happens?
 
 This is an example of using an expression as an argument, rather than a static value.
 
 Dynamic expressions generally make your code more "flexible" and are preferred to static values.
 
 Try changing the arguments for more shapes drawn later on in this playground.
 
 Can you come up with a dynamic expression that will keep the shape in the same place as the static argument?
 
 For how many shapes can you manage to do this?
 
 */
// Draw a rectangle with red fill and no border in bottom right corner of canvas
canvas.fillColor = Color(hue: 0, saturation: 80, brightness: 90, alpha: 100)
canvas.drawShapesWithFill = true
canvas.drawShapesWithBorders = false
canvas.drawRectangle(bottomLeftX: 250, bottomLeftY: 0, width: 50, height: 50, borderWidth: 5)

// View the current state of the canvas
canvas

// Draw a thick vertical line from top of canvas to middle
canvas.drawLine(fromX: 150, fromY: 500, toX: 150, toY: 250, lineWidth: 10)

// View the current state of the canvas
canvas

// Draw circles with increasing size near the bottom of the canvas
canvas.drawShapesWithFill = false
canvas.drawShapesWithBorders = true
for diameter in 1...5 {             // this loop iterates 5 times
    
    diameter                        // when the loop iterates, the diameter variable changes
    // Note the dynamic expressions used as arguments for
    // the width and height parameters
    canvas.drawEllipse(centreX: 150, centreY: 100, width: diameter * 10, height: diameter * 10)
    
}

// View the current state of the canvas, after the loop above
canvas

// Text with emoji works too – draw a winky face in the top left corner
canvas.drawText(message: "😜", size: 48, x: 0, y: 425)
canvas.drawText(message: "Hello", size: 24, x: 0, y: 375)

// View the current state of the canvas
canvas


// This code is necessary to see the result in the Assistant Editor at right
PlaygroundPage.current.liveView = canvas.imageView
