//
//  NormalCollectionViewCell.swift
//  DYZB
//
//  Created by maxine on 2018/1/26.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
import Kingfisher
class NormalCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var liveTitleLabel: UILabel!
    @IBOutlet weak var liveDetailLabel: UILabel!
    @IBOutlet weak var lookCountLabel: UILabel!
    @IBOutlet weak var normalCellImageView: UIImageView!
    
    var normalModel:RoomList?{
        didSet{
            guard let normalModel = normalModel else { return }
            liveTitleLabel.text = normalModel.room_name
            liveDetailLabel.text = normalModel.nickname
            lookCountLabel.text = "\(normalModel.online)人观看"
            let url = URL(string: normalModel.vertical_src)
            normalCellImageView.kf.setImage(with: url, placeholder: UIImage(named: "live_cell_default_phone"))
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()

    
    }

}
