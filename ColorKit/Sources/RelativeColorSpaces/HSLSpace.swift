//
//  HSLSpace.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 14/02/2019.
//


public class HSLSpace: RelativeSpace {
    
    private var hue: Float
    private var saturation: Float
    private var lightness: Float
    
    public init() {
        self.hue = 0.0
        self.saturation = 0.0
        self.lightness = 0.0
    }
    
    public init(hue: Float, saturation: Float, lightness: Float) {
        self.hue = hue
        self.saturation = saturation
        self.lightness = lightness
    }
    
    public func fromRGBSpace(space: RGBSpace) {
        let red = space.getRed()
        let green = space.getGreen()
        let blue = space.getBlue()
        
        let M = max(red, green, blue)
        let m = min(red, green, blue)
        
        // Chroma is the difference between the largest and the smallest values among R, G or B in a color
        let chroma = M - m
        
        self.lightness = (M + m)/2
        
        guard chroma != 0 else {
            // This is a gray, no chroma
            self.saturation = 0
            self.hue = 0
            return
        }
        
        // Chromatic data
        if self.lightness < 0.5 {
            self.saturation = chroma/(M + m)
        } else {
            self.saturation = chroma/(2 - M - m)
        }
        
        let r = (((M - red)/6) + (chroma/2))/chroma
        let g = (((M - green)/6) + (chroma/2))/chroma
        let b = (((M - blue)/6) + (chroma/2))/chroma
        
        if red == M {
            self.hue = b - g
        } else if green == M {
            self.hue = (1/3) + r - b
        } else if blue == M {
            self.hue = (2/3) + g - r
        }
        
        if self.hue < 0 {
            self.hue += 1
        }
        
        if self.hue > 1 {
            self.hue -= 1
        }
        
    }
    
    public func toRGBSpace() -> RGBSpace {
        if self.saturation == 0 {
            return RGBSpace(red: self.lightness, green: self.lightness, blue: self.lightness)
        } else {
            var val1: Float
            var val2: Float
            
            if self.lightness < 0.5 {
                val2 = self.lightness * (1 + self.saturation)
            } else {
                val2 = (self.lightness + self.saturation) - (self.saturation * self.lightness)
            }
            
            val1 = 2 * self.lightness - val2
            
            let red = self.hueToRGB(v1: val1, v2: val2, vH: self.hue + (1/3))
            let green = self.hueToRGB(v1: val1, v2: val2, vH: self.hue)
            let blue = self.hueToRGB(v1: val1, v2: val2, vH: self.hue - (1/3))
            
            return RGBSpace(red: red, green: green, blue: blue)
        }
    }
    
    
    private func hueToRGB(v1: Float, v2: Float, vH: Float) -> Float {
        var v_H = vH
        
        if v_H < 0 { v_H += 1}
        if v_H > 1 { v_H -= 1}
        
        if 6 * v_H < 1 {
            return (v1 + (v2 - v1) * 6 * v_H)
        }
        
        if 2 * v_H < 1 {
            return v2
        }
        
        if 3 * v_H < 2 {
            return (v1 + (v2 - v1) * ((2/3) - v_H) * 6)
        }
        
        return v1
    }
    
    public func getHue() -> Float {
        return self.hue
    }
    
    public func getSaturation() -> Float {
        return self.saturation
    }
    
    public func getLightness() -> Float {
        return self.lightness
    }
}
