//
//  BaseModel.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/10.
//  Copyright © 2017年 vivian. All rights reserved.
//

import ObjectMapper


class BaseModel: Mappable {
    var date : String?
    var stories : [Article]?
    var top_stories : [TopArticle]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        date <- map["date"]
        stories <- map["stories"]
        top_stories <- map["top_stories"]
    }
}
