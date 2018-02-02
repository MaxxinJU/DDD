
//
//  ArchorGroups.swift
//  DYZB
//
//  Created by maxine on 2018/1/31.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
@objcMembers
class ArchorGroups : NSObject {
    
    //大图
    var icon_url : String = ""
    //小图
    var small_icon_url : String = ""
    //组的标题
    var tag_name : String?
    //每组里包含的直播
    var room_list :[RoomList] = [RoomList]()
    //封面图
    var vertical_src : String = ""
    // MARK:- 自定义构造函数
    override init() {
    }
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }

    override func setValue(_ value: Any?, forKey key: String) {
        if key == "room_list" {
            var arrM : [RoomList] = [RoomList]()
            for dict in value as! [[String : Any]]{

                let model = RoomList(dict: dict)
                arrM.append(model)
            }
            room_list = arrM
            return
        }
        super.setValue(value, forKey: key)
    }

}

@objcMembers
class RoomList : NSObject {
    /// 房间ID
    var room_id : Int = 0
    /// 房间图片对应的URLString
    var vertical_src : String = ""
    /// 判断是手机直播还是电脑直播
    // 0 : 电脑直播(普通房间) 1 : 手机直播(秀场房间)
    var isVertical : Int = 0
    /// 房间名称
    var room_name : String = ""
    /// 主播昵称
    var nickname : String = ""
    /// 观看人数
    var online : Int = 0
    /// 所在城市
    var anchor_city : String = ""

    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}

