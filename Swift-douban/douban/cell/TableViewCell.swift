//
//  TableViewCell.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/4.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import Kingfisher

class TableViewCell: UITableViewCell {

    var collectionViewIdentifier: String = "collectionViewIdentifier"
    var moveies = [Movie]()
    var collectionView: UICollectionView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
         
    }

    
    func setupUI() {
        self.backgroundColor = UIColor.white
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 113.0, height: 230.0)
        flowLayout.minimumLineSpacing = 20;
        flowLayout.scrollDirection = .horizontal
        
       
        collectionView = UICollectionView(frame:CGRect(x: 20, y: 0, width: UIScreen.main.bounds.width - 40, height: 250 + 24) , collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView?.register(type(of: MovieCollectionViewCell()), forCellWithReuseIdentifier: collectionViewIdentifier)
        self.contentView.addSubview(collectionView!)

        
       
       
        
    }
}

extension TableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moveies.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewIdentifier, for: indexPath) as! MovieCollectionViewCell

        
        let movie = moveies[indexPath.row]
        item.setupData(moveData: movie)
        return item
    }
    
    
}

extension TableViewCell: UICollectionViewDelegate {
    
}
