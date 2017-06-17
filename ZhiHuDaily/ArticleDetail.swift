//
//  ArticleDetail.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/13.
//  Copyright © 2017年 vivian. All rights reserved.
//

import ObjectMapper

class ArticleDetail: Mappable{
    var body : String?
    var image_source : String?
    var title : String?
    var image : String?
    var share_url : String?
    var js : [String]?
    var ga_prefix : String?
    var images : [String]?
    var type : Int!
    var id : Int!
    var css : [String]?
    
    required init?(map: Map) {
      
    }
    
    func mapping(map: Map) {
        body <- map["body"]
        image_source <- map["image_source"]
        title <- map["title"]
        image <- map["image"]
        share_url <- map["share_url"]
        js <- map["js"]
        ga_prefix <- map["ga_prefix"]
        images <- map["images"]
        type <- map["type"]
        id <- map["id"]
        css <- map["css"]
    }
}
