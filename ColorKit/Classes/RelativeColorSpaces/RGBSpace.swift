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
    
    public func toColor() -> UIColor {
        let red = CGFloat(self.red)
        let green = CGFloat(self.green)
        let blue = CGFloat(self.blue)
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
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
        
        self.red = Float(red)
        self.green = Float(green)
        self.blue = Float(blue)
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
