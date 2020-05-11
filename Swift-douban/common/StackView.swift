//
//  StackView.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/6.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit

class StackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        makeUI()
    }
    
    func makeUI() {
        spacing = inset
        axis = .vertical
        updateUI()
    }
    func updateUI() {
        setNeedsDisplay()
    }

}
