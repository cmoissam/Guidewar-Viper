//
//  GroupViewController.swift
//  Mobiapps Appli
//
//  Created by Lanouari on 11/15/18.
//  Copyright © 2018 Lanouari. All rights reserved.
//

import UIKit
import SDWebImage

class GroupViewController: UIViewController {

    var presentor:ViewToPresenterProtocol?
    @IBOutlet weak var categoriesTable: UITableView!
    var categoryArrayList:Array<CategoryModel> = Array()
    var groupArrayList:Array<GroupModel> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        categoriesTable.accessibilityIdentifier = "categories"
        self.title = "Categories"
        presentor?.startFetchingCategory()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        categoriesTable.delegate = self
        categoriesTable.dataSource = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension GroupViewController:PresenterToViewProtocol{
    
    
    func showCategory(categoryArray: Array<CategoryModel>, groupArray: Array<GroupModel>) {
        
        self.categoryArrayList = categoryArray
        self.groupArrayList = groupArray
        self.categoriesTable.reloadData()
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
    
    func showError() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching Categories", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension GroupViewController:UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return groupArrayList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupArrayList[section].name
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Using Swift's optional lookup we first check if there is a valid section of table.
        // Then we check that for the section there is data that goes with.
        
        return categoryArrayList.count
    }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "reuseIdentifier")
            }
            
            cell?.textLabel?.text = categoryArrayList[indexPath.row].name
            cell?.detailTextLabel?.text = categoryArrayList[indexPath.row].desc
            cell?.imageView?.sd_setImage(with: URL(string: categoryArrayList[indexPath.row].icon!), placeholderImage: UIImage(named: "tenor.gif"))
            
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            presentor?.showCategoryController(navigationController: navigationController!,category:categoryArrayList[indexPath.row])
            
        }
        
    
}


