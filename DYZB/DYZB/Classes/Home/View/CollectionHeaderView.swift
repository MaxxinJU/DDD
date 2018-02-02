//
//  CollectionHeaderView.swift
//  DYZB
//
//  Created by maxine on 2018/1/26.
//  Copyright © 2018年 maxine. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var headModel:ArchorGroups?{
        didSet{
            guard let headModel = headModel else{ return }
            let iconURL = URL(string: headModel.small_icon_url)
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_header_phone"))
            headerTitleLabel.text = headModel.tag_name
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
