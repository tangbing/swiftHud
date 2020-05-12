//
//  TrendingRepositoryCell.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/13.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit

class TrendingRepositoryCell: DefaultTableViewCell {
    override func makeUI() {
        super.makeUI()
        leftImageView.cornerRadius = 25
    }
    
    func bindRepositoriesData(_ reposityData : TrendReposity) {
        titleLabel.text = (reposityData.author ?? "") + "/" + (reposityData.name ?? "")
        detailLabel.text = reposityData.description
        leftImageView.kf.setImage(with: URL(string: reposityData.avatar ?? ""))
        print(reposityData.trendingPeriod)
        attributedDetailLabel.attributedText = reposityData .attributetDetail(since: reposityData.trendingPeriod ?? "aaa")
        
    }
}
