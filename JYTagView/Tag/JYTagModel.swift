//
//  JYTagModel.swift
//  JYTagView
//
//  Created by 张建宇 on 16/4/4.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class JYTagModel: NSObject {
    
    @objc var lock:String?
    
    @objc var tag_fatherid:String?
    
    @objc var tagname:String?
    
    class func tag(dict:[String:AnyObject]) -> JYTagModel{
        let tag = JYTagModel()
        tag.setValuesForKeys(dict)
        return tag;
    }
    
    override func value(forUndefinedKey key: String) -> Any? {
        return "什么鬼~?"
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }
    
}
