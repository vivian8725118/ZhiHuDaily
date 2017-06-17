//
//  BaseViewController.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/10.
//  Copyright © 2017年 vivian. All rights reserved.
//
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let red = arc4random_uniform(255);
        let green = arc4random_uniform(255);
        let blue = arc4random_uniform(255);
        
        self.view.backgroundColor = UIColor.init(colorLiteralRed: Float(red) / 255.0, green: Float(green) / 255.0, blue: Float(blue) / 255.0, alpha: 1.0)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
