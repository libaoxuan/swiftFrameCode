//
//  BXHomeViewController.swift
//  Swift练习
//
//  Created by EDZ on 2018/3/21.
//  Copyright © 2018年 EDZ. All rights reserved.
//

import UIKit

// 定义全局变量,尽量使用private 修饰,否则到处引用
let cellId = "cellId"

class BXHomeViewController: BXBaseTableViewController {
    
   
    // 微博数据数组
    private lazy var statusList = [String]()
    // 加载数据
    override func loadData() {
        print("开始加载数据")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            
            for i in 0..<20 {
                if self.isPullup {
                    // 将数据追加到底部
                    self.statusList.append("上拉 \(i)")
                }else{
                    // 将数据插入到数组的顶部
                    self.statusList.insert(i.description, at: 0)
                }
               
            }
            print("刷新列表")
            // 结束刷新控件
            self.refreshControl?.endRefreshing()
            // 恢复状态
            self.isPullup = false
            // 刷新列表
            self.tableView?.reloadData()
            
        }
        
        
    }
    
    // 显示好友
    @objc private func showFriends() {
        print(#function)
        let vc = BXDemoViewController()
        vc.hidesBottomBarWhenPushed = true
      navigationController?.pushViewController(vc, animated: true)
    }
    
}
// MARK: - 表格数据源方法
extension BXHomeViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //  1. 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        // 2. 设置cell
        cell.textLabel?.text = statusList[indexPath.row]
        // 3. 返回cell
        return cell
    }
   
}


// MARK: - 设置界面
extension BXHomeViewController{
    
    override func setupTableView() {
        super.setupTableView()
        // 设置导航栏按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "好友",  target: self, action: #selector(showFriends))
        
        // 注册原型 cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
    }
    
    
}
