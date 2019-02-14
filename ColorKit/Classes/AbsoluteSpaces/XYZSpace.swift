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

public class XYZSpace {
    
    public var x: CGFloat
    public var y: CGFloat
    public var z: CGFloat
    
    public init() {
        self.x = 0.0
        self.y = 0.0
        self.z = 0.0
    }
    
    public init(x: CGFloat, y: CGFloat, z: CGFloat) {
        self.x = x
        self.y = y
        self.z = z
    }
    
}
