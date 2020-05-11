//
//  TrendReposity.swift
//  Swift-douban
//
//  Created by Tb on 2020/5/11.
//  Copyright © 2020 Tb. All rights reserved.
//

import UIKit
import KakaJSON
import BonMot
/*
 "author": "AU-COVIDSafe",
        "name": "mobile-android",
        "avatar": "https://github.com/AU-COVIDSafe.png",
        "url": "https://github.com/AU-COVIDSafe/mobile-android",
        "description": "COVIDSafe android app",
        "language": "Kotlin",
        "languageColor": "#F18E33",
        "stars": 158,
        "forks": 65,
        "currentPeriodStars"
 */

struct TrendReposity: Convertible {

    var author: String?
    var avatar: String?
    var name: String?
    var url: String?
    var description: String?
    var language: String?
    var languageColor: String?
    var stars: Int?
    var forks: Int?
    var currentPeriodStars: Int?
    var builtBy: [buildBy]?
    
}

struct buildBy: Convertible {
    var username: String = ""
    var href: String = ""
    var avatar: String = ""
}

extension TrendReposity {
    func attributetDetail(since: String) -> NSAttributedString {
        let starImage = R.image.icon_cell_badge_star()?.filled(withColor: .white).scaled(toHeight: 15)?.styled(with: .baselineOffset(-3)) ?? NSAttributedString()
        let starsString = (stars ?? 0).kFormatted().styled( with: .color(UIColor.Material.white))
        let currentPeriodStarsString = "\((currentPeriodStars ?? 0).kFormatted()) \(since.lowercased())".styled( with: .color(UIColor.Material.white))
        let languageColorShape = "●".styled(with: StringStyle([.color(UIColor(hexString: languageColor ?? "") ?? .clear)]))
        let languageString = (language ?? "").styled( with: .color(UIColor.Material.white))
        return NSAttributedString.composed(of: [
            starImage, Special.space, starsString, Special.space, Special.tab,
            starImage, Special.space, currentPeriodStarsString, Special.space, Special.tab,
            languageColorShape, Special.space, languageString
        ])
    }
}





