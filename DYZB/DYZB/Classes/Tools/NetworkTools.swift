//
//  NetworkTools.swift
//  DYZB
//
//  Created by maxine on 2018/1/29.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
import Alamofire

class NetworkTools{

    class func requestData(type: HTTPMethod, urlString: String, parameters: [String:Any]? = nil,finishedCallback:@escaping (_ result: Any)->() ) {
        
        //获取方法类型并转换为alamofire的美剧类型
//        let method = type == .GET ? Method.GET : Method.POST
        Alamofire.request(urlString, method: type, parameters: parameters).responseJSON { (response) in
            
            guard let res = response.result.value else {
                print("网络请求错误：",response.result.error ?? "请求数据为空")
                return
            }
//            print("请求结果",res)
            finishedCallback(res)
            
        }
   
    }
    
}
