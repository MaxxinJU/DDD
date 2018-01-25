//
//  DHomeController.swift
//  DYZB
//
//  Created by maxine on 2018/1/23.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit

class DHomeController: UIViewController {
    //MARK:懒加载属性
    private lazy var titleView: DTitleView = {
        let tf = CGRect(x: 0, y:CGFloat(kNavigationBarH+kStatusBarH), width: kScreenBoundW, height: 40)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = DTitleView(frame: tf, titles: titles)
        return titleView
    }()
    
    private lazy var pageCollectionView: PageCollectionView = {
        //设置frame
        let py = CGFloat(kNavigationBarH+kStatusBarH+kTitleViewH)
        let pf = CGRect(x: 0, y:py, width: kScreenBoundW, height: kScreenBoundH-py)
        //创建控制器数组
        var vcs = [UIViewController]()
        for _ in 0..<4{
            let vc = UIViewController()
            vcs.append(vc)
        }
        //创建pageCollectionView
        let pageCollectionView = PageCollectionView(frame: pf, childControllers: vcs, fatherController: self)
        pageCollectionView.backgroundColor = UIColor.red
        return pageCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
}

//MARK:================= UI =============❤️========
extension DHomeController{
 
    private func setupUI() {
        //MARK:-设置导航栏
        setupNavigationBar()
        
        //MARK:-设置titleView
        view.addSubview(titleView)

        //MARK:-设置PageCollectionView
        view.addSubview(pageCollectionView)

        //MARK:代理
        titleView.delegate = self
        pageCollectionView.delegate = self
    }

    private func setupNavigationBar() {
        //左侧item
        let btn = UIButton(type:.custom)
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        //右侧3个itme
        let scanBtnItem = UIBarButtonItem(normalImgN: "Image_scan", highlightImgN: "Image_scan_click", frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let hisBtnItem = UIBarButtonItem(normalImgN: "btn_search", highlightImgN: "btn_search_click", frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        let searchBtnItem = UIBarButtonItem(normalImgN: "Image_my_history", highlightImgN: "Image_my_history_click", frame: CGRect(x: 0, y: 0, width: 40, height: 40))

        navigationItem.rightBarButtonItems = [scanBtnItem, hisBtnItem, searchBtnItem]
    }
    
}

//MARK:各种代理方法
extension DHomeController : PageTitleViewDelegate, PageCollectionViewDelegate{
    func pageCollectionView(pCollectionView: PageCollectionView, sourceIndex: Int, targetIndex: Int, progress: CGFloat) {
        //调用titleView的响应方法
        titleView.getCurrentIndexAndProgress(sourceIndex: sourceIndex, targetIndex: targetIndex, progress: progress)
    }
    
    func PageTitleView(titleView: DTitleView, selectIndex index: Int) {
        //调用collectionView的方法
        pageCollectionView.getCurrentIndex(currentIndex: index)
    }
    
   
}
