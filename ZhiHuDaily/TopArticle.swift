//
//  TopArticle.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/10.
//  Copyright © 2017年 vivian. All rights reserved.
//

import ObjectMapper

class TopArticle: BaseModel{
    
    /**"image":"http://pic1.zhimg.com/85b07dd65e509a12ffc6f30fc9947e04.jpg",
     "type": 0,
     "id": 9204386,
     "ga_prefix": "020918",
     "title": "「能活多久」这件事是由什么决定的？"
     */
    var image : String?
    var type : Int!
    var id : Int!
    var ga_prefix : String?
    var title : String?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    /// This function is where all variable mappings should occur. It is executed by Mapper during the mapping (serialization and deserialization) process.
    public override func mapping(map: Map) {
        super.mapping(map: map)
        image <- map["image"]
        type <- map["type"]
        id <- map["id"]
        ga_prefix <- map["ga_prefix"]
        title <- map["title"]
    }
}

