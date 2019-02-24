//
//  LMSColor.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 02/01/2019.
//

import simd

public class LMSSpace: RelativeSpace {
    
    // The Hunt and RLAB color appearance models use the Hunt-Pointer-Estevez chromatic adaptation transform matrix normalized to D65
    private let HPEMatrix = simd_float3x3(rows:[
        simd_float3(0.4002, 0.7076, -0.0808),
        simd_float3(-0.2263, 1.1653, 0.0457),
        simd_float3(0, 0, 0.9182)
    ])
    
    private var long: Float
    private var medium: Float
    private var short: Float
    
    public init() {
        self.long = 0.0
        self.medium = 0.0
        self.short = 0.0
    }
    
    public init(long: Float, medium: Float, short: Float) {
        self.long = long
        self.medium = medium
        self.short = short
    }
    
    public func fromRGBSpace(space: RGBSpace) {
        let sRGB = sRGBProfile()
        let XYZ = sRGB.fromRGBtoXYZ(space: space)
        let XYZVector = float3(XYZ.X, XYZ.Y, XYZ.Z)
        let LMSVector = self.HPEMatrix * XYZVector
        
        self.long = LMSVector.x
        self.medium = LMSVector.y
        self.short = LMSVector.z
    }
    
    public func toRGBSpace() -> RGBSpace {
        let LMSVector = float3(self.long, self.medium, self.short)
        let XYZVector = self.HPEMatrix.inverse * LMSVector
        let XYZ = XYZSpace(X: XYZVector.x, Y: XYZVector.y, Z: XYZVector.z)
        
        let sRGB = sRGBProfile()
        let RGB = sRGB.fromXYZtoRGB(space: XYZ)
        
        return RGB
    }
    
    public func getLong() -> Float {
        return self.long
    }
    
    public func getMedium() -> Float {
        return self.medium
    }
    
    public func getShort() -> Float {
        return self.short
    }
}
