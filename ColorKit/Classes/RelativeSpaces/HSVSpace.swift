//
//  HSVColor.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 02/01/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import Foundation
import UIKit

internal enum HSVColorError: Error {
    case UndefinedValue
    case UndefinedHue
}

public class HSVSpace: RelativeSpace {
    public var hue: CGFloat
    public var saturation: CGFloat
    public var value: CGFloat
    
    public init(){
        self.hue = 0.0
        self.saturation = 0.0
        self.value = 0.0
    }
    
    public init(hue: CGFloat, saturation: CGFloat, value: CGFloat) {
        self.hue = hue
        self.saturation = saturation
        self.value = value
    }
    
    public func fromRGBSpace(space: RGBSpace)  {
        
        let red = space.red
        let green = space.green
        let blue = space.blue
        
        let M = max(red, green, blue)
        let m = min(red, green, blue)
        
        // Chroma is the difference between the largest and the smallest values among R, G or B in a color
        let chroma = M - m
        
        guard M > 0 else {
            return
        }
        
        // VALUE is defined as the largest component of a color
        self.value = M
        
        guard M != 0 else {
            self.saturation = 0
            self.hue = 0
            return
        }
        
        // SATURATION
        self.saturation = chroma / M
        
        // HUE
        var hue: CGFloat
        if red == M {
            hue = ((green - blue)/chroma).truncatingRemainder(dividingBy: 6)
        }else if green == M {
            hue = (blue - red)/chroma + 2.0
        }else {
            hue = (red - green)/chroma + 4.0
        }
        
        hue *= 60.0
        
        if hue < 0 {
            hue += 360.0
        }
        
        self.hue = hue
        self.saturation *= 100
        self.value *= 100
    }
    
    public func toRGBSpace() -> RGBSpace {
        if self.saturation == 0 {
            return RGBSpace(red: self.value, green: self.value, blue: self.value)
        }else {
            var hue: CGFloat = 0.0
            var saturation: CGFloat = 0.0
            var value: CGFloat = 0.0
            
            var i: Int
            var f, p, q, t: CGFloat
            
            if self.hue == 360 {
                self.hue = 0
            }
            
            hue = self.hue / 60.0
            i = Int(hue)
            f = hue - CGFloat(i)
            
            value = self.value / 100.0
            saturation = self.saturation / 100.0
            
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
}











