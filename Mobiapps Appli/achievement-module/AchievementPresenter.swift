//
//  AchievementPresenter.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit

class AchievementPresenter: ViewToAchievementPresenterProtocol {

    var view: PresenterToAchievementViewProtocol?
    
    var interactor: PresenterToAchievementInteractorProtocol?
    
    var router: PresenterToAchievementRouterProtocol?
    
    
    
    func startFetchingAchievement() {
        interactor?.fetchAchievement()
    }
  
    
}

extension AchievementPresenter: InteractorToAchievementPresenterProtocol{
    
    func achievementFetchedSuccess(achievement: AchievementModel) {
        view?.showAchievement(achievement: achievement)
    }
    
    
}
