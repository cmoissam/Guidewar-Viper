//
//  GroupPresenter.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/16/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit
import Foundation

class GroupPresenter:ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func startFetchingCategory() {
        interactor?.fetchCategory()
    }
    
    func showCategoryController(navigationController: UINavigationController,category:CategoryModel) {
        router?.pushToCategoryScreen(navigationConroller:navigationController,category:category)
    }
    
}

extension GroupPresenter: InteractorToPresenterProtocol{
 
    
    func categoryFetchedSuccess(categoryModelArray: Array<CategoryModel>, groupModelArray: Array<GroupModel>) {
        view?.showCategory(categoryArray: categoryModelArray, groupArray: groupModelArray)
    }
    
    func categoryFetchFailed() {
        view?.showError()
}

}


