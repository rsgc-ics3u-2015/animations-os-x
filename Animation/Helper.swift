import Cocoa
import Foundation

open class Color {
    
    // FIXME: Need more research into how to properly write a class that handles invalid property geting/setting
    //
    // If I want to write a class that "fixes" or rationalizes invalid values provided to it, when:
    //
    // 1. initializing a new object
    // 2. setting properties of the object
    //
    // ...what is the correct way to do this in Swift?
    //
    // The purpose of the Color class I have written is to take hue, saturation, brightness,
    // and alpha values range between 0-360, 0-100, 0-100, and 0-100 respectively.
    //
    // My thought was that property observers are the answer:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Properties.html
    //
    // but Apple's documentation explicitly states that property observers are not called when
    // a property is set from within an initializer:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID204
    //
    // NOTE
    //
    //  When you assign a default value to a stored property, or set its initial value within an initializer, the value of that property is set directly, without calling any property observers.
    //
    // As you can see, I am using private functions that are called from the initializer
    // and the property observer (so I am not duplicating logic to rationalize the passed values).
    //
    // However, this seems inelegant.
    //
    // All in all, after doing more reading about failable initializers:
    //
    // https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Initialization.html#//apple_ref/doc/uid/TP40014097-CH18-ID203
    //
    // ... it really seems like perhaps I should NOT be trying to rationalize invalid values. Perhaps, instead, I should just fail to initialize an object if bad values are provided.
    //
    // Future self – something to think about.
    
    // Static properties for convenience for basic colors
    public static let black : Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    public static let white : Color = Color(hue: 0, saturation: 0, brightness: 100, alpha: 100)
    public static let red : Color = Color(hue: 0, saturation: 80, brightness: 90, alpha: 100)
    public static let orange : Color = Color(hue: 30, saturation: 80, brightness: 90, alpha: 100)
    public static let yellow : Color = Color(hue: 60, saturation: 80, brightness: 90, alpha: 100)
    public static let green : Color = Color(hue: 120, saturation: 80, brightness: 90, alpha: 100)
    public static let blue : Color = Color(hue: 240, saturation: 80, brightness: 90, alpha: 100)
    public static let purple : Color = Color(hue: 270, saturation: 80, brightness: 90, alpha: 100)
    
    var hue: Float = 0.0 {
        didSet {
            hue = self.rationalizeToSinglePositiveRotation(hue)
            self.translatedHue = CGFloat(self.hue / 360)
        }
    }
    
    var saturation: Float = 0.0 {
        didSet {
            saturation = self.rationalizePercentage(saturation)
            self.translatedSaturation = CGFloat(self.saturation / 100)
        }
    }
    
    var brightness: Float = 0.0 {
        didSet {
            brightness = self.rationalizePercentage(brightness)
            self.translatedBrightness = CGFloat(self.brightness / 100)
        }
    }
    
    var alpha: Float = 0.0 {
        didSet {
            alpha = self.rationalizePercentage(alpha)
            self.translatedAlpha = CGFloat(self.alpha / 100)
        }
    }
    
    var translatedHue : CGFloat = 0.0
    var translatedSaturation : CGFloat = 0.0
    var translatedBrightness : CGFloat = 0.0
    var translatedAlpha : CGFloat = 0.0
    
    public init(hue: Float, saturation: Float, brightness: Float, alpha: Float) {
        
        // Set with provided values, but translate to valid values first
        self.hue = rationalizeToSinglePositiveRotation(hue)
        self.saturation = rationalizePercentage(saturation)
        self.brightness = rationalizePercentage(brightness)
        self.alpha = rationalizePercentage(alpha)
        
        // Prepare values to provide to NSColor initializer
        self.translatedHue = CGFloat(self.hue / 360)
        self.translatedSaturation = CGFloat(self.saturation / 100)
        self.translatedBrightness = CGFloat(self.brightness / 100)
        self.translatedAlpha = CGFloat(self.alpha / 100)
        
    }
    
    // Takes a given number of degrees and translates to range between 0 and 360
    fileprivate func rationalizeToSinglePositiveRotation(_ value : Float) -> Float {
        
        if value < 0 {
            return 0.0
        } else if value > 360 {
            return value.truncatingRemainder(dividingBy: 360)
        }
        
        return value
        
    }
    
    // Takes a given value and translates to a percentage between 0 and 100
    fileprivate func rationalizePercentage(_ value : Float) -> Float {
        
        if value < 0 {
            return 0.0
        } else if value > 100 {
            return value.truncatingRemainder(dividingBy: 100)
        }
        
        return value
        
    }
    
}

open class Canvas : CustomPlaygroundQuickLookable {
    
    /// A custom playground Quick Look for this instance.
    ///
    /// If this type has value semantics, the `PlaygroundQuickLook` instance
    /// should be unaffected by subsequent mutations.
    public var customPlaygroundQuickLook: PlaygroundQuickLook {
        return .image(self.imageView)
    }
    
    // Frame rate for animation on this canvas
    var framesPerSecond : Int = 60 {
        didSet {
            // Ensure rational frame rate set
            if (framesPerSecond < 0) {
                framesPerSecond = 1
            }
        }
    }
    
    // Keep track of how many frames have been animated using this particular canvas
    var frameCount : Int = 0
    
    // Image view that will display our image
    open var imageView: NSImageView = NSImageView()
    
    // default line width
    open var defaultLineWidth: Int = 1 {
        didSet {
            // Ensure rational line width set
            if (defaultLineWidth < 0) {
                defaultLineWidth = 1
            }
        }
    }
    
    // Line color, default is black
    open var lineColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // Border width for closed shapes
    open var defaultBorderWidth: Int = 1 {
        didSet {
            // Ensure rational border width set
            if (defaultBorderWidth < 0) {
                defaultBorderWidth = 1
            }
        }
    }
    
    // Border color, default is black
    open var borderColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // Fill color, default is black
    open var fillColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // Text color, default is black
    open var textColor: Color = Color(hue: 0, saturation: 0, brightness: 0, alpha: 100)
    
    // Whether to draw shapes with borders
    open var drawShapesWithBorders: Bool = true
    
    // Whether to draw shapes with fill
    open var drawShapesWithFill: Bool = true
    
    // Size of canvas
    open let width : Int
    open let height : Int
    
    // Current location of mouse on canvas
    open var mouseX : Float = 0.0
    open var mouseY : Float = 0.0
    
    // Initialization of object based on this class
    public init(width: Int, height: Int) {
        
        // Set the width and height of the canvas
        self.width = width
        self.height = height
        
        // Create the frame that defines boundaries of the image view to be used
        let frameRect = NSRect(x: 0, y: 0, width: self.width, height: self.height)
        
        // Create the image view based on dimensions of frame created
        self.imageView = NSImageView(frame: frameRect)
        
        // Define the size of the image that will be presented in the image view
        let imageSize = NSMakeSize(CGFloat(self.width), CGFloat(self.height))
        
        // Create the blank image that will be presented in the image view
        let image = NSImage(size: imageSize)
        
        // Set this (currently blank) image so that it is displayed by the image view
        self.imageView.image = image
        
        // Make the background white
        self.fillColor = Color.white
        self.drawShapesWithBorders = false
        self.drawRectangle(bottomLeftX: 0, bottomLeftY: 0, width: self.width, height: self.height)
        self.fillColor = Color.black
        self.drawShapesWithBorders = true
        
    }
    
    // Draw text on the image
    open func drawText(message: String, size: Int = 24, x: Int = 0, y: Int = 0)  {
        
        // If an image has been defined for the image view, draw on it
        if let _ = self.imageView.image?.lockFocus() {
            
            // Convert the provided String object to an NSString object
            let string: NSString = NSString(string: message)
            
            // set the text color to dark gray
            let fieldColor : NSColor = NSColor(hue: textColor.translatedHue, saturation: textColor.translatedSaturation, brightness: textColor.translatedBrightness, alpha: textColor.translatedAlpha)
            
            // set the font to Helvetica Neue 18
            let fieldFont = NSFont(name: "Helvetica Neue", size: CGFloat(size))
            
            // set the line spacing to 1
            let paraStyle = NSMutableParagraphStyle()
            paraStyle.lineSpacing = 1.0
            
            // set the Obliqueness (tilt of text) to 0.0
            let skew = 0.0
            
            // create dictionary with attributes of the string to be drawn
            let attributes: [String : AnyObject] = [
                NSForegroundColorAttributeName: fieldColor,
                NSParagraphStyleAttributeName: paraStyle,
                NSObliquenessAttributeName: skew as AnyObject,
                NSFontAttributeName: fieldFont!
            ]
            
            // Draw the string
            string.draw(at: NSPoint(x: x, y: y), withAttributes: attributes)
            
            // Stop drawing to the image
            self.imageView.image!.unlockFocus()
            
        }
    }
    
    // Draw a line on the image
    open func drawLine(fromX: Int, fromY: Int, toX: Int, toY: Int, lineWidth: Int = 0) {
        
        // If an image has been defined for the image view, draw on it
        if let _ = self.imageView.image?.lockFocus() {
            
            
            // Make the new path
            let path = NSBezierPath()
            
            // Set width of border
            if lineWidth > 0 {
                path.lineWidth = CGFloat(lineWidth)
            } else {
                path.lineWidth = CGFloat(self.defaultLineWidth)
            }
            
            // Define the line
            path.move(to: NSPoint(x: fromX, y: fromY))
            path.line(to: NSPoint(x: toX, y: toY))
            
            // Set the line's color
            NSColor(hue: lineColor.translatedHue, saturation: lineColor.translatedSaturation, brightness: lineColor.translatedBrightness, alpha: lineColor.translatedAlpha).setStroke()
            
            // Draw the line
            path.stroke()
            
            // Stop drawing to the image
            self.imageView.image!.unlockFocus()
            
        }
    }
    
    // Draw an ellipse on the image
    open func drawEllipse(centreX: Int, centreY: Int, width: Int, height: Int, borderWidth: Int = 0) {
        
        // If an image has been defined for the image view, draw on it
        if let _ = self.imageView.image?.lockFocus() {
            
            // Make the new path
            let path = NSBezierPath(ovalIn: NSRect(x: centreX - width/2, y: centreY - height/2, width: width, height: height))
            
            // Set width of border
            if borderWidth > 0 {
                path.lineWidth = CGFloat(borderWidth)
            } else {
                path.lineWidth = CGFloat(self.defaultBorderWidth)
            }
            
            // Set ellipse border color
            NSColor(hue: borderColor.translatedHue, saturation: borderColor.translatedSaturation, brightness: borderColor.translatedBrightness, alpha: borderColor.translatedAlpha).setStroke()
            
            // Draw the ellipse border
            if (self.drawShapesWithBorders == true) {
                path.stroke()
            }
            
            // Set ellipse fill color
            NSColor(hue: fillColor.translatedHue, saturation: fillColor.translatedSaturation, brightness: fillColor.translatedBrightness, alpha: fillColor.translatedAlpha).setFill()
            
            // Fill the ellipse
            if (self.drawShapesWithFill == true) {
                path.fill()
            }
            
            // Stop drawing to the image
            self.imageView.image!.unlockFocus()
            
        }
    }
    
    // Draw a rectangle on the image
    open func drawRectangle(bottomLeftX: Int, bottomLeftY: Int, width: Int, height: Int, borderWidth: Int = 1) {
        
        // If an image has been defined for the image view, draw on it
        if let _ = self.imageView.image?.lockFocus() {
            
            // Make the new path
            let path = NSBezierPath()
            
            // Set width of border
            if borderWidth > 0 {
                path.lineWidth = CGFloat(borderWidth)
            } else {
                path.lineWidth = CGFloat(self.defaultBorderWidth)
            }
            
            // Define the path
            path.move(to: NSPoint(x: bottomLeftX, y: bottomLeftY))
            path.line(to: NSPoint(x: bottomLeftX + width, y: bottomLeftY))
            path.line(to: NSPoint(x: bottomLeftX + width, y: bottomLeftY + height))
            path.line(to: NSPoint(x: bottomLeftX, y: bottomLeftY + height))
            path.line(to: NSPoint(x: bottomLeftX, y: bottomLeftY))
            
            // Set rectangle border color
            NSColor(hue: borderColor.translatedHue, saturation: borderColor.translatedSaturation, brightness: borderColor.translatedBrightness, alpha: borderColor.translatedAlpha).setStroke()
            
            // Draw the rectangle border
            if (self.drawShapesWithBorders == true) {
                path.stroke()
            }
            
            // Set rectangle fill color
            NSColor(hue: fillColor.translatedHue, saturation: fillColor.translatedSaturation, brightness: fillColor.translatedBrightness, alpha: fillColor.translatedAlpha).setFill()
            
            // Fill the rectangle
            if (self.drawShapesWithFill == true) {
                path.fill()
            }
            
            // Stop drawing to the image
            self.imageView.image!.unlockFocus()
            
        }
    }
    
    
}
