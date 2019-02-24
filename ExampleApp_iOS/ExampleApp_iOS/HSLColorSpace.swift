//
//  HSLColorSpace.swift
//  ExampleApp_iOS
//
//  Created by Lorenzo Bernaschina on 23/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import ColorKit

public class HSLColorSpace: ColorSpace {
    
    private let name = "HSL"
    
    private var colorSpace: HSLSpace
    
    public override init(mediator: ColorSpaceMediator) {
        self.colorSpace = HSLSpace()
        super.init(mediator: mediator)
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func colorSpaceUpdate(space: HSLSpace) {
        self.colorSpace = space
        self.changed()
    }
    
    public func setColorSpaceFrom(space: RGBSpace) {
        self.colorSpace.fromRGBSpace(space: space)
    }
    
    public func getColorSpace() -> HSLSpace {
        return self.colorSpace
    }
}
