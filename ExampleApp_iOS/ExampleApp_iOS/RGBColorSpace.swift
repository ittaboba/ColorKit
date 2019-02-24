//
//  RGBColorSpace.swift
//  ExampleApp_iOS
//
//  Created by Lorenzo Bernaschina on 23/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import ColorKit

public class RGBColorSpace: ColorSpace {
    
    private let name = "RGB"
    
    private var colorSpace: RGBSpace
    
    public override init(mediator: ColorSpaceMediator) {
        self.colorSpace = RGBSpace()
        super.init(mediator: mediator)
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func colorSpaceUpdate(space: RGBSpace) {
        self.colorSpace = space
        self.changed()
    }
    
    public func setColorSpaceFrom(space: RGBSpace) {
        self.colorSpace = space
    }
    
    public func getColorSpace() -> RGBSpace {
        return self.colorSpace
    }
    
}
