//
//  RecomdViewModel.swift
//  DYZB
//
//  Created by maxine on 2018/1/31.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
//http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&amp;offset=0&amp;time=1474252024
//第一部分（大数据）：http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=1517390457881
//第二部分（颜值）：http://capi.douyucdn.cn/api/v1/getVerticalRoom
class RecomdViewModel:NSObject{
    
    lazy var pageGroups:[ArchorGroups] = [ArchorGroups]()
    private lazy var prettyGroup:ArchorGroups = ArchorGroups()
    private lazy var bigDataGroup:ArchorGroups = ArchorGroups()

}

extension RecomdViewModel{
    func getData(finishedCallback:@escaping (_ backModels : [ArchorGroups])->()) {
        
        let GCDgroup = DispatchGroup()
        
        //1、加载大数据
        GCDgroup.enter()
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters:["time" : Date.getCurrentTime()]) { (result) in
            
            guard let resultDict = result as? [String: Any] else{ return }
            guard let bigDataArray = resultDict["data"] as? [[String:Any]] else{ return }
            
            for dict in bigDataArray{
                let model = RoomList(dict: dict)
                self.bigDataGroup.room_list.append(model)
            }
            GCDgroup.leave()

        }
        //2、加载颜值数据，颜值数据有地址
        GCDgroup.enter()
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom") { (result) in
            
            guard let prettyDict = result as? [String : Any] else{ return }
            guard let prettyData = prettyDict["data"] as? [[String : Any]] else{ return }
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.small_icon_url = ""
            for dict in prettyData{
                let model = RoomList(dict: dict)
                self.prettyGroup.room_list.append(model)
            }
            GCDgroup.leave()
        }

        //3、加载游戏部分数据
        GCDgroup.enter()
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()] as [String : Any]
        NetworkTools.requestData(type: .get, urlString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters:parameters) { (result) in
            
            guard let resultDict = result as? [String: Any] else{ return }
            guard let dataArray = resultDict["data"] as? [[String:Any]] else{ return }
            self.bigDataGroup.tag_name = "推荐"
            self.bigDataGroup.small_icon_url = ""
            for dict in dataArray{
                let model = ArchorGroups(dict: dict)
                self.pageGroups.append(model)
            }
            GCDgroup.leave()
        }
      
//MARK:数据请求完毕
        GCDgroup.notify(queue:DispatchQueue.main) {
            
            self.pageGroups.insert(self.prettyGroup, at: 0)
            self.pageGroups.insert(self.bigDataGroup, at: 0)
            finishedCallback(self.pageGroups)
        }

    }
}
