//
//  JYTagViewCell.swift
//  JYTagView
//
//  Created by 张建宇 on 16/4/4.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class JYTagViewCell: UIView {
  
    var identifier:String?
    
    var textLabel:UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    convenience init(identifier: String) {
        self.init()
        backgroundColor = .white
        self.identifier = identifier
        self.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = self.bounds
    }
}

