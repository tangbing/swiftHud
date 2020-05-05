//
//  MovieCollectionViewCell.swift
//  Swift-豆瓣首页
//
//  Created by Tb on 2019/11/20.
//  Copyright © 2019 Tb. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
import Rswift

class MovieCollectionViewCell: UICollectionViewCell {
    
    var _startImageView: UIImageView?
    var _startImageViews = [UIImageView]()
    var movie = Movie()
    let starBgView = UIView()
    //var imageArray:[UIImageView] = Array(repeating: UIImageView(), count: 5)
    
    
     let bearImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4;
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.black
        return titleLabel
    }()
    
    let startNumLabel: UILabel = {
        let startNumLabel = UILabel()
        startNumLabel.font = UIFont.systemFont(ofSize: 14)
        startNumLabel.textColor = UIColor.lightGray
        return startNumLabel
    }()
    
    let noCmtLabel: UILabel = {
        let noCmtLabel = UILabel()
        noCmtLabel.font = UIFont.systemFont(ofSize: 14)
        noCmtLabel.text = "暂未评分"
        noCmtLabel.textColor = UIColor.lightGray
        return noCmtLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setupLayout()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupLayout() {

        self.contentView.addSubview(bearImageView)
        bearImageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            
            make.height.equalTo(185)
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(bearImageView.snp_bottomMargin).offset(10)
            make.left.right.equalToSuperview()
            //make.centerX.equalToSuperview()
        }
        
//        starBgView.backgroundColor = UIColor.red
        self.contentView.addSubview(starBgView)
        starBgView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom)
            make.bottom.right.equalToSuperview()
        }
        
        for _ in 0..<5 {
            let starImageView = UIImageView(image: R.image.rating_star_small_on())
            _startImageViews.append(starImageView)
            starBgView.addSubview(starImageView)
            
            starImageView.snp.makeConstraints { (make) in
                make.width.height.equalTo(16)
                make.centerY.equalToSuperview()
                
                if _startImageView != nil {
                    make.left.equalTo(_startImageView!.snp_right)
                } else {
                    make.left.equalTo(titleLabel)
                }
            }
          _startImageView = starImageView
        }
        
         starBgView.addSubview(startNumLabel)
         startNumLabel.snp.makeConstraints { (make) in
           guard let imageView = _startImageView else {
               print("_startImageView 为空！！！")
               return
           }
           make.left.equalTo(imageView.snp_right)
           make.centerY.equalTo(imageView)
       }
        
        self.contentView.addSubview(noCmtLabel)
            noCmtLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(titleLabel.snp_bottom).offset(8)
        }
    }

    
    func setupData(moveData: Movie) -> Void {
          movie = moveData
//          _startImageView = nil
          
          if let icon = movie.images {
             bearImageView.kf.setImage(with: URL(string: icon.large!))
          }
        
          titleLabel.text = movie.title!
        
          if let star = movie.rating {
              startNumLabel.text = String(star.average)
          }
          
         
          guard let star = movie.star  else {return}
           
          //评星为0的情况
         if star.on == 0 && !star.half {
             starBgView.isHidden = true
             noCmtLabel.isHidden = false

         } else {
             starBgView.isHidden = false
             noCmtLabel.isHidden = true
            // 这里设置完整的星星
             for idx in  0..<star.on {
                _startImageViews[idx].image = R.image.rating_star_small_on()
              }
              // 这里设置半颗的星星
              if star.half {
                _startImageViews[movie.star!.on].image = R.image.rating_star_small_half()
              }
              // 这里设置灰色的星星
             let offIndex = star.half ? star.on + 1 : star.on
             for i in offIndex..<5 {
                _startImageViews[i].image = R.image.rating_star_small_off()
             }
          }
      }
        
}
