//
//  RecommondViewController.swift
//  DYZB
//
//  Created by maxine on 2018/1/26.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit

private let kItemW = (kScreenBoundW - 3*kMargin)/2
private let kNormalItemH = kItemW*3/4
private let kYanzItemH = kItemW*4/3

private let kHeadViewH : CGFloat = 40
private let kHeadViewID = "headerView"
private let kNormalItemID = "NormalItemID"
private let kYanZItemID = "YanZItemID"

class RecommondViewController: UIViewController {
    var archorsData:[AnyObject]?
    fileprivate lazy var recommendVM : RecomdViewModel = RecomdViewModel()
    //模型数组
    fileprivate lazy var archorGroups: [ArchorGroups] = [ArchorGroups]()
    //懒加载collectionView
    private lazy var collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = kMargin
        layout.minimumInteritemSpacing = kMargin
        layout.sectionInset = UIEdgeInsets(top: 0, left: kMargin, bottom: 0, right: kMargin)
        layout.headerReferenceSize = CGSize(width: view.bounds.width, height: kHeadViewH)
        let collectView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectView.backgroundColor = UIColor.white
        
        let normalItemNib = UINib(nibName: "NormalCollectionViewCell", bundle: nil)
        collectView.register(normalItemNib, forCellWithReuseIdentifier: kNormalItemID)
        let yanzItemNib = UINib(nibName: "YanZCollectionViewCell", bundle: nil)
        collectView.register(yanzItemNib, forCellWithReuseIdentifier: kYanZItemID)
        let headerViewNib = UINib(nibName: "CollectionHeaderView", bundle: nil)
        collectView.register(headerViewNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeadViewID)
        collectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectView.dataSource = self
        collectView.delegate = self
        
        return collectView
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
     
        setupUI()
        
        getData()
    }
    //MARK:页面布局
    private func setupUI(){
        
        view.addSubview(collectionView)
    }
    //MARK:获取模型数据
    private func getData(){
        
        recommendVM.getData { (pageData) in
            self.archorGroups = pageData
            self.collectionView.reloadData()
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
//MARK:collectionView的数据源及代理方法
extension RecommondViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.archorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.archorGroups[section].room_list.count
    }
    //MARK:设置cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出模型
        let archor = self.archorGroups[indexPath.section].room_list[indexPath.item]
        if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kYanZItemID, for: indexPath) as! YanZCollectionViewCell
            cell.prettyRoomModel = archor
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalItemID, for: indexPath) as! NormalCollectionViewCell
            cell.normalModel = archor
            return cell
        }
    }
    //MARK:设置headerView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let  headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeadViewID, for: indexPath) as! CollectionHeaderView
        headerView.headModel = self.archorGroups[indexPath.section]
        return headerView
    }
    
    //MARK:设置item的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        if indexPath.section == 1{
            return CGSize(width: kItemW, height: kYanzItemH)
        }
            return CGSize(width: kItemW, height: kNormalItemH)
    }
}
