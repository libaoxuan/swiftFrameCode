//
//  BXMainViewController.swift
//  Swift练习
//
//  Created by EDZ on 2018/3/21.
//  Copyright © 2018年 EDZ. All rights reserved.
//

import UIKit

class BXMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildControllers()
        setupComposeButton()
        
    }
    
    /**
     portrait : 竖屏，肖像
     landscape : 横屏，风景画
     - 设置代码控制设备的方向，好处，可以在需要横屏的时候单独处理！
     - 设置支持的方向后，当前的控制器及自控制器都会遵守这个方向！
     - 如果播放视频，通常是通过modal 展现的！
     */
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        return .portrait
    }
    
    // mark: -- 监听方法
    // 撰写微博
    // FIXME: 没有实现
    // private 能够保证方法私有,仅在当前对象被访问
    // @objc 允许这个函数在'运行时'通过 OC 的消息机制被调用
    @objc private func composeStatus() {
        print("撰写微博")
        // 测试方向旋转
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.purple
        
        let nav = UINavigationController(rootViewController: vc)
        
        present(nav, animated: true, completion: nil)
        
    }
    
    // mark -- 私有控件
    //撰写按钮
     private lazy var composeButton: UIButton = UIButton.cz_imageButton("tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
    
    private func setupComposeButton() {
        tabBar.addSubview(composeButton)
        
        // 计算按钮的宽度
        let count = CGFloat(childViewControllers.count)
        // 将向内缩进的宽度减少，能够让按钮的宽度变大，盖住容错点，防止穿帮
        let w = tabBar.bounds.width / count - 1
        
        // CGRectInset 正数向内缩进，负数向外扩展
        composeButton.frame = tabBar.bounds.insetBy(dx: w * 2, dy: 0)
        composeButton.addTarget(self, action: #selector(composeStatus), for: .touchUpInside)
        print("撰写按钮宽度 \(composeButton.bounds.width)")
    }
    // 设置所有子控制器
    private func setupChildControllers(){
        // 0.获取沙盒 json路径
        let  docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let  jsonPath = (docDir as String).appending("/main.json")
        // 加载 data
        var data = NSData(contentsOfFile: jsonPath)
        // 判断 data 是否有内容,如果没有,说明本地沙盒没有数据
        if data == nil{
            // 从 bundle 加载 data
            let path = Bundle.main.path(forResource: "main.json", ofType: nil)
            data = NSData(contentsOfFile: path!)
        }
        // 从 bundle 加载配置的 json
        // 1.路径/ 2.加载 NSData / 3.反序列化转换成数组
        guard let array = try? JSONSerialization.jsonObject(with: data as! Data, options: []) as? [[String : AnyObject]]

        else {
            return
        }
        var arrayM = [UIViewController]()
        for dict in array! {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM;
    }
    
    // 使用字典创建一个子控制器
    // - parameter dict: 信息字典[clsName, title, imageName]
    // - returns: 子控制器
    private func controller(dict: [String: AnyObject]) -> UIViewController{
        
        // 1. 取得字典内容
        guard let clsName = dict["clsName"] as? String,
            let title = dict["title"] as? String,
            let imageName = dict["imageName"] as? String,
            let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? BXBaseTableViewController.Type,
            let visitorDict = dict["visitorInfo"] as? [String :String]
            else{
                return UIViewController()
        }
        // 2. 创建视图控制器
        let vc = cls.init()
        
        // 3. 设置图像控制器
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName);
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        // 4. 设置tabbar的标题字体
        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .highlighted)
//        // 可以设置字体大小
//        vc.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)] , for: UIControlState(rawValue: 0))
        vc.title = title
        vc.visitorInfo = visitorDict
        let nav = BXNavigationController(rootViewController: vc)
        
        return nav
    }

    

}
