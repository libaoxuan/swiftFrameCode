//
//  BXDemoViewController.swift
//  Swift练习
//
//  Created by ME294 on 2018/3/22.
//  Copyright © 2018年 EDZ. All rights reserved.
//

import UIKit

class BXDemoViewController: BXBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "第\(navigationController?.childViewControllers.count ?? 0)个"
    }

    
    @objc private func showNext()  {
        
        let vc = BXDemoViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    

}

extension BXDemoViewController{
    
     override func setupTableView() {
        super.setupTableView()
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", target: self, action: #selector(showNext))
    }
  
}
