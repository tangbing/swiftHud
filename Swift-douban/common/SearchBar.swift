//
//  SearchBar.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/6.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import SwifterSwift
class SearchBar: UISearchBar,UISearchBarDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    required public init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           makeUI()
       }
    
    
    func makeUI() {
        self.delegate = self
        placeholder = "全局搜索"
        /// 一个布尔值，指示搜索栏是半透明（true）还是不是半透明（false）
        isTranslucent = false
        searchBarStyle = .minimal
        textField?.textColor = UIColor.Material.grey900
        textField?.keyboardAppearance = UIKeyboardAppearance.light
        textField?.placeholder = placeholder
        updateUI()
    }
    
    func updateUI() {
           setNeedsDisplay()
    }
    
    // MARK: UISearchBarDelegate
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.setShowsCancelButton(true, animated: true)
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.setShowsCancelButton(false, animated: true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.resignFirstResponder()
    }                    // called when keyboard search button pressed
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resignFirstResponder()
    }

}
