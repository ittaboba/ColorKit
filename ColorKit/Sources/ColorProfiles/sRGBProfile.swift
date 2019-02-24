//
//  sRGBProfile.swift
//  ColorKit
//
//  Created by Lorenzo Bernaschina on 14/02/2019.
//
//  RGB/XYZ matrices from http://www.brucelindbloom.com/index.html?WorkingSpaceInfo.html
//

import simd

internal protocol ColorProfile {
    func fromRGBtoXYZ(space: RGBSpace) -> XYZSpace
    func fromXYZtoRGB(space: XYZSpace) -> RGBSpace
}

internal class sRGBProfile: ColorProfile {
    
    // observer = 2, illuminant = D65
    private let sRGBMatrix = simd_float3x3(rows:[
        simd_float3(0.4124564, 0.3575761, 0.1804375),
        simd_float3(0.2126729, 0.7151522, 0.0721750),
        simd_float3(0.0193339, 0.1191920, 0.9503041)
    ])
    
    init() {}
    
    func fromRGBtoXYZ(space: RGBSpace) -> XYZSpace {
        var linearRed: Float
        var linearGreen: Float
        var linearBlue: Float
        
        // remove gamma (conversion to linear space RGBLinear)
        if space.red > 0.04045 {
            linearRed = pow((space.red + 0.055)/1.055, 2.4)
        } else {
            linearRed = space.red/12.92
        }
        
        if space.green > 0.04045 {
            linearGreen = pow((space.green + 0.055)/1.055, 2.4)
        } else {
            linearGreen = space.green/12.92
        }
        
        if space.blue > 0.04045 {
            linearBlue = pow((space.blue + 0.055)/1.055, 2.4)
        } else {
            linearBlue = space.blue/12.92
        }
        
        let linearRGB = float3(linearRed, linearGreen, linearBlue)
        let XYZVector = self.sRGBMatrix * linearRGB
        
        return XYZSpace(X: XYZVector.x, Y: XYZVector.y, Z: XYZVector.z)
    }
    
    func fromXYZtoRGB(space: XYZSpace) -> RGBSpace {
        var red: Float
        var green: Float
        var blue: Float
        
        let XYZVector = float3(space.X, space.Y, space.Z)
        let linearRGB = self.sRGBMatrix.inverse * XYZVector
        
        let linearRed = linearRGB.x
        let linearGreen = linearRGB.y
        let linearBlue = linearRGB.z
        
        // apply gamma
        if linearRed > 0.0031308 {
            red = 1.055 * pow(linearRed, 1/2.4) - 0.055
        } else {
            red = 12.92 * linearRed
        }
        
        if linearGreen > 0.0031308 {
            green = 1.055 * pow(linearGreen, 1/2.4) - 0.055
        } else {
            green = 12.92 * linearGreen
        }
        
        if linearBlue > 0.0031308 {
            blue = 1.055 * pow(linearBlue, 1/2.4) - 0.055
        } else {
            blue = 12.92 * linearBlue
        }
        
        return RGBSpace(red: red, green: green, blue: blue)
    }
    
    
}
