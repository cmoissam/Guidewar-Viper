//
//  Achievements.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/15/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//


import Foundation
import ObjectMapper

struct AchievementModel:Mappable {

//    id - The achievement id.
//    name (string) – The achievement name.
//    description (string) – The achievement description.
//    requirement (string) – The achievement requirement as listed in-game.
    
        private let ID = "id"
        private let NAME = "name"
        private let DESCRIPTION = "description"
        private let REQUIREMENT = "requirement"
        
        internal var id:Int?
        internal var name:String?
        internal var desc:String?
        internal var requirement:String?
    
    init() {
        
    }
    
    init?(map: Map) {
        mapping(map: map)
    }
        
    mutating func mapping(map:Map){
            id <- map[ID]
            name <- map[NAME]
            desc <- map[DESCRIPTION]
            requirement <- map[REQUIREMENT]
        }

}
