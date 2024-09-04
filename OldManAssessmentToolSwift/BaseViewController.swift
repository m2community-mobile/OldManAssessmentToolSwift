//
//  BaseViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 22/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var naviBar : UIView!
    var titleLabel : UILabel!
    var backButton : ImageButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        self.view.backgroundColor = UIColor.white
        
        let bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: SCREEN.HEIGHT))
        bgImageView.image = UIImage(named: "bg")
        self.view.addSubview(bgImageView)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: STATUS_BAR_HEIGHT))
        self.view.addSubview(statusBar)
        
        naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: SCREEN.WIDTH, height: NAVIGATION_BAR_HEIGHT))
        self.view.addSubview(naviBar)
        
        backButton = ImageButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "btn_d_back2"), ratio: 1)
        backButton.addTarget(event: .touchUpInside) { (button) in
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.addSubview(backButton)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH - (backButton.frame.size.width * 2), height: naviBar.frame.size.height))
        titleLabel.center.x = SCREEN.WIDTH / 2
        titleLabel.text = "노인평가도구"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont(name: NanumSquareR, size: 20)
        if IS_IPHONE_SE {
            titleLabel.font = UIFont(name: NanumSquareR, size: 17.5)
        }
        titleLabel.textAlignment = .center
        naviBar.addSubview(titleLabel)
        
        let separaterView1 = UIView(frame: CGRect(x: 0, y: naviBar.frame.size.height - 0.5, width: SCREEN.WIDTH, height: 0.5))
        separaterView1.center.x = SCREEN.WIDTH / 2
        separaterView1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        naviBar.addSubview(separaterView1)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         // 네비게이션 바 숨기기
         self.navigationController?.setNavigationBarHidden(true, animated: animated)
     }
   
    
}



