//
//  UIColor+Extension.swift
//  DYZB
//
//  Created by maxine on 2018/1/24.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
    
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
        
    }
    
    
}
