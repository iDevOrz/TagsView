//
//  JYTagView.swift
//  JYTagView
//
//  Created by 张建宇 on 16/4/4.
//  Copyright © 2016年 张建宇. All rights reserved.
//

import UIKit

public enum JYTagviewMarginType : Int {
    case Top
    case Bottom
    case Left
    case Right
    case Row
    case Column
};

protocol JYTagviewDataSource :NSObjectProtocol{
    
    func numberOfCellsInTagView(tagView:JYTagView) -> Int
    
    func tagView(tagView:JYTagView, cellAtIndex index:Int) -> JYTagViewCell
    
    //@optional
    func headerViewInTagView(tagView:JYTagView) -> UIView
    
    func footerViewInTagView(tagView:JYTagView) -> UIView
    
}

protocol JYTagviewDelegate :UIScrollViewDelegate{
    
    func tagView(tagView:JYTagView, heightForRowInIndex index:NSInteger) -> CGFloat
    
    func tagView(tagView:JYTagView, widthForRowInIndex index:NSInteger) -> CGFloat
    
    //optional
    func tagView(tagView:JYTagView, didSelectAtIndex index:NSInteger)
    
    func tagView(tagView:JYTagView, maginForType type:JYTagviewMarginType)
    
}


class JYTagView: UIScrollView {
    
        /// 左右间距最小值
    let kJYTagMinLeftMargin:CGFloat = 15;
        /// 行上下间距
    let kJYTagTopRowMargin:CGFloat = 10;
        /// 每个cell之间 左右的间距
    let kJYTagMiddleMargin:CGFloat = 10;
        /// 每个cell额外加的宽度
    let kJYTagCellExteraWidth:CGFloat = 10;
        /// 默认的cell高度
    let kJYTagviewDefaultCellHeight:CGFloat = 15;
        /// 默认的cell宽度
    let kJYTagviewDefaultCellWidth:CGFloat = 100;
        /// 尾视图间距
    let kJYFooterViewMargin:CGFloat = 20;
    
    /**  存放所有的frame*/
    var cellFrames = [CGRect]()
    /**存放正在展示的cell*/
    var displayingCells = [Int:JYTagViewCell]()
    /** 自定义的缓存池*/
    var reusableCells:Set = Set<JYTagViewCell>()
    
    var mainScreenSize = UIScreen.main.bounds.size
    
    var cellNumbers:NSInteger = 0
    
    weak var dataSource_JY: JYTagviewDataSource?
    
    weak var delegate_JY: JYTagviewDelegate?
        
    func reloadData(){
        self.cellFrames.removeAll()
        self.displayingCells.removeAll()
        self.reusableCells.removeAll()
        
        let headerView = self.headerViewInTagview()
        let footerView = self.footerViewInTagview()
        self.cellNumbers = (self.dataSource_JY?.numberOfCellsInTagView(tagView: self))!
        
        self.caculateWithNumberOfCells(count: self.cellNumbers, headerView: headerView, footerView: footerView)
        if headerView != nil {
            self.addSubview(headerView!)
        }
        
        if footerView != nil {
            self.addSubview(footerView!)
        }
        
    }
    
    private func caculateWithNumberOfCells(count:Int, headerView:UIView?, footerView:UIView?){
            /// 行数
        var numberOfRows = 0
            /// 用来存放cell 的宽度
        var tmpArr = [CGFloat]()
            /// 每一行最大的X 换行置0
        var maxX:CGFloat = 0.0
            /// cell高度
        let cellH = self.heightAtIndex(index: 0)
            /// 有效宽度
        let effectiveW = self.mainScreenSize.width - 2 * kJYTagMinLeftMargin
            /// 每一行开始的位置
        var beginR = 0
            /// 每一行结束的位置
        var endR = 0

        let headerViewH:CGFloat = {
            if headerView != nil {
                return headerView!.frame.height
            }
            return 0.0
        }()
        
        let footerViewH:CGFloat = {
            if footerView != nil {
                return footerView!.frame.height
            }
            return 0.0
        }()
        
        for i in 0...(count - 1) {
            
            let textW = self.widthAtIndex(index: i)
            
            if i == 0 {
            
                maxX = (textW + kJYTagCellExteraWidth) + maxX
            
            } else {
            
                maxX = (textW + kJYTagCellExteraWidth) + maxX + kJYTagMiddleMargin
            
            }
        
            
            tmpArr.append((textW + kJYTagCellExteraWidth))
            
            if maxX > effectiveW {
                
                endR = i - 1
                
                let realW:CGFloat = maxX - (textW + kJYTagCellExteraWidth + kJYTagMiddleMargin)
                
                let leftMargin = (effectiveW - realW ) / 2.0
                
                for j in beginR ... endR{
                    let cellW = tmpArr[j]
                    
                    var cellX:CGFloat = 0.0
                    
                    if j == beginR {
                        
                        cellX = leftMargin + kJYTagMiddleMargin
                        
                    } else {
                        
                        let frame = self.cellFrames[j - 1]
                        
                        cellX = kJYTagMiddleMargin + frame.maxX
                        
                    }
                    
                    let cellY = kJYTagTopRowMargin + (cellH + kJYTagTopRowMargin) * CGFloat(numberOfRows) + headerViewH
                    
                    let frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
                    self.cellFrames.append(frame)
                }

                beginR = i
                
                numberOfRows = numberOfRows + 1
                
                maxX = textW + kJYTagCellExteraWidth
                
            }
            
        }
        
        
        if headerView != nil {

        var headerViewFrame = headerView!.frame
        
        headerViewFrame.origin = .zero
        
        if headerViewFrame.size.width > self.mainScreenSize.width {
            let h = self.mainScreenSize.width * headerViewFrame.size.height / headerViewFrame.size.width
            headerViewFrame.size = CGSize(width: self.mainScreenSize.width,height: h)
        } else {
            let margin = (self.mainScreenSize.width - headerViewFrame.size.width) / 2
            headerViewFrame.origin = CGPoint(x: margin,y: 0)
        }
        
        headerView!.frame = headerViewFrame
        }
        
        
        var contenH = CGFloat(numberOfRows) * (kJYTagTopRowMargin + cellH) + headerViewH
        
        if footerView != nil {
        var footerViewFrame = footerView!.frame
        
        footerViewFrame.origin = CGPoint(x: 0,y: contenH + kJYFooterViewMargin)
        
        if footerViewFrame.size.width > self.mainScreenSize.width {
            let h = self.mainScreenSize.width * footerViewFrame.size.height / footerViewFrame.size.width
            footerViewFrame.size = CGSize(width: self.mainScreenSize.width,height: h)
        } else {
            let margin = (self.mainScreenSize.width - footerViewFrame.size.width) / 2
            footerViewFrame.origin = CGPoint(x: margin,y: contenH + kJYFooterViewMargin)
        }
        
        footerView!.frame = footerViewFrame
        }
        
        contenH = contenH + footerViewH + kJYFooterViewMargin
        
        self.contentSize = CGSize(width: 0,height: contenH)
        
    }
    
    
    private func cellFrameOfIndex(index:NSInteger) -> CGRect{
        return .zero
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = .lightGray
        
        let numberOfCells = self.cellFrames.count
        
        for i in 0...(numberOfCells - 1) {
            
            if i >= self.cellNumbers {
                return
            }
            
            
            let cellFrame = self.cellFrames[i]
            
            var cell:JYTagViewCell? = self.displayingCells[i]
            
            if isInScreen(frame: cellFrame) {
                if cell == nil {
                    cell = self.dataSource_JY?.tagView(tagView: self, cellAtIndex: i)
                }
                cell!.frame = cellFrame
                cell!.layer.borderWidth = 2.0
                cell!.layer.borderColor = UIColor.black.cgColor
//                cell!.clipsToBounds = true
                cell!.layer.cornerRadius = 8.0
                self.addSubview(cell!)

                
                self.displayingCells[i] = cell
                
            } else {
                
                if cell != nil{
                    
                    cell!.removeFromSuperview()
                    
                    self.displayingCells.removeValue(forKey: i)
                    
                    self.reusableCells.insert(cell!)
                }
            }
        }
    }
    
    /**
     *
     *  利用重用标识符从缓存池中找到cell
     */
    func dequeueReusableCellWithIdentifier(identifier:String) -> JYTagViewCell? {
        for cell in self.reusableCells {
            
            if cell.identifier == identifier {
                reusableCells.remove(cell)
                return cell
            }
        }
        return nil
    }
    
    /**
     *  是否在屏幕上
     */
    private func isInScreen(frame:CGRect) -> Bool{
        return frame.maxY > self.contentOffset.y && frame.maxY < self.contentOffset.y + self.frame.size.height
    }
    
    
    /**
     *  cell height
     */
    private func heightAtIndex(index:NSInteger) -> CGFloat {
        return self.delegate_JY?.tagView(tagView: self, heightForRowInIndex: index) ?? kJYTagviewDefaultCellHeight
    }
    
    /** 获得每一个cell的宽度 */
    private func widthAtIndex(index:NSInteger) -> CGFloat {
        return self.delegate_JY?.tagView(tagView: self, widthForRowInIndex: index) ?? kJYTagviewDefaultCellWidth
    }

    /**  headerview*/
    private func headerViewInTagview() -> UIView? {
        return self.dataSource_JY?.headerViewInTagView(tagView: self)
    }
    
    /**  footerView*/
    private func footerViewInTagview() -> UIView? {
        if ((self.dataSource_JY?.footerViewInTagView(tagView: self)) != nil) {
            return self.dataSource_JY?.footerViewInTagView(tagView: self)
        }
        return nil
    }
    
    // MARK: 事件处理

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let point = touch.location(in: self)
        
        for displayingCell in self.displayingCells {
            if displayingCell.1.frame.contains(point) {
                self.delegate_JY?.tagView(tagView: self, didSelectAtIndex: displayingCell.0)
            }
        }
    }
    
}
