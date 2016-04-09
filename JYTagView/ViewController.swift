//
//  ViewController.swift
//  JYTagView
//
//  Created by 张建宇 on 16/4/3.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,JYTagviewDataSource ,JYTagviewDelegate{

    var tagsView = JYTagView()
    
    var tagModels = [JYTagModel]()
    
    let identifier = "myIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsView.frame = view.bounds
        tagsView.delegate_JY = self
        tagsView.dataSource_JY = self
        view.addSubview(tagsView)
        
        let file = NSBundle.mainBundle().pathForResource("tags", ofType: "json")
        
        let dataArr = NSArray(contentsOfFile: file!)
        
        for data in dataArr! {
            let model = JYTagModel.tag(data as! [String : AnyObject])
            self.tagModels.append(model)
        }
        tagsView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension ViewController {
    
    func numberOfCellsInTagView(tagView:JYTagView) -> Int{
        
        return self.tagModels.count

    }
    
    func tagView(tagView:JYTagView, cellAtIndex index:Int) -> JYTagViewCell{
        
        var cell:JYTagViewCell? = tagsView.dequeueReusableCellWithIdentifier(self.identifier)
        
        if cell == nil {
            cell = JYTagViewCell.init(identifier: self.identifier)
        }
        cell?.textLabel.text = self.tagModels[index].tagname
        return cell!
        
    }
    
    //@optional
    func headerViewInTagView(tagView:JYTagView) -> UIView{
        
        let label = UILabel.init(frame: CGRectMake(0, 0, self.view.bounds.width, 50))
        
        label.backgroundColor = UIColor.lightGrayColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.textAlignment = .Center
        
        label.text = "我是头视图"
        
        return label
    }
    
    func footerViewInTagView(tagView:JYTagView) -> UIView{
        
        let label = UILabel.init(frame: CGRectMake(0, 0, self.view.bounds.width, 50))
        
        label.backgroundColor = UIColor.grayColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.textAlignment = .Center
        
        label.text = "我是尾视图"
        
        return label
        
    }
    
    
    func tagView(tagView:JYTagView, heightForRowInIndex index:NSInteger) -> CGFloat{
    
        return CGFloat(25)
    }
    
    func tagView(tagView:JYTagView, widthForRowInIndex index:NSInteger) -> CGFloat{
        
        let text:String = self.tagModels[index].tagname!
        
//        boundingRectWithSize
        
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(15)
        label.text = text
        label.sizeToFit()
        let width =  CGRectGetMaxX(label.frame)
        return width
    }
    
    //optional
    func tagView(tagView:JYTagView, didSelectAtIndex index:NSInteger){
     
        
        let model = self.tagModels[index]
        
        let alertView = UIAlertController.init(title: "提示", message: "点击了\(model.tagname!)", preferredStyle:.Alert)

        let cancelAction = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        
        alertView.addAction(cancelAction)
        
        self.presentViewController(alertView, animated: true, completion: nil)
        
    }
    
    func tagView(tagView:JYTagView, maginForType type:JYTagviewMarginType){
    
    }



}


