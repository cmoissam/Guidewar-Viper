//
//  CategoryPresenter.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit

class CategoryPresenter: ViewToCategoryPresenterProtocol {

    var view: PresenterToCategoryViewProtocol?
    
    var interactor: PresenterToCategoryInteractorProtocol?
    
    var router: PresenterToCategoryRouterProtocol?
    
    
    
    func startFetchingAchievement() {
        interactor?.fetchAchievement()
    }
    
    func showAchievementController(navigationController: UINavigationController, achievement: AchievementModel) {
        router?.pushToAchievementScreen(navigationConroller:navigationController,achievement: achievement)
    }

    
}

extension CategoryPresenter: InteractorToCategoryPresenterProtocol{
    
    func achievementFetchedSuccess(achievementModelArray: Array<AchievementModel>) {
        view?.showAchievement(achievementArray: achievementModelArray)
    }
    
    func achievementFetchFailed() {
         view?.showError()
    }

}
