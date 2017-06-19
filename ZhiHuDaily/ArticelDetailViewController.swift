//
//  ArticelDetailViewController.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/13.
//  Copyright © 2017年 vivian. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ArticleDetailViewController: UIViewController{
    var id: Int = 0
    var width : CGFloat = 0
    var height : CGFloat = 0
    let webView = UIWebView()
    
    override func viewDidLoad() {
        //监测横竖屏切换
        NotificationCenter.default.addObserver(self, selector: #selector(didChangeOrientation), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "分享", style: UIBarButtonItemStyle.plain, target: self, action: #selector(ArticleDetailViewController.share))
        
        webView.frame = CGRect(x:0,y:0,width:self.view.frame.width,height: self.view.frame.height)
        
        let url="https://news-at.zhihu.com/api/4/news/\(id)"
//        let requestURL:URL = URL(string:url)!
//        let request = URLRequest(url:requestURL)
        
        Alamofire.request(url,method: .get).responseString{
            response in
            
            if let JSON = response.result.value {
                let articleDetail = Mapper<ArticleDetail>().map(JSONString: JSON)
//                let css = "http://ob9iws2up.bkt.clouddn.com/css/share.css"
                                let css = "https://daily.zhihu.com/css/share.css?v=5956a"
                //                let css = articleDetail?.css![0] //css和现在的不符合，现在手动改成网页引用的css地址
//                let css = "https://daily.zhihu.com/css/share.css?v=5956a"

                let head =  "<html lang=\"zh-CN\"><head>\n" +
                    "<meta charset=\"utf-8\"><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\"><meta name=\"viewport\" content=\"user-scalable=no, width=device-width\"><link rel=\"stylesheet\" href=\"" + css + "\">\n" +
                "</head><body>"
                
                let title =  "<div class=\"main-wrap content-wrap\"><div class=\"headline\"><div class=\"img-wrap\"><h1 class=\"headline-title\">" +
                    (articleDetail?.title)!
             
                let image =
                    "</h1><img src=\"" +
                    (articleDetail?.image)!
                    + "\" alt=\"\"><div class=\"img-mask\"></div></div></div>"
                
                let top = head + title + image
                
                var content = articleDetail?.body!
                
                 content = content?.replacingOccurrences(of: "<div class=\"main-wrap content-wrap\">", with: " ")
                 content =  content?.replacingOccurrences(of: "<div class=\"headline\">", with: " ")
                 content =  content?.replacingOccurrences(of: "<div class=\"img-place-holder\">", with: " ")
                
//                content = content! + "<script src=\"http://static.daily.zhihu.com/js/jquery.1.9.1.js\"></script><script src=\"/js/share.js?v=49768\"></script>"
                content = content! + "</body>"
                
                let article = top + content!
               
                self.webView.load(article.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, mimeType: "text/html", textEncodingName: "utf-8", baseURL: NSURL() as URL)
            }
        }
        
        webView.backgroundColor = UIColor.gray
        
        self.view.addSubview(webView)
    }
    
    //监测方向变化
    func didChangeOrientation() {
        if (UIDevice.current.orientation == .portrait) {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.transform = .identity
                self.webView.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.view.transform = .identity
                self.webView.frame = CGRect(x: 0, y: 0, width: self.height, height: self.width)
            })
        }
        self.webView.reload()
    }
    
    public func setId(id: Int){
        self.id = id
    }
}
