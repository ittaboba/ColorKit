//
//  ViewController.swift
//  ExampleApp_iOS
//
//  Created by Lorenzo Bernaschina on 16/02/2019.
//  Copyright © 2019 Lorenzo Bernaschina. All rights reserved.
//

import UIKit
import ColorKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let c = RGBSpace(red: 20/255, green: 30/255, blue: 100/255)
        self.view.backgroundColor = c.toColor()
    }


}

