//
//  xyYSpace.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 14/02/2019.
//


internal class xyYSpace: AbsoluteSpace {
    
    public var x: Float
    public var y: Float
    public var Y: Float
    
    init() {
        self.x = 0.0
        self.y = 0.0
        self.Y = 0.0
    }
    
    init(x: Float, y: Float, Y: Float) {
        self.x = x
        self.y = y
        self.Y = Y
    }
    
    func fromXYZSpace(space: XYZSpace) {
        self.Y = space.Y
        self.x = space.X/(space.X + space.Y + space.Z)
        self.y = space.Y/(space.X + space.Y + space.Z)
    }
    
    func toXYZSpace() -> XYZSpace {
        let X = self.x * (self.Y/self.y)
        let Y = self.Y
        let Z = (1 - self.x - self.y) * (self.Y/self.y)
        
        return XYZSpace(X: X, Y: Y, Z: Z)
    }
    
    
}
