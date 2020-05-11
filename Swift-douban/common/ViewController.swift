//
//  ViewController.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/6.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import DZNEmptyDataSet


class ViewController: UIViewController {

    var automaticallyAdjustsLeftBarButtonItem = true
    var canOpenFlex = true
    
//    var navigationTitle = "" {
//        didset {
//            navigationItem.title = navigationTitle
//        }
//    }
    
    let spaceBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    
    var emptyDataSetDescription = ""
    var emptyDataSetImage = R.image.image_no_result()
    
    
    lazy var searchBar: SearchBar = {
           let view = SearchBar()
           return view
       }()

       lazy var backBarButton: BarButtonItem = {
           let view = BarButtonItem()
           view.title = ""
           return view
       }()

       lazy var closeBarButton: BarButtonItem = {
           let view = BarButtonItem(image: R.image.icon_navigation_close(),
                                    style: .plain,
                                    target: self,
                                    action: #selector(close))
           return view
       }()


       lazy var contentView: View = {
           let view = View()
           //        view.hero.id = "CententView"
           self.view.addSubview(view)
           view.snp.makeConstraints { (make) in
               make.edges.equalTo(self.view.safeAreaLayoutGuide)
           }
           return view
       }()

       lazy var stackView: StackView = {
           let subviews: [UIView] = []
           let view = StackView(arrangedSubviews: subviews)
           view.spacing = 0
           self.contentView.addSubview(view)
           view.snp.makeConstraints({ (make) in
               make.edges.equalToSuperview()
           })
           return view
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // One finger swipe gesture for opening Flex
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleOneFingerSwipe(swipeRecognizer:)))
        swipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeGesture)

        // Two finger swipe gesture for opening Flex and Hero debug
        let twoSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleTwoFingerSwipe(swipeRecognizer:)))
        twoSwipeGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoSwipeGesture)
    }


}

extension ViewController {
    @objc func close(){
        print("close...")
    }
    
    @objc func handleOneFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
//        if swipeRecognizer.state == .recognized, canOpenFlex {
//            LibsManager.shared.showFlex()
//        }
    }

    @objc func handleTwoFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
//        if swipeRecognizer.state == .recognized {
//            LibsManager.shared.showFlex()
//            HeroDebugPlugin.isEnabled = !HeroDebugPlugin.isEnabled
//        }
    }
}
