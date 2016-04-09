//
//  JYTagModel.swift
//  JYTagView
//
//  Created by 张建宇 on 16/4/4.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class JYTagModel: NSObject {
    
    var lock:String?
    
    var tag_fatherid:String?
    
    var tagname:String?
    
    class func tag(dict:[String:AnyObject]) -> JYTagModel{
        let tag = JYTagModel()
        tag.setValuesForKeysWithDictionary(dict)
        return tag;
    }
    
    override func valueForUndefinedKey(key: String) -> AnyObject? {
        return "什么鬼~?"
    }
    
}
