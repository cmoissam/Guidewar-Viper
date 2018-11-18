//
//  AchievementInteractor.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit

class AchievementInteractor: PresenterToAchievementInteractorProtocol {


    var presenter: InteractorToAchievementPresenterProtocol?
    
    
    var achievement: AchievementModel?
    
    
    func fetchAchievement() {
        
        self.presenter?.achievementFetchedSuccess(achievement: achievement!)
        
    }
    
}
