//
//  BXNavigationController.swift
//  Swift练习
//
//  Created by EDZ on 2018/3/21.
//  Copyright © 2018年 EDZ. All rights reserved.
//

import UIKit

class BXNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 隐藏默认的 navigationBar
        navigationBar.isHidden = true
    }
    
    
    // 重写push 方法  所有的push 动作都会调用此方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 如果不是栈底控制器才需要隐藏，根控制器不需要处理
        if childViewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            // 判断控制器的类型
            if let vc = viewController as? BXBaseTableViewController{
                var title = "返回"
                //
                if childViewControllers.count == 1 {
                    // title 显示首页的标题
                    title = childViewControllers.first?.title ?? "返回"
                }
                // 取出自定义的navItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popToParent))
            }
            
            
        }
        super .pushViewController(viewController, animated: true)
    }
    
    // POP 返回到上一级控制器
    @objc private func popToParent() {
        popViewController(animated: true)
    }
    

}
