
//
//  DTitleView.swift
//  DYZB
//
//  Created by maxine on 2018/1/23.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
//MARK:代理：点击label切换collectView的item
private let kNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kHighlighrColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let colorDetail = (kNormalColor.0-kHighlighrColor.0, kNormalColor.1-kHighlighrColor.1, kNormalColor.2-kHighlighrColor.2)
protocol PageTitleViewDelegate : class {
    func PageTitleView(titleView:DTitleView, selectIndex index: Int)
}

class DTitleView: UIView {
    //MARK:定义属性
    weak var delegate : PageTitleViewDelegate?
    private let titles: [String]
    //定义存储label的数组
    private lazy var titleLabels: [UILabel] = [UILabel]()
    //记录选中的label
    private var selectedLabel: UILabel?
    //记录之前选中的数字
    private var oldLabel: UILabel?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.backgroundColor = UIColor.darkGray
        return scrollView
    }()
    
    private lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGray
        return lineView
    }()
    
    private lazy var scrollLineView:UIView = {
        let scrollLineView = UIView()
        scrollLineView.backgroundColor = UIColor(r: kHighlighrColor.0, g: kHighlighrColor.1, b: kHighlighrColor.2, alpha: 1)
        return scrollLineView
    }()
 
    
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//MARK:===========================界面布局=============
extension DTitleView{
    
    private func setupUI(){
    
        //MARK:1、添加ScrollView
        scrollView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height-2)
        addSubview(scrollView)
        
        //MARK:2、添加分割线
        lineView.frame = CGRect(x: 0, y: bounds.height-0.5, width: bounds.width, height: 0.5)
        addSubview(lineView)
        
        //MARK:3、添加Label
        let width = bounds.width/CGFloat(titles.count)
        let height = bounds.height-2
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            label.tag = index
            label.text = title
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1)
            label.textAlignment = .center
            
            let x = width * CGFloat(index)
            label.frame = CGRect(x: x, y: 0, width: width, height: height)
            
            //给label添加手势
            label.isUserInteractionEnabled = true
            let tagG = UITapGestureRecognizer(target: self, action: #selector(labelTagClick(TapGesture:)))
            label.addGestureRecognizer(tagG)
            
            titleLabels.append(label)
            scrollView.addSubview(label)
        }
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        //默认选中第一个label
        selectedLabel = firstLabel
        //MARK:4、添加scrollLine
        scrollLineView.frame = CGRect(x: 0, y: bounds.height-2, width: firstLabel.bounds.width, height: 2)
        addSubview(scrollLineView)
       
    
    }
    //MARK:接收collectionView传来的数据
    func getCurrentIndexAndProgress(sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        
//        print(sourceIndex,"---->",targetIndex,progress)
        let targetLabel = titleLabels[targetIndex]
        let sourceLabel = titleLabels[sourceIndex]
        
        //1、改变滚动条位置
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLineView.frame.origin.x =  sourceLabel.frame.origin.x + moveX
        
        //2、改变文字颜色
        targetLabel.textColor = UIColor(r: kNormalColor.0 - colorDetail.0*progress, g: kNormalColor.1 - colorDetail.1*progress, b: kNormalColor.2 - colorDetail.2*progress, alpha: 1)
        sourceLabel.textColor = UIColor(r: kHighlighrColor.0 + colorDetail.0*progress, g: kHighlighrColor.1 + colorDetail.1*progress, b: kHighlighrColor.2 + colorDetail.2*progress, alpha: 1)

    }
    
}

//MARK:=========================== 监听label事件 =============
extension DTitleView{
    
    @objc private func labelTagClick(TapGesture:UITapGestureRecognizer){
        //从根部解决可选项和不确定类型的问题
        guard let label = TapGesture.view as? UILabel else{ return }
        oldLabel = selectedLabel
        selectedLabel = label
        
        //设置颜色
        oldLabel?.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2, alpha: 1)
        selectedLabel?.textColor = UIColor(r: kHighlighrColor.0, g: kHighlighrColor.1, b: kHighlighrColor.2, alpha: 1)
        
        //scrollLine的偏移
        let offsetX = scrollLineView.bounds.width * CGFloat(label.tag)
        UIView.animate(withDuration: 0.15) {
            self.scrollLineView.frame.origin.x = offsetX
        }
        
        //通知代理
        delegate?.PageTitleView(titleView: self, selectIndex: label.tag)

    }
    
}

