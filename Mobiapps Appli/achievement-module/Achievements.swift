//
//  Achievements.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit
import CoreData


public class Achievements:NSManagedObject {
    
    
    @NSManaged var id : Int64
    @NSManaged var name : String?
    @NSManaged var desc : String?
    @NSManaged var requirement : String?
    
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Groups", in: managedContext!)
        super.init(entity: entity!, insertInto: context)
    }
    
    func fromDaoToAchievementModel() -> AchievementModel{
        var achievementModel = AchievementModel()
        achievementModel.requirement = requirement
        achievementModel.name = name
        achievementModel.desc = desc
        achievementModel.id = Int(truncatingIfNeeded: id)
        
        return achievementModel
    }
    
}
