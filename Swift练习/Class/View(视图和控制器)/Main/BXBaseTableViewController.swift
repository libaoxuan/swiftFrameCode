//
//  BXBaseTableViewController.swift
//  Swift练习
//
//  Created by EDZ on 2018/3/21.
//  Copyright © 2018年 EDZ. All rights reserved.
//

import UIKit

class BXBaseTableViewController: UIViewController {

    // cloneSwiftCode 修改了一些新的东西,提交看看冲突不
    // 自定义tableview
    var tableView: UITableView?
    // 刷新控件
    var refreshControl: UIRefreshControl?
    // 上拉刷新标记
    var isPullup = false
    // 是否登录
    var userLogin = false
    // 设置
    var visitorInfo: [String: String]?
    
    // 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.cz_screenWidth(), height: 64))
    
    // 自定义的导航条目
    lazy var navItem = UINavigationItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 测试看看修改副分支会不会冲突
    // 撒发顺丰第六届卡萨链接客服到家了卡士大夫
        setupUI()
        loadData()
    }
    override var title: String?{
        didSet{
            navItem.title = title
        }
    }
    
    // 加载数据 - 具体的实现由子类负责
    @objc func loadData() {
        refreshControl?.endRefreshing()
    }
    
}
// MARK: - 访客视图登录注册监听方法
extension BXBaseTableViewController{
    @objc private func login(){
        print("用户登录")
    }
    @objc private func register() {
        print("用户注册")
    }
}


// MARK: - 设置界面
extension BXBaseTableViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.cz_random()
        
        // 取消自动缩进
        automaticallyAdjustsScrollViewInsets = false
        setupNavigationBar()
        setupTableView()
        
        userLogin ? setupTableView() : setupVisitorView()
    }
    
    // 设置表格视图 - 用户登录之后执行
    @objc func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView!, belowSubview: navigationBar)
        // 设置数据源&代理 --> 目的: 子类直接实现数据源方法
        tableView?.dataSource = self
        tableView?.delegate = self
        
        // 设置内容缩进
        tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height, left: 0, bottom: 0, right: 0)
        
        // 设置刷新控件
        // 1> 实例化控件
        refreshControl = UIRefreshControl()
        
        // 2> 添加到表格视图
        tableView?.addSubview(refreshControl!)
        
        // 3> 添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    // MARK: - 初始化访客视图
    private func setupVisitorView() {
        let visitorView = BXVisitorView(frame: view.bounds)
       
        view.insertSubview(visitorView, belowSubview: navigationBar)
        visitorView.visitorInfoDictionary = visitorInfo
        
        // 添加监听方法
        visitorView.loginButton .addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton .addTarget(self, action: #selector(register), for: .touchUpInside)
        
        // 3. 设置导航条按钮
        navItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .plain, target: self, action: #selector(login))
    }
    // 设置导航条
    private func setupNavigationBar(){
        // 添加导航条
        view.addSubview(navigationBar)
        
        print("=======打印一下=======\(navigationBar)")
        // 将 item 设置给bar
        navigationBar.items = [navItem]
        
        // 1>设置navbar 整个背景的渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xf6f6f6)
        // 2> 设置 navBar 的字体颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.darkGray]
        
        // 3> 设置系统按钮的文字渲染颜色
        navigationBar.tintColor = UIColor.orange
    }
    
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension BXBaseTableViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // 在显示最后一行的时候,做上啦刷新; 即将显示
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // 1. 判断 indexpath 是否是最后一行
        // (indexPath.section(最大)) / indexPath.row(最后一行)
        // 1> row
        let row = indexPath.row
        // 2> section
        let section = tableView.numberOfSections - 1
        
        if row < 0 || section < 0 {
            return
        }
        
        // 3> 行数
        let count = tableView.numberOfRows(inSection: section)
        // 如果是最后一行,同时没有开始上啦刷新
        if row == (count - 1) && !isPullup {
//            print("上啦刷新")
            isPullup = true
            loadData()
        }
        
        print("section -- \(section)")
        
        
    }
    
}
