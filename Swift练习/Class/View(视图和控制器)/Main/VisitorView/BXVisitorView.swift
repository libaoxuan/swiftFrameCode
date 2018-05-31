//
//  BXVisitorView.swift
//  Swift练习
//
//  Created by ME294 on 2018/3/26.
//  Copyright © 2018年 EDZ. All rights reserved.
//

import UIKit

// 访客视图
class BXVisitorView: UIView {

    // 注册按钮
    lazy  var registerButton: UIButton = UIButton.cz_textButton("注册", fontSize: 16, normalColor: UIColor.orange, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    // 登录按钮
    lazy  var loginButton: UIButton = UIButton.cz_textButton("登录", fontSize: 16, normalColor: UIColor.darkGray, highlightedColor: UIColor.black, backgroundImageName: "common_button_white_disable")
    
    // 访客视图的信息字典[imageName / message]
    // 如果是首页 imageName = ""
    var visitorInfoDictionary: [String: String]?{
        didSet{
            // 1> 取字典信息
            guard let imageName = visitorInfoDictionary?["imageName"],
                let message = visitorInfoDictionary?["message"] else {
                    return
            }
            
            // 2> 设置消息
            tipLabel.text = message
            
            // 3> 设置图像,首页不需要设置
            if imageName == "" {
                startAnimation()
                return
            }
            iconView.image = UIImage(named: imageName)
            
            // 其他控制器的访客视图不需要显示小房子和阴影
            houseIconView.isHidden = true
            maskIconView.isHidden = true
            
        }
    }
    
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 旋转图片动画(首页)
    private func startAnimation() {
        let animsion = CABasicAnimation(keyPath: "transform.rotation")
        
        animsion.toValue = 2 * M_PI  // 转的角度
        animsion.repeatCount = MAXFLOAT  // 转几圈
        animsion.duration = 15 // 持续时间
        // 动画完成不删除,如果 iconView 被释放,动画会一起销毁
        animsion.isRemovedOnCompletion = false
        
        // 将动画添加到图层
        iconView.layer.add(animsion, forKey: nil)
        
    }
    
    
    // MARK: - 私有控件
    // 懒加载属性只有调用UIKit 控件的指定构造函数,其他都需要使用类型
    // 图像视图
    private lazy  var iconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
    // 灰色阴影图片 -- 不要使用maskView
    private lazy  var maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
    // 小房子
    private lazy  var houseIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))

    // 提示标签
    private lazy  var tipLabel: UILabel = UILabel.cz_label(withText: "关注一些人,回这里看看有什么惊喜关注一些人,回这里看看有什么惊喜", fontSize: 14, color: UIColor.darkGray)
    
    
    
    
}
// MARK: - 设置界面
extension BXVisitorView {
    
    func setupUI() {
        backgroundColor = UIColor.cz_color(withHex: 0xEDEDED)
        
        // 1.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(tipLabel)
        addSubview(registerButton)
        addSubview(loginButton)
        
        // 文本居中
        tipLabel.textAlignment = .center
        
        // 2. 取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 3. 自动布局
        let margin: CGFloat = 20.0
        
        // 图像视图
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -60))
        
        // 小房子布局
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView, attribute: .centerY, relatedBy: .equal, toItem: iconView, attribute: .centerY, multiplier: 1.0, constant: 0))
        
        // 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .centerX, relatedBy: .equal, toItem: iconView, attribute: .centerX, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .top, relatedBy: .equal, toItem: iconView, attribute: .bottom, multiplier: 1.0, constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 236))

        // 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .left, relatedBy: .equal, toItem: tipLabel, attribute: .left, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 100))

        
        
        // 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .right, relatedBy: .equal, toItem: tipLabel, attribute: .right, multiplier: 1.0, constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .top, relatedBy: .equal, toItem: tipLabel, attribute: .bottom, multiplier: 1.0, constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton, attribute: .width, relatedBy: .equal, toItem: registerButton, attribute: .width, multiplier: 1.0, constant: 0))
        
        // 遮罩图像
//        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0))
//        addConstraint(NSLayoutConstraint(item: maskIconView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: 0))
        let viewDict = ["maskIconView" :maskIconView,
                        "registerButton": registerButton] as [String : Any]
        let metrics = ["spacing": -20]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconView]-0-|", options: [], metrics: nil, views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-(spacing)-[registerButton]", options:[], metrics: metrics, views: viewDict))
        
    }
    
}

