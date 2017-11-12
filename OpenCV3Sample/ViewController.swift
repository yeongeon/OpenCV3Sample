//
//  ViewController.swift
//  OpenCV3Sample
//
//  Created by  yeongeon on 11/11/2017.
//  Copyright © 2017  yeongeon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var canvas: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let t = OpenCVWrapper()
        let v:String = t.openCVVersionString()
        let i:Int = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

