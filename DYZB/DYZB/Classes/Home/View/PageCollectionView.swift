//
//  PageCollectionView.swift
//  DYZB
//
//  Created by maxine on 2018/1/24.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
//MARK:代理
protocol PageCollectionViewDelegate : class{
    func pageCollectionView(pCollectionView: PageCollectionView, sourceIndex: Int, targetIndex: Int, progress: CGFloat)
}
private let itemID = "itemID"
class PageCollectionView: UIView {
    
    //MARK:定义属性
    weak var delegate: PageCollectionViewDelegate?
    private var childVcs: [UIViewController] = [UIViewController]()
    private weak var fatherVc: UIViewController?
    private var startOffsetX: CGFloat?
    private var sourceIndex: Int = 0
    private var targetIndex: Int = 0
    private var progress: CGFloat = 0

    
    //MARK:懒加载
    private lazy var collectionView: UICollectionView = { [weak self] in
        //流布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: bounds.width, height: bounds.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height), collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: itemID)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false

        return collectionView
    }()

    convenience init(frame: CGRect, childControllers:[UIViewController], fatherController:UIViewController) {
        
        self.init(frame: frame)
        childVcs = childControllers
        fatherVc = fatherController
        setupUI()
        
    }
    
 
}
//MARK:页面布局
extension PageCollectionView{
    
    private func setupUI() {
        //MARK:创建collectionView
        addSubview(collectionView)
        //MARK:添加子控制器
        for vc in childVcs {
            fatherVc?.addChildViewController(vc)
        }
        
    }
    
    //MARK:接收titleView的指令

    func getCurrentIndex(currentIndex: Int) {
        
        let offsetX = collectionView.bounds.width * CGFloat(currentIndex)
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}

//MARK:数据源方法
extension PageCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemID, for: indexPath)
//        cell.contentView.backgroundColor =
        
        //添加控制器和view
        let childVc = childVcs[indexPath.item]
        childVc.view.backgroundColor = UIColor(r: CGFloat( arc4random_uniform(255)), g: CGFloat( arc4random_uniform(255)), b: CGFloat( arc4random_uniform(255)), alpha: 1)
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
        
    }

}

//MARK:监听滚动--collectionViewDelegate
extension PageCollectionView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //获取开始偏移量
        startOffsetX = scrollView.contentOffset.x
        sourceIndex = Int(startOffsetX!/collectionView.bounds.width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let currenOffsetX = scrollView.contentOffset.x
        guard let starO = startOffsetX else{ return }
        //判断滑动方向
        if currenOffsetX > starO {
            //1、进度
            progress = currenOffsetX/collectionView.bounds.width - floor(currenOffsetX/collectionView.bounds.width)
            
            sourceIndex = Int(currenOffsetX/collectionView.bounds.width)
            targetIndex = sourceIndex + 1
            
            //2、右划结束后，设置sourceIndex
            if currenOffsetX - starO == collectionView.bounds.width {
                progress = 1.0
                targetIndex = sourceIndex == 4 ? 3 :sourceIndex
                sourceIndex = sourceIndex - 1
//MARK:此处如何约束超出范围的部分，需要查看源码
            }
            
            
        }else if currenOffsetX < starO{
            //1、进度
            progress = 1 - (currenOffsetX/collectionView.bounds.width - floor(currenOffsetX/collectionView.bounds.width))
            //2、计算TargetIndex
            targetIndex = sourceIndex - 1
            //左划结束后,设置

        }
              
        //通知代理（崩溃请注释掉，因为target超出范围）
        delegate?.pageCollectionView(pCollectionView: self, sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
        
    }
    
    
}


