//
//  TableViewCell.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/11.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    var isSelection = false
    var selectionColor: UIColor? {
        didSet {
            setSelected(isSelected, animated: true)
        }
    }

    lazy var containerView: View = {
        let view = View()
        view.backgroundColor = .clear
        view.cornerRadius = Configs.BaseDimensions.cornerRadius
        self.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(horizontal: self.inset*2, vertical: self.inset))
        })
        return view
    }()

    lazy var stackView: StackView = {
        let subviews: [UIView] = []
        let view = StackView(arrangedSubviews: subviews)
        view.axis = .horizontal
        view.alignment = .center
        self.containerView.addSubview(view)
        view.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview().inset(inset)
        })
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        makeUI()
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        backgroundColor = selected ? selectionColor : .clear
    }

    func makeUI() {
        layer.masksToBounds = true
        selectionStyle = .none
        backgroundColor = .clear

        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
}
