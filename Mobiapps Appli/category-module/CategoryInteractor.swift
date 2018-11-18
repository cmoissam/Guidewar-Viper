//
//  CategoryInteractor.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit
import ObjectMapper
import RxSwift
import Moya_ObjectMapper
import CoreData
import Reachability

class CategoryInteractor: PresenterToCategoryInteractorProtocol {
    
    
    var presenter: InteractorToCategoryPresenterProtocol?
    
    let disposeBag = DisposeBag()
    
    let reachability = Reachability()!
    
    var category : CategoryModel?
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    

    func fetchAchievement() {
        
        let ids = category?.achievements
        if reachability.connection != .none{
            self.getAchievements(ids:ids!)
            
        }
        else{
            
            self.getAchievementsFromBase()
            
        }
        
    }
    
    func insertAchievements(achievements : Array<AchievementModel>){
        
        let managedContext = self.appDelegate?.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Achievements")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext?.execute(batchDeleteRequest)
            
        } catch {
            // Error Handling
        }
        
        let achievementEntity = NSEntityDescription.entity(forEntityName: "Achievements", in: managedContext!)!
        
        for achievement in achievements {
            let newAchievement = NSManagedObject(entity: achievementEntity, insertInto: managedContext)
            newAchievement.setValue(achievement.id, forKeyPath: "id")
            newAchievement.setValue(achievement.name, forKeyPath: "name")
            newAchievement.setValue(achievement.requirement, forKeyPath: "requirement")
            newAchievement.setValue(achievement.desc, forKey: "desc")
            newAchievement.setValue(self.category?.id, forKey: "category_id")
            
        }
        
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    func getAchievementsFromBase(){
                
        
        let managedContext = self.appDelegate?.persistentContainer.viewContext
        let achievementFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Achievements")
        achievementFetch.predicate = NSPredicate(format: "category_id = %ld", (self.category?.id!)!)
        let achievements = try! managedContext?.fetch(achievementFetch) as! Array<Achievements>
        var achievementsArray = Array<AchievementModel>()
        
        for AchievementDao in achievements {
            achievementsArray.append(AchievementDao.fromDaoToAchievementModel())
            
        }
        
        if achievementsArray.count > 0 {
            
            self.presenter?.achievementFetchedSuccess(achievementModelArray: achievementsArray)
            
        } else {
            
            self.presenter?.achievementFetchFailed()
            
        }
    }


        
    func getAchievements(ids: [Int]){
        
        GuildWarsProvider.rx.request(.achievements(ids)).mapArray(AchievementModel.self).subscribe { event -> Void in
            switch event {
            case .success(let achievements):
                print(achievements.description)
                 self.presenter?.achievementFetchedSuccess(achievementModelArray: achievements)
                self.insertAchievements(achievements: achievements)
            case .error(let error):
                print(error.localizedDescription)
                self.presenter?.achievementFetchFailed()
            }
            }.disposed(by: disposeBag)
        
    }
    
}
