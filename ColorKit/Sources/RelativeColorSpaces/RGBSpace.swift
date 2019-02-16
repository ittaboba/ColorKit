//
//  RGBSpace.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 13/02/2019.
//

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
    
    public var red: Float
    public var green: Float
    public var blue: Float
    
    public init() {
        self.red = 0.0
        self.green = 0.0
        self.blue = 0.0
    }
    
    public init(red: Float, green: Float, blue: Float) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    #if os(iOS)
        public func toColor() -> UIColor {
            let red = CGFloat(self.red)
            let green = CGFloat(self.green)
            let blue = CGFloat(self.blue)
            
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    #endif
    
    #if os(macOS)
        public func toColor() -> NSColor {
            let red = CGFloat(self.red)
            let green = CGFloat(self.green)
            let blue = CGFloat(self.blue)
            
            return NSColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
    #endif

    public func fromColor(color: CGColor) throws {
        guard let red = color.components?[0] else {
            throw RGBColorError.UndefinedRedComponent
        }
        
        guard let green = color.components?[1] else {
            throw RGBColorError.UndefinedGreenComponent
        }
        
        guard let blue = color.components?[2] else {
            throw RGBColorError.UndefinedBlueComponent
        }
        
        self.red = Float(red)
        self.green = Float(green)
        self.blue = Float(blue)
    }
}


