//
//  CategoryProtocol.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToCategoryPresenterProtocol: class{
    
    var view: PresenterToCategoryViewProtocol? {get set}
    var interactor: PresenterToCategoryInteractorProtocol? {get set}
    var router: PresenterToCategoryRouterProtocol? {get set}
    func startFetchingAchievement()
    func showAchievementController(navigationController:UINavigationController,achievement:AchievementModel)
    
}

protocol PresenterToCategoryViewProtocol: class{
    func showAchievement(achievementArray:Array<AchievementModel>)
    func showError()
}

protocol PresenterToCategoryRouterProtocol: class {
    static func createModule(category : CategoryModel)-> CategoryViewController
    func pushToAchievementScreen(navigationConroller:UINavigationController,achievement:AchievementModel)
}

protocol PresenterToCategoryInteractorProtocol: class {
    var presenter:InteractorToCategoryPresenterProtocol? {get set}
    var category : CategoryModel? {get set}
    func fetchAchievement()
}

protocol InteractorToCategoryPresenterProtocol: class {
    func achievementFetchedSuccess(achievementModelArray:Array<AchievementModel>)
    func achievementFetchFailed()
}

