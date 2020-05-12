//
//  SegmentedControl.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/6.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import HMSegmentedControl
import SwifterSwift


//protocol SegmentedControlDidselectDelegate {
//    func segmentedDidSelect(_ didSelect: Int)
//}



class SegmentedControl: HMSegmentedControl {

   //var didSelectItem: SegmentedControlDidselectDelegate?
    
    var selectItemBlock: ((_ idx: Int) ->())?
    
    init() {
        super.init(sectionTitles: [])
        makeUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    override init(sectionTitles sectiontitles: [String]) {
        super.init(sectionTitles: sectiontitles)

        makeUI()
    }
    
    override init!(sectionImages: [UIImage]!, sectionSelectedImages: [UIImage]!) {
        super.init(sectionImages: sectionImages, sectionSelectedImages: sectionSelectedImages)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    func makeUI() {
        backgroundColor = UIColor.Material.white
        self.selectionIndicatorColor = UIColor.Material.red
        let font = UIFont.systemFont(ofSize: 14)
        self.titleTextAttributes = [NSAttributedString.Key.font: font,
                               NSAttributedString.Key.foregroundColor: UIColor.Material.grey900]
        self.selectedTitleTextAttributes = [NSAttributedString.Key.font: font,
                                        NSAttributedString.Key.foregroundColor: UIColor.Material.red]
        self.setNeedsDisplay()
        cornerRadius = Configs.BaseDimensions.cornerRadius
        selectionStyle = .box
        selectionIndicatorLocation = .down
        selectionIndicatorBoxOpacity = 0
        selectionIndicatorHeight = 2.0
        segmentEdgeInset = UIEdgeInsets(inset: self.inset)
        
        snp.makeConstraints { (make) in
            make.height.equalTo(Configs.BaseDimensions.segmentedControlHeight)
        }
        indexChangeBlock = { [weak self] index in
           print(index)
           //self?.didSelectItem?.segmentedDidSelect(index)
            self?.selectItemBlock?(index)
        }
        updateUI()
    }
    func updateUI() {
        setNeedsDisplay()
    }
    
}

extension SegmentedControl {
    
}
