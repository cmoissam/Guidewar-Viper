//
//  GroupProtocol.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/15/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func startFetchingCategory()
    func showCategoryController(navigationController:UINavigationController,category:CategoryModel)
    
}

protocol PresenterToViewProtocol: class{
    func showCategory(categoryArray:Array<CategoryModel>, groupArray:Array<GroupModel>)
    func showError()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> GroupViewController
    func pushToCategoryScreen(navigationConroller:UINavigationController,category:CategoryModel)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func fetchCategory()
}

protocol InteractorToPresenterProtocol: class {
    func categoryFetchedSuccess(categoryModelArray:Array<CategoryModel>,  groupModelArray:Array<GroupModel>)
    func categoryFetchFailed()
}
