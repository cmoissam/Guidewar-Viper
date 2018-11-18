//
//  AchievementProtocol.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import Foundation
import UIKit

protocol ViewToAchievementPresenterProtocol: class{
    
    var view: PresenterToAchievementViewProtocol? {get set}
    var interactor: PresenterToAchievementInteractorProtocol? {get set}
    var router: PresenterToAchievementRouterProtocol? {get set}
    func startFetchingAchievement()
    
}

protocol PresenterToAchievementViewProtocol: class{
    func showAchievement(achievement:AchievementModel)

}

protocol PresenterToAchievementRouterProtocol: class {
    static func createModule(Achievement : AchievementModel)-> AchievementViewController

}

protocol PresenterToAchievementInteractorProtocol: class {
    var presenter:InteractorToAchievementPresenterProtocol? {get set}
    var achievement : AchievementModel? {get set}
    func fetchAchievement()
}

protocol InteractorToAchievementPresenterProtocol: class {
    func achievementFetchedSuccess(achievement:AchievementModel)
}
