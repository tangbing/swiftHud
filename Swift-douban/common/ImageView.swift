//
//  ImageView.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/11.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit

class ImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    override init(image: UIImage?) {
        super.init(image: image)
        makeUI()
    }

    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        makeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    func makeUI() {
        tintColor = UIColor.Material.grey900
        layer.masksToBounds = true
        contentMode = .center

        //hero.modifiers = [.arc]

        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
}
