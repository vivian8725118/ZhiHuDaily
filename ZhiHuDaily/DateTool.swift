//
//  DateTool.swift
//  WebViewDemo
//
//  Created by vivian on 2017/2/14.
//  Copyright © 2017年 vivian. All rights reserved.
//

import Foundation
class DateTool{
    static func stringToTimeStamp(stringTime:String)->String {
        
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyyMMdd"
        let date = dfmatter.date(from: stringTime)
        
        let dateStamp:TimeInterval = date!.timeIntervalSince1970
        
        let dateSt:Int = Int(dateStamp)
        print(dateSt)
        return String(dateSt)
    
    }
    
    static func timeStampToString(timeStamp:String)->String {
        
        let string = String(timeStamp)
        
        let timeSta:TimeInterval = Double(string!)!
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyyMMdd"
        
        let date = Date(timeIntervalSince1970: timeSta)
        
        print(dfmatter.string(from: date))
        return dfmatter.string(from: date)
    }
}
