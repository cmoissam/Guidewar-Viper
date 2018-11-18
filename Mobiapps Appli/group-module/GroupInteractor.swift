//
//  GroupInteractor.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/16/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import Foundation
//import Alamofire
import ObjectMapper
import RxSwift
import Moya_ObjectMapper
import CoreData
import Reachability

class GroupInteractor: PresenterToInteractorProtocol{
    
    var presenter: InteractorToPresenterProtocol?

    let reachability = Reachability()!
    
    
    
    var groups : Array<GroupModel>?

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func fetchCategory() {
        
        
        if reachability.connection != .none{
        
            self.getGroupsIds()
            
        }
        else{

            self.getcategoriesFromBase()

        }
        
        
    }
    
    func getGroupsFromBase() -> Array<GroupModel>{
        
        let managedContext = self.appDelegate?.persistentContainer.viewContext
        let groupFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Groups")
        
        let groups = try! managedContext?.fetch(groupFetch) as! [Groups]

        var groupArray = Array<GroupModel>()
        for groupDao in groups {
            groupArray.append(groupDao.fromDaoToGroupModel())

        }
        
        return groupArray
    }
    
    func getcategoriesFromBase(){
        
        let groups : Array<GroupModel> = self.getGroupsFromBase()
        
        if groups.count > 0 {
            
            let managedContext = self.appDelegate?.persistentContainer.viewContext
            let categoryFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
            let categories = try! managedContext?.fetch(categoryFetch) as! [Categories]
            var categoriesArray = Array<CategoryModel>()

            for gategoryDao in categories {
                categoriesArray.append(gategoryDao.fromDaoToCategoryModel())
                
            }
            self.presenter?.categoryFetchedSuccess(categoryModelArray: categoriesArray, groupModelArray: groups)
            
        }
        else {
             self.presenter?.categoryFetchFailed()
        }

    }
    
 
    func insertGroups(groups: Array<GroupModel>){

            let managedContext = self.appDelegate?.persistentContainer.viewContext


            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Groups")

            // Create Batch Delete Request
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try managedContext?.execute(batchDeleteRequest)

            } catch {
                // Error Handling
            }

        let groupEntity = NSEntityDescription.entity(forEntityName: "Groups", in: managedContext!)!
        for group in groups {
            let newGroup = NSManagedObject(entity: groupEntity, insertInto: managedContext)
            newGroup.setValue(group.id, forKeyPath: "id")
            newGroup.setValue(group.name, forKeyPath: "name")
            newGroup.setValue(group.desc, forKey: "desc")
            newGroup.setValue(group.order, forKey: "order")
            
        }

        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func insertCategories(categories: Array<CategoryModel>){
        
        let managedContext = self.appDelegate?.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Categories")
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try managedContext?.execute(batchDeleteRequest)
            
        } catch {
            // Error Handling
        }
        
        let groupEntity = NSEntityDescription.entity(forEntityName: "Categories", in: managedContext!)!
        for category in categories {
            let newCategory = NSManagedObject(entity: groupEntity, insertInto: managedContext)
            newCategory.setValue(category.id, forKeyPath: "id")
            newCategory.setValue(category.name, forKeyPath: "name")
            newCategory.setValue(category.icon, forKeyPath: "icon")
            newCategory.setValue(category.desc, forKey: "desc")
            newCategory.setValue(category.order, forKey: "order")
            newCategory.setValue(self.categoryGroupId(category: category), forKey: "group_id")
            
        }
        
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func categoryGroupId(category:CategoryModel) -> String{
        
        for group in self.groups!{
            
            if (group.categories?.contains(category.id!))!{
                
                return group.id!
            }
            
            
        }
        return ""
        
    }
    
    let disposeBag = DisposeBag()
    
    
    func getCategories(ids: Array<Int>,groups:Array<GroupModel>) {
            
            GuildWarsProvider.rx.request(.categories(ids)).mapArray(CategoryModel.self).subscribe { event -> Void in
                switch event {
                case .success(let categories):
                    self.presenter?.categoryFetchedSuccess(categoryModelArray: categories, groupModelArray: groups)
                    self.insertCategories(categories: categories)
                case .error(let error):
                    print(error)
                    self.presenter?.categoryFetchFailed()
                }
                }.disposed(by: disposeBag)
        }

        
        func getGroupsIds(){
            GuildWarsProvider.rx.request(.groupsId).mapJSON().subscribe { event -> Void in
                switch event {
                case .success(let groupsIds):
                    self.getGroups(ids: groupsIds as! Array<String>)
                case .error(let error):
                    print(error.localizedDescription)
                }
                }.disposed(by: disposeBag)
            
        }
        
        func getGroups(ids: Array<String>) {
            GuildWarsProvider.rx.request(.groups(ids)).mapArray(GroupModel.self).subscribe { event -> Void in
                switch event {
                case .success(let groups):
                   self.insertGroups(groups: groups)
                   var categoriesIds : Array<Int> = Array()
                   for group in groups{
                    categoriesIds += group.categories!
                   }
                   self.groups = groups
                   self.getCategories(ids: categoriesIds, groups: groups)
                case .error(let error):
                    print(error.localizedDescription)
                }
                }.disposed(by: disposeBag)
        }
    
}
