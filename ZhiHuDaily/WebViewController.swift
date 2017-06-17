//
//  WebViewController.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/7.
//  Copyright © 2017年 vivian. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate{
    var id: Int = 0
 
    override func viewWillAppear(_ animated: Bool) {
      
    }
    override func viewDidLoad() {    
        let webView = UIWebView()
    
        webView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height: UIScreen.main.bounds.height)
        
        let url="https://dudu.zhihu.com/story/\(id)"
        let requestURL:URL = URL(string:url)!
        let request = URLRequest(url:requestURL)
        
        webView.loadRequest(request)
        webView.backgroundColor = UIColor.gray
        
        self.view.addSubview(webView)
    }
    
    public func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    public func setId(id: Int){
        self.id = id
    }
}
