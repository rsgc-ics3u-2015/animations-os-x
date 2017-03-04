
// These are some required statements to make this playground work.
import Cocoa
import PlaygroundSupport

// Create a new canvas
let canvas = Canvas(width: 300, height: 500)

canvas.defaultLineWidth = 20
canvas.drawLine(fromX: 50, fromY: 50, toX: 200, toY: 200)
canvas.drawLine(fromX: 150, fromY: 50, toX: 300, toY: 200)

// This code is necessary to see the result in the Assistant Editor at right
PlaygroundPage.current.liveView = canvas.imageView
