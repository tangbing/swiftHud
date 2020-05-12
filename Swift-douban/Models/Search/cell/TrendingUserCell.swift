
//
//  TrendingUserCell.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/13.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit

class TrendingUserCell: DefaultTableViewCell {

    override func makeUI() {
           super.makeUI()
            leftImageView.cornerRadius = 25
            leftImageView.snp.remakeConstraints { (make) in
                      make.size.equalTo(50)
           }
       }
    
    func bindRepositoryUserData(_ userData : TrendUser) {
        let userName = userData.username ?? ""
        titleLabel.text =  userName  + "(" + (userData.name ?? "") + ")"
        detailLabel.text = userName + "/" + (userData.repo?.name ?? "")
        leftImageView.kf.setImage(with: URL(string: userData.avatar ?? ""))
        
    }
}
