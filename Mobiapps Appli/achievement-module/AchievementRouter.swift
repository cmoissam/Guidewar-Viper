//
//  AchievementRouter.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit

class AchievementRouter: PresenterToAchievementRouterProtocol {
    
    
    
    static func createModule(Achievement achievement : AchievementModel) -> AchievementViewController {
        
        let view = AchievementViewController()
        
        let presenter: ViewToAchievementPresenterProtocol & InteractorToAchievementPresenterProtocol = AchievementPresenter()
        let interactor: PresenterToAchievementInteractorProtocol = AchievementInteractor()
        let router:PresenterToAchievementRouterProtocol = AchievementRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.achievement = achievement
        
        
        
        return view
        
    }
  

}

