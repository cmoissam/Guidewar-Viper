//
//  AchievementViewController.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/17/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit

class AchievementViewController: UIViewController {

    
    var presentor:ViewToAchievementPresenterProtocol?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var requirementLabel: UILabel!
    @IBAction func shareAction(_ sender: Any) {
        
        let shareUrl = URL.init(string: "https://wiki.guildwars2.com/wiki/API:2/achievements")
        let vc = UIActivityViewController(activityItems: [shareUrl!], applicationActivities: [])
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Achievement"
        presentor?.startFetchingAchievement()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension AchievementViewController:PresenterToAchievementViewProtocol{
    
    
    func showAchievement(achievement: AchievementModel) {
        
        self.nameLabel.text = achievement.name
        self.descriptionLabel.text = achievement.desc
        self.requirementLabel.text = achievement.requirement
    }
    
}
