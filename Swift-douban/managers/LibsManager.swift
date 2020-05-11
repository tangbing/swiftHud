//
//  LibsManager.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/6.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
//import NVActivityIndicatorView
import IQKeyboardManagerSwift
import Kingfisher
import CocoaLumberjack
// import FLEX
import Toast_Swift
import DropDown
import SwifterSwift


class LibsManager: NSObject {
    static let shared = LibsManager()
    override init() {
        super.init()
        
    }
    func setupApperance(){
        SearchBar.appearance().tintColor = UIColor.Material.red
        
    }
}

/*
class LibsManager: NSObject {

    static let shared = LibsManager()
    
    override init() {
        super.init()
        var bannersEnabled: Bool = false
   
        bannersEnabled = UserDefaults.standard.object(forKey: Configs.UserDefaultsKeys.bannersEnabled) == nil ? true : false
        
        UserDefaults.standard.set(enabled, forKey: Configs.UserDefaultsKeys.bannersEnabled)
        analytics.updateUser(ads: enabled)
    }
    
    func setupLibs(with window: UIWindow? = nil) {
        let libsManager = LibsManager.shared
        libsManager.setupCocoaLumberjack()
        libsManager.setupAnalytics()
        libsManager.setupAds()
        //libsManager.setupTheme()
        libsManager.setupKafkaRefresh()
        libsManager.setupFLEX()
        libsManager.setupKeyboardManager()
        libsManager.setupActivityView()
        libsManager.setupDropDown()
        libsManager.setupToast()
    }
    
        func setupActivityView() {
            NVActivityIndicatorView.DEFAULT_TYPE = .ballRotateChase
            NVActivityIndicatorView.DEFAULT_COLOR = .secondary()
        }

        func setupKeyboardManager() {
            IQKeyboardManager.shared.enable = false
        }

        func setupKingfisher() {
            // Set maximum disk cache size for default cache. Default value is 0, which means no limit.
            ImageCache.default.diskStorage.config.sizeLimit = UInt(500 * 1024 * 1024) // 500 MB

            // Set longest time duration of the cache being stored in disk. Default value is 1 week
            ImageCache.default.diskStorage.config.expiration = .days(7) // 1 week

            // Set timeout duration for default image downloader. Default value is 15 sec.
            ImageDownloader.default.downloadTimeout = 15.0 // 15 sec
        }

        func setupCocoaLumberjack() {
            DDLog.add(DDTTYLogger.sharedInstance) // TTY = Xcode console
    //        DDLog.add(DDASLLogger.sharedInstance) // ASL = Apple System Logs

            let fileLogger: DDFileLogger = DDFileLogger() // File Logger
            fileLogger.rollingFrequency = TimeInterval(60*60*24)  // 24 hours
            fileLogger.logFileManager.maximumNumberOfLogFiles = 7
            DDLog.add(fileLogger)
        }

        func setupFLEX() {
            FLEXManager.shared().isNetworkDebuggingEnabled = true
        }

        func setupAnalytics() {
            FirebaseApp.configure()
            Mixpanel.sharedInstance(withToken: Keys.mixpanel.apiKey)
            Fabric.with([Crashlytics.self])
            Fabric.sharedSDK().debug = false
            analytics.register(provider: MixpanelProvider())
            analytics.register(provider: FirebaseProvider())
        }

        func setupAds() {
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        }
    
    
}
*/
