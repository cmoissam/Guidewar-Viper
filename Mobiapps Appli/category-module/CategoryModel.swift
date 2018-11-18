//
//  CategoryModel.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/15/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import Foundation
import ObjectMapper
import CoreData

struct CategoryModel: Mappable {
    
    var id : Int?
    var name : String?
    var desc : String?
    var order : Int?
    var icon : String?
    var achievements : [Int]?
    //var groupName : String?
    
    init(map: Map) {
        mapping(map: map)
        
    }
    
    init() {
        
    }
    
    mutating func mapping(map: Map) {
        
        id <- map["id"]
        name <- map["name"]
        desc <- map["description"]
        order <- map["order"]
        icon <- map["icon"]
        achievements <- map["achievements"]
    }
    

}


