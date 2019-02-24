//
//  RYBColor.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 02/01/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

public class RYBSpace: RelativeSpace {
    private var red: Float
    private var yellow: Float
    private var blue: Float
    
    public init() {
        self.red = 0.0
        self.yellow = 0.0
        self.blue = 0.0
    }
    
    public init(red: Float, yellow: Float, blue: Float) {
        self.red = red
        self.yellow = yellow
        self.blue = blue
    }
    
    /**
     Converts from the RGB color space to the RYB color space.
     
     - parameters:
     - color: The RGB color to be converted.
     
     - throws: An error of type 'RGBColorError' if a color component has an invalid value or is nil
     */
    public func fromRGBSpace(space: RGBSpace) {
        
        var red = space.getRed()
        var green = space.getGreen()
        var blue = space.getBlue()
        
        // remove white from RGB color
        let white = min(red, green, blue)
        red -= white
        green -= white
        blue -= white
        
        let maxGreen = max(red, green, blue)
        
        // get yellow out of red and green
        var yellow = min(red, green)
        red -= yellow
        green -= yellow
        
        // if the conversion combines blue and green, then cut each in half to preserve the value's maximum range
        if blue > 0 && green > 0 {
            blue /= 2
            green /= 2
        }
        
        // redistribute the remaining green
        yellow += green
        blue += green
        
        // normalize
        let maxYellow = max(red, yellow, blue)
        if maxYellow > 0 {
            let normalized = maxGreen/maxYellow
            red *= normalized
            yellow *= normalized
            blue *= normalized
        }
        
        // add the white back in
        red += white
        yellow += white
        blue += white
        
        // update class variables
        self.red = red
        self.yellow = yellow
        self.blue = blue
        
    }
    
    /**
     Converts from the RYB color space to the RGB color space
     - returns: A new RGB color
     */
    public func toRGBSpace() -> RGBSpace {
        var red = self.red
        var yellow = self.yellow
        var blue = self.blue
        
        // remove white from RYB color
        let white = min(red, yellow, blue)
        red -= white
        yellow -= white
        blue -= white
        
        let maxYellow = max(red, yellow, blue)
        
        // get green out of yellow and blue
        var green = min(yellow, blue)
        yellow -= green
        blue -= green
        
        if blue > 0 && green > 0 {
            blue *= 2
            green *= 2
        }
        
        // redistribute the remaining yellow
        red += yellow
        green += yellow
        
        // normalize
        let maxGreen = max(red, green, blue)
        if maxGreen > 0 {
            let normalized = maxYellow/maxGreen
            red *= normalized
            green *= normalized
            blue *= normalized
        }
        
        // add the white back in
        red += white
        green += white
        blue += white
        
        return RGBSpace(red: red, green: green, blue: blue)
    }
    
    /**
     This method mixes two RYB colors together and updates the color attributes values of the instance that calls it.
     
     - parameters:
     - color: The other color you want to mix
     */
    public func mix(withColor color: RYBSpace) {
        let r = self.red + color.red
        let y = self.yellow + color.yellow
        let b = self.blue + color.blue
        
        let maxValue = max(r, y, b)
        
        let newRed = (r / maxValue)
        let newYellow = (y / maxValue)
        let newBlue = (b / maxValue)
        
        self.red = newRed
        self.yellow = newYellow
        self.blue = newBlue
    }
    
    public func getRed() -> Float {
        return self.red
    }
    
    public func getYellow() -> Float {
        return self.yellow
    }
    
    public func getBlue() -> Float {
        return self.blue
    }
}


