//
//  GroupModel.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/15/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import Foundation
import ObjectMapper

struct  GroupModel : Mappable {
    
    var id : String?
    var name : String?
    var desc : String?
    var order : Int?
    var categories : [Int]?

    init?(map: Map) {
        
        mapping(map: map)
        
    }
    init() {
        
    }

    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        desc <- map["description"]
        order <- map["order"]
        categories <- map["categories"]
    }
    
}

