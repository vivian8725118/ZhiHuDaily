//
//  Article.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/9.
//  Copyright © 2017年 vivian. All rights reserved.
//
import ObjectMapper


class Article: BaseModel{
    
    /**"images": [
     "http://pic1.zhimg.com/85b07dd65e509a12ffc6f30fc9947e04.jpg"
     ],
     "type": 0,
     "id": 9204386,
     "ga_prefix": "020918",
     "title": "「能活多久」这件事是由什么决定的？"
*/
    var images : [String]?
    var type : Int!
    var id : Int!
    var ga_prefix : String?
    var title : String?

    required init?(map: Map) {
       super.init(map: map)
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)
        images <- map["images"]
        type <- map["type"]
        id <- map["id"]
        ga_prefix <- map["ga_prefix"]
        title <- map["title"]
    }
}
