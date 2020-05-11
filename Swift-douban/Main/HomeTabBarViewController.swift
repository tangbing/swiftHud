//
//  HomeTabBarViewController.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/5.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import Rswift
import SwifterSwift
import RAMAnimatedTabBarController

enum HomeTabBarItem: Int {
    
    case search, news, notifications, settings, login
    
    private func controller() -> UIViewController {
        switch self {
        case .search:
            let vc = SearchTableViewController()
            return UINavigationController(rootViewController: vc)
        case .news:
            let vc = EventsViewController()
            return UINavigationController(rootViewController: vc)
        case .notifications:
            let vc = NotificationsViewController()
            return UINavigationController(rootViewController: vc)
        case .settings:
            let vc = SettingsViewController()
            return UINavigationController(rootViewController: vc)
        case .login:
            let vc = LoginViewController()
            return UINavigationController(rootViewController: vc)
        }
    }
    
    var image: UIImage? {
        switch self {
        case .search: return R.image.icon_tabbar_search()
        case .news: return R.image.icon_tabbar_news()
        case .notifications: return R.image.icon_tabbar_activity()
        case .settings: return R.image.icon_tabbar_settings()
        case .login: return R.image.icon_tabbar_login()
        }
    }
    
    var title: String {
        switch self {
        case .search: return "搜索"
        case .news: return "事件"
        case .notifications: return "活动"
        case .settings: return "设置"
        case .login: return "登录"
        }
    }
    
    var animation: RAMItemAnimation {
        var animation: RAMItemAnimation
        switch self {
        case .search: animation = RAMFlipLeftTransitionItemAnimations()
        case .news: animation = RAMBounceAnimation()
        case .notifications: animation = RAMBounceAnimation()
        case .settings: animation = RAMRightRotationAnimation()
        case .login: animation = RAMBounceAnimation()
        }
        
        animation.iconSelectedColor = .red
        animation.textSelectedColor = .red
        
        return animation
    }
    
    func getController() -> UIViewController {
        let vc = controller()
        let item = RAMAnimatedTabBarItem(title: title, image: image, tag: rawValue)
        item.animation = animation
        item.iconColor = UIColor.Material.grey900
        item.textColor = UIColor.Material.grey900
        vc.tabBarItem = item
        return vc
    }
}




class HomeTabBarViewController: RAMAnimatedTabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        //addChildViewController()
        super.viewDidLoad()
        
       let tabBarItems = transform()
        let controllers = tabBarItems.map{$0.getController()}
       setViewControllers(controllers, animated: false)
    }
    
    func transform() ->[HomeTabBarItem] {
        let tabBarItems: [HomeTabBarItem] = [.search, .login, .settings]
        return tabBarItems
    }
    
    /*
    func addChildViewController(){
        
        addChildVc(childVc: SearchTableViewController(), title: "搜索", imageNormal: R.image.icon_tabbar_search(), imageSelect: R.image.icon_tabbar_search())
        addChildVc(childVc: SearchTableViewController(), title: "登录", imageNormal: R.image.icon_tabbar_login(), imageSelect: R.image.icon_tabbar_login())
        addChildVc(childVc: SearchTableViewController(), title: "设置", imageNormal: R.image.icon_tabbar_settings(), imageSelect: R.image.icon_tabbar_settings())
    }
    
    func addChildVc(childVc: UIViewController, title: String?, imageNormal: UIImage?, imageSelect:UIImage?){
        let Nav = UINavigationController(rootViewController: childVc)
        let item = RAMAnimatedTabBarItem(title: title, image: imageNormal, selectedImage: imageSelect)
        
        item.iconColor = .lightGray
        item.textColor = .lightGray
        
        let animation = RAMFlipLeftTransitionItemAnimations()
        animation.iconSelectedColor = .red
        animation.textSelectedColor = .red
        item.animation = animation
        
        addChild(Nav)
        Nav.tabBarItem = item
    }
    */
    
}


//
//extension HomeTabBarViewController {
//    func commitInitView(){
//        view.backgroundColor = .white
//        tabBar.isTranslucent = false
//        tabBar.tintColor = .yellow
//        tabBar.barTintColor = .purple
//    }
//}
