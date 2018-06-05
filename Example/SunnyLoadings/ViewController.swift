//
//  ViewController.swift
//  SunnyLoadings
//
//  Created by ShennyO on 06/04/2018.
//  Copyright (c) 2018 ShennyO. All rights reserved.
//

import UIKit
import SunnyLoadings


class ViewController: UIViewController {

    var loader: Loader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 81/255, green: 181/255, blue: 255, alpha: 1)
        loader = Loader(vc: self)
        loader.animateBaseViewLayers(x: self.view.bounds.midX, y: self.view.bounds.midY, size: self.view.bounds.width * 0.3)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.loader.stopAllAnimations(result: .success)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

