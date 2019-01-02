//
//  ColorSystemConverter.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 02/01/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import Foundation
import UIKit

internal let maxRedValue: CGFloat = 1.0
internal let maxGreenValue: CGFloat = 1.0
internal let maxBlueValue: CGFloat = 1.0

internal enum RGBColorError: Error {
    case InvalidRed
    case InvalidGreen
    case InvalidBlue
    
    case UndefinedRed
    case UndefinedGreen
    case UndefinedBlue
}

internal protocol Convertible {
    func fromRGBColor(color: UIColor) throws
    func toRGBColor() -> UIColor
}

// extension for getting color components
extension UIColor {
    public var rgbColorComponent: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        guard let components = self.cgColor.components else { return nil }
        
        return (
            red: components[0],
            green: components[1],
            blue: components[2],
            alpha: components[3]
        )
    }
}
