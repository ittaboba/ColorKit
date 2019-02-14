//
//  XYZSpace.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 13/02/2019.
//

import Foundation

internal protocol AbsoluteSpace {
    func fromXYZSpace(space: XYZSpace)
    func toXYZSpace() -> XYZSpace
}

internal class XYZSpace {
    
    public var X: CGFloat
    public var Y: CGFloat
    public var Z: CGFloat
    
    public init() {
        self.X = 0.0
        self.Y = 0.0
        self.Z = 0.0
    }
    
    public init(X: CGFloat, Y: CGFloat, Z: CGFloat) {
        self.X = X
        self.Y = Y
        self.Z = Z
    }
    
}
