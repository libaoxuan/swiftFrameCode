//
//  UIBarButton+Extensions.swift
//  Swift练习
//
//  Created by ME294 on 2018/3/22.
//  Copyright © 2018年 EDZ. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    convenience init(title: String, fonSize: CGFloat = 16, target: AnyObject, action: Selector,isBack: Bool = false) {
        let btn: UIButton = UIButton.cz_textButton(title, fontSize: fonSize, normalColor: UIColor.darkGray, highlightedColor: UIColor.orange)
        if isBack {
            let imageName = "navigationbar_back_withtext"
            
            btn.setImage(UIImage(named: imageName), for: UIControlState(rawValue: 0))
            btn.setImage(UIImage(named: imageName + "_highlighted"), for: .highlighted)
        }
        
        btn.addTarget(target, action: action, for: .touchUpInside)
        // self.init 实例化 UIBarButtonItem
        self.init(customView: btn)
    }
    
    
}
