//
//  GroupDao.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit
import CoreData


public class Groups : NSManagedObject {
    
    
    @NSManaged var id : String?
    @NSManaged var name : String?
    @NSManaged var desc : String?
    @NSManaged var order : Int64
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Groups", in: managedContext!)
        super.init(entity: entity!, insertInto: context)
    }
    
    func fromDaoToGroupModel() -> GroupModel{
        
        var groupModel = GroupModel()
        
        groupModel.name = self.name
        groupModel.desc = self.desc
        groupModel.order = Int(truncatingIfNeeded: self.order)
        groupModel.id = self.id
        return groupModel
    }
    
}
