//
//  RGBSpace.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 13/02/2019.
//

import Foundation

internal protocol RelativeSpace {
    func fromRGBSpace(space: RGBSpace)
    func toRGBSpace() -> RGBSpace
}

enum RGBColorError: Error {
    case UndefinedRedComponent
    case UndefinedGreenComponent
    case UndefinedBlueComponent
}

public class RGBSpace {
    
    public var red: CGFloat
    public var green: CGFloat
    public var blue: CGFloat
    
    public init() {
        self.red = 0.0
        self.green = 0.0
        self.blue = 0.0
    }
    
    public init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    public func toColor() -> UIColor {
        return UIColor(red: self.red, green: self.green, blue: self.blue, alpha: 1.0)
    }
    
    public func fromColor(color: UIColor) throws {
        guard let red = color.rgbColorComponent?.red else {
            throw RGBColorError.UndefinedRedComponent
        }
        
        guard let green = color.rgbColorComponent?.green else {
            throw RGBColorError.UndefinedGreenComponent
        }
        
        guard let blue = color.rgbColorComponent?.blue else {
            throw RGBColorError.UndefinedBlueComponent
        }
        
        self.red = red
        self.green = green
        self.blue = blue
    }
}

fileprivate extension UIColor {
    var rgbColorComponent: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        guard let components = self.cgColor.components else { return nil }
        
        return (
            red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3]
        )
    }
}
