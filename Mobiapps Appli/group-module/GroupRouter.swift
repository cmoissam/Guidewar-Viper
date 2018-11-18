//
//  GroupRouter.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/16/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit

class GroupRouter:PresenterToRouterProtocol{

    
    
    static func createModule() -> GroupViewController {
        
        let view = GroupViewController()
        
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = GroupPresenter()
        let interactor: PresenterToInteractorProtocol = GroupInteractor()
        let router:PresenterToRouterProtocol = GroupRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter

        
        return view
        
    }
    
    
    func pushToCategoryScreen(navigationConroller navigationController:UINavigationController,category:CategoryModel) {
        
        let categoryModule = CategoryRouter.createModule(category: category)
        navigationController.pushViewController(categoryModule,animated: true)
        
    }
    
}
