//
//  XYZSpace.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 13/02/2019.
//


internal protocol AbsoluteSpace {
    func fromXYZSpace(space: XYZSpace)
    func toXYZSpace() -> XYZSpace
}

internal class XYZSpace {
    public var X: Float
    public var Y: Float
    public var Z: Float
    
    init() {
        self.X = 0.0
        self.Y = 0.0
        self.Z = 0.0
    }
    
    public init(X: Float, Y: Float, Z: Float) {
        self.X = X
        self.Y = Y
        self.Z = Z
    }
    
}
