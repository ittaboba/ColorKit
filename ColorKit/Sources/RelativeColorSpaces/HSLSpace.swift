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
        
        self.lightness = (M + m)/2 * 100
        
        guard chroma != 0 else {
            // This is a gray, no chroma
            self.saturation = 0
            self.hue = 0
            return
        }
        
        // Chromatic data
        if self.lightness < 50 {
            self.saturation = chroma/(M + m)
        } else {
            self.saturation = chroma/(2 - M - m)
        }
        
        var hue: Float
        if red == M {
            hue = (green - blue)/chroma
        } else if green == M {
            hue = 2 + (blue - red)/chroma
        } else {
            hue = 4 + (red - green)/chroma
        }
        
        hue *= 60
        
        if hue < 0 {
            hue += 360.0
        }
        
        self.hue = hue
        self.saturation *= 100
    }
    
    public func toRGBSpace() -> RGBSpace {
        let hue = self.hue/360
        let saturation = self.saturation/100
        let lightness = self.lightness/100
        
        if saturation == 0 {
            return RGBSpace(red: lightness, green: lightness, blue: lightness)
        } else {
            var val1: Float
            var val2: Float
            
            if lightness < 0.5 {
                val2 = lightness * (1 + saturation)
            } else {
                val2 = (lightness + saturation) - (saturation * lightness)
            }
            
            val1 = 2 * lightness - val2
            
            let red = self.hueToRGB(v1: val1, v2: val2, vH: hue + 1/3)
            let green = self.hueToRGB(v1: val1, v2: val2, vH: hue)
            let blue = self.hueToRGB(v1: val1, v2: val2, vH: hue - 1/3)
            
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
