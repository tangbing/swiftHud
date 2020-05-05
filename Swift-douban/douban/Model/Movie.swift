//
//  Movie.swift
//  Swift_doubanHome
//
//  Created by Tb on 2019/11/26.
//  Copyright © 2019 Tb. All rights reserved.
//

import KakaJSON

class Movie: Convertible {
       var collect_count: Int = 0
       var alt: String?
       var subtype: String?
       var year: String?
       var has_video: Bool = false
       var id: String?
       var genres = [String]()
       var rating: Rating?
       var pubdates = [String]()
       var casts = [Casts]()
       var original_title: String?
       var images: Images?
       var directors = [Directors]()
       var durations = [String]()
       var mainland_pubdate: String?
       var title: String?
       var star: Star? = Star()
       
       required init() {}
}

struct Star: Convertible {
   var on: Int = 0
   var off: Int = 0
   var half: Bool = true
}

struct Avatars: Convertible {
    var large: String?
    var medium: String?
    var small: String?
}

struct Images: Convertible {
    var large: String?
    var medium: String?
    var small: String?
}

struct Rating: Convertible {
    var stars: String = ""
    var min: Int = 0
    var max: Int = 0
    var average: Float = 0.0
    //var details: Details?
}

//struct Details {
//    var 3: String
//    var 2: Int = 0
//    var 5: Int = 0
//    var 4: Int = 0
//    var 1: Int = 0
//}

struct Casts: Convertible {
    var avatars: Avatars?
    var name: String?
    var id: String?
    var name_en: String?
    var alt: String?
}

struct Directors: Convertible {
    var avatars: Avatars?
    var name: String?
    var id: String?
    var name_en: String?
    var alt: String?
}
