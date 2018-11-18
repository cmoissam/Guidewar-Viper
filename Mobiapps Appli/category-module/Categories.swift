//
//  Categories.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit
import CoreData


public class Categories:NSManagedObject {
    
    
    @NSManaged var id : Int64
    @NSManaged var name : String?
    @NSManaged var desc : String?
    @NSManaged var order : Int64
    @NSManaged var icon : String?
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Groups", in: managedContext!)
        super.init(entity: entity!, insertInto: context)
    }
    
    func fromDaoToCategoryModel() -> CategoryModel{
        var categoryModel = CategoryModel()
        categoryModel.icon = icon
        categoryModel.name = name
        categoryModel.desc = desc
        categoryModel.order = Int(truncatingIfNeeded: order)
        categoryModel.id = Int(truncatingIfNeeded: id)
        
        return categoryModel
    }
    
}
