
// These are some required statements to make this playground work.
import Cocoa
import PlaygroundSupport

// Create a new canvas
let canvas = Canvas(width: 300, height: 500)
canvas.highPerformance = true
for i in 1...canvas.height / canvas.scale {
    canvas.drawLine(fromX: 0, fromY: i, toX: canvas.width / canvas.scale, toY: i)
}

// This code is necessary to see the result in the Assistant Editor at right
PlaygroundPage.current.liveView = canvas.imageView
