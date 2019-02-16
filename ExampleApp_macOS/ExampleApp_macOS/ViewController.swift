//
//  ViewController.swift
//  ExampleApp_macOS
//
//  Created by Lorenzo Bernaschina on 16/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import Cocoa
import ColorKit

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = true
        let c = RGBSpace(red: 10/255, green: 30/255, blue: 100/255)
        self.view.layer?.backgroundColor = c.toColor().cgColor
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

