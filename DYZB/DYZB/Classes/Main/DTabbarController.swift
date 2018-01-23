//
//  DTabbarController.swift
//  DYZB
//
//  Created by maxine on 2018/1/22.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit

class DTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addChildVc(name: "Home", title: "首页", defaultImage: "btn_home_normal", selectImage: "btn_home_selected")
        addChildVc(name: "Live", title: "直播", defaultImage: "btn_column_normal", selectImage: "btn_column_selected")
        addChildVc(name: "Follow", title: "关注", defaultImage: "btn_live_normal", selectImage: "btn_live_selected")
        addChildVc(name: "Profile", title: "我的", defaultImage: "btn_user_normal", selectImage: "btn_user_selected")

    }
    
    func addChildVc(name: String, title: String, defaultImage: String, selectImage: String) {
        
        let childVC = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        childVC.title = title
        childVC.tabBarItem.image = UIImage(named: defaultImage)
        childVC.tabBarItem.selectedImage = UIImage(named: selectImage)
        addChildViewController(childVC)
    }
    
    
}
