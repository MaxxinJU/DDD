//
//  YanZCollectionViewCell.swift
//  DYZB
//
//  Created by maxine on 2018/1/26.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
import Kingfisher
class YanZCollectionViewCell: UICollectionViewCell {

   
    @IBOutlet weak var looksCountLabel: UILabel!
    @IBOutlet weak var archorNameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var yanzCellImageView: UIImageView!
    
    var prettyRoomModel: RoomList?{
        didSet {
            guard let prettyRoomModel = prettyRoomModel else{ return }
            cityLabel.text = prettyRoomModel.anchor_city
            archorNameLabel.text = prettyRoomModel.nickname
            looksCountLabel.text = "\(prettyRoomModel.online)人观看"
            let url = URL(string: prettyRoomModel.vertical_src)
            yanzCellImageView.kf.setImage(with: url, placeholder: UIImage(named: "live_cell_default_phone"))
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
