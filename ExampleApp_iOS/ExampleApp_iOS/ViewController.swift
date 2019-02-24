//
//  ViewController.swift
//  ExampleApp_iOS
//
//  Created by Lorenzo Bernaschina on 16/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import UIKit
import ColorKit

let cellIdentifier = "cellIdentifier"

class CustomCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField3: UITextField!
    @IBOutlet weak var imgView: UIImageView!
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var manager = ColorSpaceManager()
    private var rgbColorSpace: RGBColorSpace
    private var rybColorSpace: RYBColorSpace
    private var hsvColorSpace: HSVColorSpace
    private var hslColorSpace: HSLColorSpace
    private var lmsColorSpace: LMSColorSpace
    
    private var colorSpaces: [ColorSpace]
    
    required init?(coder aDecoder: NSCoder) {
        
        self.manager.createColorSpaces();
        self.rgbColorSpace = self.manager.getRgbColorSpace()
        self.rybColorSpace = self.manager.getRybColorSpace()
        self.hsvColorSpace = self.manager.getHsvColorSpace()
        self.hslColorSpace = self.manager.getHslColorSpace()
        self.lmsColorSpace = self.manager.getLmsColorSpace()
        
        self.colorSpaces = [self.rgbColorSpace,
                            self.rybColorSpace,
                            self.hsvColorSpace,
                            self.hslColorSpace,
                            self.lmsColorSpace]
        
        super.init(coder: aDecoder)
    }
    
    private func userChangedRgbValues(r: Float, g: Float, b: Float) {
        self.rgbColorSpace.colorSpaceUpdate(space: RGBSpace(red: r, green: g, blue: b))
    }
    
    private func userChangedRybValues(r: Float, y: Float, b: Float) {
        self.rybColorSpace.colorSpaceUpdate(space: RYBSpace(red: r, yellow: y, blue: b))
    }
    
    private func userChangedHsvValues(h: Float, s: Float, v: Float) {
        self.hsvColorSpace.colorSpaceUpdate(space: HSVSpace(hue: h, saturation: s, value: v))
    }
    
    private func userChangedHslValues(h: Float, s: Float, l: Float) {
        self.hslColorSpace.colorSpaceUpdate(space: HSLSpace(hue: h, saturation: s, lightness: l))
    }
    
    private func userChangedLmsValues(l: Float, m: Float, s: Float) {
        self.lmsColorSpace.colorSpaceUpdate(space: LMSSpace(long: l, medium: m, short: s))
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let pointInTableView = textField.convert(textField.bounds.origin, to: self.tableView)
        guard let indexPath = self.tableView.indexPathForRow(at: pointInTableView) else {
            return
        }
        
        let cell = self.tableView.cellForRow(at: indexPath) as! CustomCell
        guard let v1 = cell.textField1.text else {
            return
        }
        guard let v2 = cell.textField2.text else {
            return
        }
        guard let v3 = cell.textField3.text else {
            return
        }
        
        let value1 = (v1 as NSString).floatValue
        let value2 = (v2 as NSString).floatValue
        let value3 = (v3 as NSString).floatValue
        
        switch indexPath.row {
        case 0:
            self.userChangedRgbValues(r: value1, g: value2, b: value3)
        case 1:
            self.userChangedRybValues(r: value1, y: value2, b: value3)
        case 2:
            self.userChangedHsvValues(h: value1, s: value2, v: value3)
        case 3:
            self.userChangedHslValues(h: value1, s: value2, l: value3)
        case 4:
            self.userChangedLmsValues(l: value1, m: value2, s: value3)
        default:
            break
        }
        
        self.tableView.reloadData()
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.colorSpaces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CustomCell
        
        let colorSpace = self.colorSpaces[indexPath.row]
        
        switch colorSpace {
        case is RGBColorSpace:
            let rgbColorSpace = colorSpace as! RGBColorSpace
            let rgbSpace = rgbColorSpace.getColorSpace()
            cell.title.text = rgbColorSpace.getName()
            cell.textField1.text = String(rgbSpace.red)
            cell.textField2.text = String(rgbSpace.green)
            cell.textField3.text = String(rgbSpace.blue)
            cell.imgView.backgroundColor = rgbSpace.toColor()
        case is RYBColorSpace:
            let rybColorSpace = colorSpace as! RYBColorSpace
            let rybSpace = rybColorSpace.getColorSpace()
            cell.title.text = rybColorSpace.getName()
            cell.textField1.text = String(rybSpace.red)
            cell.textField2.text = String(rybSpace.yellow)
            cell.textField3.text = String(rybSpace.blue)
            cell.imgView.backgroundColor = rybSpace.toRGBSpace().toColor()
        case is HSVColorSpace:
            let hsvColorSpace = colorSpace as! HSVColorSpace
            let hsvSpace = hsvColorSpace.getColorSpace()
            cell.title.text = hsvColorSpace.getName()
            cell.textField1.text = String(hsvSpace.hue)
            cell.textField2.text = String(hsvSpace.saturation)
            cell.textField3.text = String(hsvSpace.value)
            cell.imgView.backgroundColor = hsvSpace.toRGBSpace().toColor()
        case is HSLColorSpace:
            let hslColorSpace = colorSpace as! HSLColorSpace
            let hslSpace = hslColorSpace.getColorSpace()
            cell.title.text = hslColorSpace.getName()
            cell.textField1.text = String(hslSpace.hue)
            cell.textField2.text = String(hslSpace.saturation)
            cell.textField3.text = String(hslSpace.lightness)
            cell.imgView.backgroundColor = hslSpace.toRGBSpace().toColor()
        case is LMSColorSpace:
            let lmsColorSpace = colorSpace as! LMSColorSpace
            let lmsSpace = lmsColorSpace.getColorSpace()
            cell.title.text = lmsColorSpace.getName()
            cell.textField1.text = String(lmsSpace.long)
            cell.textField2.text = String(lmsSpace.medium)
            cell.textField3.text = String(lmsSpace.short)
            cell.imgView.backgroundColor = lmsSpace.toRGBSpace().toColor()
        default:
            break
        }
        
        return cell
    }
}
