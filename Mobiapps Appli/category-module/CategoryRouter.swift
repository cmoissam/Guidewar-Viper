//
//  GroupRouter.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit

class CategoryRouter: PresenterToCategoryRouterProtocol {
   
    
    
    
    
    static func createModule(category : CategoryModel) -> CategoryViewController {
        
        let view = CategoryViewController()
        
        let presenter: ViewToCategoryPresenterProtocol & InteractorToCategoryPresenterProtocol = CategoryPresenter()
        let interactor: PresenterToCategoryInteractorProtocol = CategoryInteractor()
        let router:PresenterToCategoryRouterProtocol = CategoryRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.category = category
        return view
        
    }
    
    func pushToAchievementScreen(navigationConroller: UINavigationController, achievement: AchievementModel) {
        let achievementModule = AchievementRouter.createModule(Achievement: achievement)
        navigationConroller.pushViewController(achievementModule,animated: true)
    }

}
