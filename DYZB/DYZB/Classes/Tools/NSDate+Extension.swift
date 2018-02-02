//
//  NSDate+Extension.swift
//  DYZB
//
//  Created by maxine on 2018/1/31.
//  Copyright © 2018年 maxine. All rights reserved.
//

import Foundation

extension Date{
    
    static func getCurrentTime()-> String  {

        let date = Date()
        let timeIntervel = date.timeIntervalSince1970 * 1000
        return "\(timeIntervel)"

    }

}
