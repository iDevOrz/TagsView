//
//  UIImage+RoundedCorner.swift
//  JYTagView
//
//  Created by 张建宇 on 16/4/7.
//  Copyright © 2016年 张建宇. All rights reserved.
//  TODO

import UIKit

struct Radius {
    var topLeftRadius:CGFloat = 0.0
    var topRightRadius:CGFloat = 0.0
    var bottomLeftRadius:CGFloat = 0.0
    var bottomRightRadius:CGFloat = 0.0
}

extension UIImage{

    func imageWithSize(size:CGSize,radius:CGFloat) -> UIImage {
        
        
        return self
    }
    
    func imageWithSize(size:CGSize, radius:CGFloat, contentMode:UIView.ContentMode) -> UIImage {
        
        return self
    }

    class func imageWithSize(sizeToFit:CGSize, radius:CGFloat, borderColor:UIColor, borderWidth:CGFloat) -> UIImage{
        
        return self.init()
    }
    
    class func imageWithSize(size:CGSize, radius:CGFloat, borderColor:UIColor) -> UIImage{
        
        return self.init()
    }
    
    class func imageWithSize(size:CGSize, radius:CGFloat, borderColor:UIColor, borderWidth:CGFloat, backgroundColor:UIColor, backgroundImage:UIImage, contentMode:UIView.ContentMode) -> UIImage{
        
        return self.init()
    }
    
    class func imageWithSize(size:CGSize,radius:Radius, borderColor:UIColor, borderWidth:CGFloat, backgroundColor:UIColor, backgroundImage:UIImage, contentMode:UIView.ContentMode) -> UIImage{
        
        return self.init()
    }

}
