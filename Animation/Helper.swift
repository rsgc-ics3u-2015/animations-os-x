import Cocoa
import Foundation

public class Color {
    
    var hue: Float = 0.0 {
        didSet {
            if (hue < 0) {
                hue = 0
            }
            if (hue > 360) {
                hue = hue % 360
            }
        }
    }
    
    var saturation: Float = 0.0 {
        didSet {
            if (saturation < 0) {
                saturation = 0
            }
            if (saturation > 100) {
                saturation = saturation % 100
            }
        }
    }
    
    var brightness: Float {
        didSet {
            if (brightness < 0) {
                brightness = 0
            }
            if (brightness > 100) {
                brightness = brightness % 100
            }
        }
    }
    
    var alpha: Float {
        didSet {
            if (alpha < 0) {
                alpha = 0
            }
            if (alpha > 100) {
                alpha = alpha % 100
            }
        }
    }
    
    var translatedHue: CGFloat
    var translatedSaturation: CGFloat
    var translatedBrightness: CGFloat
    var translatedAlpha: CGFloat
    
    
    public init(hue: Float, saturation: Float, brightness: Float, alpha: Float) {
        
        // Set with provided values
        if (hue > 360) {
            self.hue = hue % 360
        } else {
            self.hue = hue
        }
        self.saturation = saturation
        self.brightness = brightness
        self.alpha = alpha
        
        // Prepare values to provide to NSColor initializer
        self.translatedHue = CGFloat(self.hue / 360)
        self.translatedSaturation = CGFloat(self.saturation / 100)
        self.translatedBrightness = CGFloat(self.brightness / 100)
        self.translatedAlpha = CGFloat(self.alpha / 100)
        
    }
}

@objc public class Canvas : NSObject {
    
    // Image view to be displayed
    public var canvas: NSImageView = NSImageView()
    
    // line width
    public var defaultLineWidth: Int = 1 {
        didSet {
            if (defaultLineWidth < 0) {
                defaultLineWidth = 1
            }
        }
    }
    
    // line color
    public var lineColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // border width for closed shapes
    public var defaultBorderWidth: Int = 1 {
        didSet {
            if (defaultBorderWidth < 0) {
                defaultBorderWidth = 0
            }
        }
    }
    
    // border color
    public var borderColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // fill color
    public var fillColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // whether to draw shapes with borders
    public var drawShapesWithBorders: Bool = true
    
    // whether to draw shapes with fill
    public var drawShapesWithFill: Bool = true
    
    // size of canvas
    public var width : Int
    public var height : Int
    
    // Initialization of object based on this class
    public init(width: Int, height: Int) {
        
        // Set the width and height of the sketch
        self.width = width
        self.height = height
        
        // Create the frame
        let frameRect = NSRect(x: 0, y: 0, width: self.width, height: self.height)
        
        // Set the view, or canvas, to place an image on
        self.canvas = NSImageView(frame: frameRect)
        
        // Define the size of the image, or 'canvas', we want to use
        let mySize = NSMakeSize(CGFloat(self.width), CGFloat(self.height))
        
        // Create the blank image that will be painted on the canvas
        let myImage = NSImage(size: mySize)
        
        // Set the image to be displayed on the canvas
        self.canvas.image = myImage
        
    }
    
    public func drawLine(fromX fromX: Int, fromY: Int, toX: Int, toY: Int, lineWidth: Int = 0) -> NSBezierPath {
        
        // Draw on the image that (presumably) has been defined on this canvas
        if let _ = self.canvas.image?.lockFocus() {
            
            // Make the new path
            let path = NSBezierPath()
            
            // Set width of border
            if lineWidth > 0 {
                path.lineWidth = CGFloat(lineWidth)
            } else {
                path.lineWidth = CGFloat(self.defaultLineWidth)
            }
            
            // Define the line
            path.moveToPoint(NSPoint(x: fromX, y: fromY))
            path.lineToPoint(NSPoint(x: toX, y: toY))
            
            // Draw the line
            NSColor(hue: lineColor.translatedHue, saturation: lineColor.translatedSaturation, brightness: lineColor.translatedBrightness, alpha: lineColor.translatedAlpha).setStroke()
            path.stroke()
            
            // Stop drawing to the canvas image
            self.canvas.image!.unlockFocus()
            
            return path
            
        } else {
            
            // If an error occured, return an empty path
            return NSBezierPath()
            
        }
        
        
    }
    
    public func drawEllipse(centreX centreX: Int, centreY: Int, width: Int, height: Int, borderWidth: Int = 1) -> NSBezierPath {
        
        // Draw on the image that (presumably) has been defined on this canvas
        if let _ = self.canvas.image?.lockFocus() {
            
            // Make the new path
            let path = NSBezierPath(ovalInRect: NSRect(x: centreX - width/2, y: centreY - height/2, width: width, height: height))
            
            // Set width of border
            if borderWidth > 0 {
                path.lineWidth = CGFloat(borderWidth)
            } else {
                path.lineWidth = CGFloat(self.defaultBorderWidth)
            }
            
            // Draw the ellipse border
            NSColor(hue: borderColor.translatedHue, saturation: borderColor.translatedSaturation, brightness: borderColor.translatedBrightness, alpha: borderColor.translatedAlpha).setStroke()
            if (self.drawShapesWithBorders == true) {
                path.stroke()
            }
            
            // Fill the ellipse
            NSColor(hue: fillColor.translatedHue, saturation: fillColor.translatedSaturation, brightness: fillColor.translatedBrightness, alpha: fillColor.translatedAlpha).setFill()
            if (self.drawShapesWithFill == true) {
                path.fill()
            }
            
            // Stop drawing to the canvas image
            self.canvas.image!.unlockFocus()
            
            return path
            
        } else {
            
            // If an error occured, return an empty path
            return NSBezierPath()
            
        }
    }
    
    public func drawRectangle(bottomRightX bottomRightX: Int, bottomRightY: Int, width: Int, height: Int, borderWidth: Int = 1) -> NSBezierPath {
        
        // Draw on the image that (presumably) has been defined on this canvas
        if let _ = self.canvas.image?.lockFocus() {
            
            // Make the new path
            let path = NSBezierPath()
            
            // Set width of border
            if borderWidth > 0 {
                path.lineWidth = CGFloat(borderWidth)
            } else {
                path.lineWidth = CGFloat(self.defaultBorderWidth)
            }
            
            // Define the path
            path.moveToPoint(NSPoint(x: bottomRightX, y: bottomRightY))
            path.lineToPoint(NSPoint(x: bottomRightX + width, y: bottomRightY))
            path.lineToPoint(NSPoint(x: bottomRightX + width, y: bottomRightY + height))
            path.lineToPoint(NSPoint(x: bottomRightX, y: bottomRightY + height))
            path.lineToPoint(NSPoint(x: bottomRightX, y: bottomRightY))
            
            // Draw the rectangle border
            NSColor(hue: borderColor.translatedHue, saturation: borderColor.translatedSaturation, brightness: borderColor.translatedBrightness, alpha: borderColor.translatedAlpha).setStroke()
            if (self.drawShapesWithBorders == true) {
                path.stroke()
            }
            
            // Fill the rectangle
            NSColor(hue: fillColor.translatedHue, saturation: fillColor.translatedSaturation, brightness: fillColor.translatedBrightness, alpha: fillColor.translatedAlpha).setFill()
            if (self.drawShapesWithFill == true) {
                path.fill()
            }
            
            // Stop drawing to the canvas image
            self.canvas.image!.unlockFocus()
            
            return path
        } else {
            
            // If an error occured, return an empty path
            return NSBezierPath()
            
        }
        
    }
    
    func debugQuickLookObject() -> AnyObject? {
        
        return self.canvas.image!
        
    }
}


