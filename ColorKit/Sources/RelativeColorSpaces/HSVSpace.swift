//
//  HSVColor.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 02/01/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//


internal enum HSVColorError: Error {
    case UndefinedValue
    case UndefinedHue
}

public class HSVSpace: RelativeSpace {
    private var hue: Float
    private var saturation: Float
    private var value: Float
    
    public init(){
        self.hue = 0.0
        self.saturation = 0.0
        self.value = 0.0
    }
    
    public init(hue: Float, saturation: Float, value: Float) {
        self.hue = hue
        self.saturation = saturation
        self.value = value
    }
    
    public func fromRGBSpace(space: RGBSpace)  {
        
        let red = space.getRed()
        let green = space.getGreen()
        let blue = space.getBlue()
        
        let M = max(red, green, blue)
        let m = min(red, green, blue)
        
        // Chroma is the difference between the largest and the smallest values among R, G or B in a color
        let chroma = M - m
        
        // VALUE is defined as the largest component of a color
        self.value = M * 100
        
        guard chroma != 0 else {
            self.saturation = 0
            self.hue = 0
            return
        }
        
        // SATURATION
        self.saturation = chroma / M
        
        // HUE
        var hue: Float
        if red == M {
            hue = ((green - blue)/chroma).truncatingRemainder(dividingBy: 6)
        } else if green == M {
            hue = (blue - red)/chroma + 2.0
        } else {
            hue = (red - green)/chroma + 4.0
        }
        
        hue *= 60.0
        
        if hue < 0 {
            hue += 360.0
        }
        
        self.hue = hue
        self.saturation *= 100

    }
    
    public func toRGBSpace() -> RGBSpace {
        var hue: Float
        let saturation = self.saturation/100
        let value = self.value/100
        
        if saturation == 0 {
            return RGBSpace(red: value, green: value, blue: value)
        }else {
            var i: Int
            var f, p, q, t: Float
            
            if self.hue == 360 {
                self.hue = 0
            }
            
            hue = self.hue / 60.0
            i = Int(hue)
            f = hue - Float(i)
            
            p = value * (1.0 - saturation)
            q = value * (1.0 - (saturation * f))
            t = value * (1.0 - (saturation * (1.0 - f)))
            
            switch i {
            case 0:
                return RGBSpace(red: value, green: t, blue: p)
            case 1:
                return RGBSpace(red: q, green: value, blue: p)
            case 2:
                return RGBSpace(red: p, green: value, blue: t)
            case 3:
                return RGBSpace(red: p, green: q, blue: value)
            case 4:
                return RGBSpace(red: t, green: p, blue: value)
            case 5:
                return RGBSpace(red: value, green: p, blue: q)
            default:
                return RGBSpace()
            }
        }
    }
    
    public func getHue() -> Float {
        return self.hue
    }
    
    public func getSaturation() -> Float {
        return self.saturation
    }
    
    public func getValue() -> Float {
        return self.value
    }
}











