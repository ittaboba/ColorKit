//
//  ColorSpace.swift
//  ExampleApp_iOS
//
//  Created by Lorenzo Bernaschina on 23/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

public class ColorSpace {
    
    private var mediator: ColorSpaceMediator
    
    public init(mediator: ColorSpaceMediator) {
        self.mediator = mediator
    }
    
    public func changed() {
        self.mediator.colorSpaceChanged(c: self)
    }
}
