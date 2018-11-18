//
//  CategoryViewController.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/15/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {
    
    var presentor:ViewToCategoryPresenterProtocol?
    @IBOutlet weak var achievementsTable: UITableView!
    var achievementArrayList:Array<AchievementModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Achievements"
        presentor?.startFetchingAchievement()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        achievementsTable.delegate = self
        achievementsTable.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CategoryViewController:PresenterToCategoryViewProtocol{
    
    
    func showAchievement(achievementArray: Array<AchievementModel>) {
        
        self.achievementArrayList = achievementArray
        
        self.achievementsTable.reloadData()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func showError() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Categories", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    
}

extension CategoryViewController:UITableViewDelegate, UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Using Swift's optional lookup we first check if there is a valid section of table.
        // Then we check that for the section there is data that goes with.
        
        return achievementArrayList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
        }
        
        cell?.textLabel?.text = achievementArrayList[indexPath.row].name
        cell?.detailTextLabel?.text = achievementArrayList[indexPath.row].requirement
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        presentor?.showAchievementController(navigationController: navigationController!, achievement: achievementArrayList[indexPath.row])
        
}

}
