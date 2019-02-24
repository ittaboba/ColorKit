//
//  LMSColorSpace.swift
//  ExampleApp_iOS
//
//  Created by Lorenzo Bernaschina on 24/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import ColorKit

public class LMSColorSpace: ColorSpace {
    
    private let name = "LMS"
    
    private var colorSpace: LMSSpace
    
    public override init(mediator: ColorSpaceMediator) {
        self.colorSpace = LMSSpace()
        super.init(mediator: mediator)
    }
    
    public func getName() -> String {
        return self.name
    }
    
    public func colorSpaceUpdate(space: LMSSpace) {
        self.colorSpace = space
        self.changed()
    }
    
    public func setColorSpaceFrom(space: RGBSpace) {
        self.colorSpace.fromRGBSpace(space: space)
    }
    
    public func getColorSpace() -> LMSSpace {
        return self.colorSpace
    }
}

