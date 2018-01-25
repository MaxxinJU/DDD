//
//  UIBarButtonItem+Extension.swift
//  DYZB
//
//  Created by maxine on 2018/1/23.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    convenience init(normalImgN: String, highlightImgN: String, frame: CGRect){
    
        let btn = UIButton()
        btn.frame = frame
        btn.setImage(UIImage(named: normalImgN), for: .normal)
        btn.setImage(UIImage(named: highlightImgN), for: .highlighted)
        self.init(customView: btn)
    
    }
    
}
