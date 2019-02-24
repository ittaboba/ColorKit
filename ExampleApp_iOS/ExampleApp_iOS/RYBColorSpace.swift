//
//  RYBColorSpace.swift
//  ExampleApp_iOS
//
//  Created by Lorenzo Bernaschina on 23/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import ColorKit

public class RYBColorSpace: ColorSpace {
    
    private let name = "RYB"
    
    private var colorSpace: RYBSpace
    
    public override init(mediator: ColorSpaceMediator) {
        self.colorSpace = RYBSpace()
        super.init(mediator: mediator)
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func colorSpaceUpdate(space: RYBSpace) {
        self.colorSpace = space
        self.changed()
    }
    
    public func setColorSpaceFrom(space: RGBSpace) {
        self.colorSpace.fromRGBSpace(space: space)
    }
    
    public func getColorSpace() -> RYBSpace {
        return self.colorSpace
    }
}
