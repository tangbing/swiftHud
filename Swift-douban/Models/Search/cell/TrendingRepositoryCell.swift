//
//  TrendingRepositoryCell.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/11.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import Kingfisher

class TrendingRepositoryCell: BaseTableViewCell {

    lazy var leftImageView: ImageView = {
           let view = ImageView(frame: CGRect())
           view.contentMode = .scaleAspectFit
           view.cornerRadius = 25
           view.snp.makeConstraints({ (make) in
               make.size.equalTo(50)
           })
           return view
       }()
    lazy var badgeImageView: ImageView = {
        let view = ImageView(frame: CGRect())
        view.backgroundColor = .white
        view.cornerRadius = 10
        view.borderColor = .white
        view.borderWidth = 1
        containerView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.bottom.left.equalTo(self.leftImageView)
            make.size.equalTo(20)
        })
        return view
    }()
    
    lazy var titleLabel: Label = {
           let view = Label()
           view.backgroundColor = .purple
           view.font = view.font.withSize(14)
           return view
       }()
    
    lazy var detailLabel: Label = {
        let view = Label()
        view.backgroundColor = .green

        view.font = view.font.withSize(12)
        view.setPriority(UILayoutPriority.defaultLow, for: NSLayoutConstraint.Axis.vertical)
        return view
    }()
    
    lazy var attributedDetailLabel: Label = {
        let view = Label()
        view.backgroundColor = .red

        view.font = view.font.bold.withSize(11)
        return view
    }()
    
    lazy var textsStackView: StackView = {
        let views: [UIView] = [self.titleLabel, self.detailLabel, self.attributedDetailLabel]
        let view = StackView(arrangedSubviews: views)
        view.spacing = 2
        return view
    }()
    
    
    lazy var rightImageView: ImageView = {
        let view = ImageView(frame: CGRect())
        view.image = R.image.icon_cell_disclosure()?.template
        view.snp.makeConstraints({ (make) in
            make.width.equalTo(20)
        })
        return view
    }()
    
    override func makeUI() {
           super.makeUI()

           stackView.addArrangedSubview(leftImageView)
           stackView.addArrangedSubview(textsStackView)
           stackView.addArrangedSubview(rightImageView)
           stackView.snp.remakeConstraints({ (make) in
               let inset = self.inset
               make.edges.equalToSuperview().inset(UIEdgeInsets(top: inset/2, left: inset, bottom: inset/2, right: inset))
               make.height.greaterThanOrEqualTo(Configs.BaseDimensions.tableRowHeight)
           })
       }
    
    func bindData(_ reposityData : TrendReposity) {
        titleLabel.text = (reposityData.author ?? "") + "/" + (reposityData.name ?? "")
        detailLabel.text = reposityData.description
        leftImageView.kf.setImage(with: URL(string: reposityData.avatar ?? ""))
        attributedDetailLabel.attributedText = reposityData .attributetDetail(since: "每日")
        
    }
    
    
}

   
