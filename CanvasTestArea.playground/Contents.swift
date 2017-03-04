
// These are some required statements to make this playground work.
import Cocoa
import PlaygroundSupport

// Create a new canvas
let canvas = Canvas(width: 300, height: 500)

canvas.saveState()
canvas.translate(byX: 0, byY: 300)
canvas.rotate(by: -20)
canvas.drawRectangle(centreX: 0, centreY: 0, width: 100, height: 100)
canvas.rotate(by: 20)
canvas.translate(byX: 0, byY: -150)
canvas.drawRectangle(centreX: 0, centreY: 0, width: 100, height: 100)
canvas.restoreState()

canvas.fillColor = Color.red
canvas.drawRectangle(centreX: 0, centreY: 0, width: 50, height: 50)


// This code is necessary to see the result in the Assistant Editor at right
PlaygroundPage.current.liveView = canvas.imageView
