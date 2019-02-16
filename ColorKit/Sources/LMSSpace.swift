//
//  LMSColor.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 02/01/2019.
//

import Foundation

public class LMSSpace {
    
    public var long: CGFloat
    public var medium: CGFloat
    public var short: CGFloat
    
    public init() {
        self.long = 0.0
        self.medium = 0.0
        self.short = 0.0
    }
    
    public init(long: CGFloat, medium: CGFloat, short: CGFloat) {
        self.long = long
        self.medium = medium
        self.short = short
    }
    
}
