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
        
        let file = Bundle.main.path(forResource: "tags", ofType: "json")
        
        let dataArr = NSArray(contentsOfFile: file!)
        
        for data in dataArr! {
            let model = JYTagModel.tag(dict: data as! [String : AnyObject])
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
        
        var cell:JYTagViewCell? = tagsView.dequeueReusableCellWithIdentifier(identifier: self.identifier)
        
        if cell == nil {
            cell = JYTagViewCell.init(identifier: self.identifier)
        }
        cell?.textLabel.text = self.tagModels[index].tagname
        return cell!
        
    }
    
    //@optional
    func headerViewInTagView(tagView:JYTagView) -> UIView{
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        
        label.backgroundColor = .lightGray
        
        label.textColor = .white
        
        label.textAlignment = .center
        
        label.text = "我是头视图"
        
        return label
    }
    
    func footerViewInTagView(tagView:JYTagView) -> UIView{
        
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 50))
        
        label.backgroundColor = .gray
        
        label.textColor = .white
        
        label.textAlignment = .center
        
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
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = text
        label.sizeToFit()
        let width = label.frame.maxX
        return width
    }
    
    //optional
    func tagView(tagView:JYTagView, didSelectAtIndex index:NSInteger){
     
        
        let model = self.tagModels[index]
        
        if #available(iOS 8.0, *) {
            let alertView = UIAlertController.init(title: "提示", message: "点击了\(model.tagname!)", preferredStyle:.alert)
            let cancelAction = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
            
            alertView.addAction(cancelAction)
            
            self.present(alertView, animated: true, completion: nil)
        } else {
            // Fallback on earlier versions
        }        
    }
    
    func tagView(tagView:JYTagView, maginForType type:JYTagviewMarginType){
    
    }



}


