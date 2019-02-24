//
//  ColorSpaceMediator.swift
//  ExampleApp_iOS
//
//  Created by Lorenzo Bernaschina on 23/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

public protocol ColorSpaceMediator {
    func colorSpaceChanged(c: ColorSpace)
}

public class ColorSpaceManager: ColorSpaceMediator {
    
    private var rgbColorSpace: RGBColorSpace!
    private var rybColorSpace: RYBColorSpace!
    private var hsvColorSpace: HSVColorSpace!
    private var hslColorSpace: HSLColorSpace!
    
    public func createColorSpaces() {
        self.rgbColorSpace = RGBColorSpace(mediator: self)
        self.rybColorSpace = RYBColorSpace(mediator: self)
        self.hsvColorSpace = HSVColorSpace(mediator: self)
        self.hslColorSpace = HSLColorSpace(mediator: self)
    }
    
    public func colorSpaceChanged(c: ColorSpace) {
        switch c {
        case is RGBColorSpace:
            let rgbSpace = self.rgbColorSpace.getColorSpace()
            self.rybColorSpace.setColorSpaceFrom(space: rgbSpace)
            self.hsvColorSpace.setColorSpaceFrom(space: rgbSpace)
            self.hslColorSpace.setColorSpaceFrom(space: rgbSpace)
        case is RYBColorSpace:
            let rgbSpace = self.rybColorSpace.getColorSpace().toRGBSpace()
            self.rgbColorSpace.setColorSpaceFrom(space: rgbSpace)
            self.hsvColorSpace.setColorSpaceFrom(space: rgbSpace)
            self.hslColorSpace.setColorSpaceFrom(space: rgbSpace)
        case is HSVColorSpace:
            let rgbSpace = self.hsvColorSpace.getColorSpace().toRGBSpace()
            self.rgbColorSpace.setColorSpaceFrom(space: rgbSpace)
            self.rybColorSpace.setColorSpaceFrom(space: rgbSpace)
            self.hslColorSpace.setColorSpaceFrom(space: rgbSpace)
        case is HSLColorSpace:
            let rgbSpace = self.hslColorSpace.getColorSpace().toRGBSpace()
            self.rgbColorSpace.setColorSpaceFrom(space: rgbSpace)
            self.rybColorSpace.setColorSpaceFrom(space: rgbSpace)
            self.hsvColorSpace.setColorSpaceFrom(space: rgbSpace)
        default:
            break
        }
    }
    
    public func getRgbColorSpace() -> RGBColorSpace {
        return self.rgbColorSpace
    }
    
    public func getRybColorSpace() -> RYBColorSpace {
        return self.rybColorSpace
    }
    
    public func getHsvColorSpace() -> HSVColorSpace {
        return self.hsvColorSpace
    }
    
    public func getHslColorSpace() -> HSLColorSpace {
        return self.hslColorSpace
    }
    
}
