//
//  MainViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 21/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//


import UIKit
import FontAwesome_swift





class MainViewController: UIViewController {
    
    
    
    var naviLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        print("USER_ID:\(UserDefaults.standard.value(forKey: "USER_ID"))")
        
        
        if var viewControllers = self.navigationController?.viewControllers {
            while viewControllers.first != self {
                viewControllers.removeFirst()
            }
            self.navigationController?.viewControllers = viewControllers
        }
        self.view.backgroundColor = UIColor.white
        
        let bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: SCREEN.HEIGHT))
        bgImageView.image = UIImage(named: "bg")
        self.view.addSubview(bgImageView)
        
        
        
        //노인평가도구
        var titleLabelFontSize : CGFloat {
            if IS_IPHONE_N {
                return 45
            }
            if IS_IPHONE_SE {
                return 40
            }
            return 50
        }
        var titleLabelCenterY : CGFloat {
            if IS_IPHONE_N {
                return SCREEN.HEIGHT * 0.2
            }
            if IS_IPHONE_SE {
                return SCREEN.HEIGHT * 0.15
            }
            return SCREEN.HEIGHT * 0.23
        }
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: SCREEN.HEIGHT * 0.25))
        titleLabel.text = "노인평가도구"
        titleLabel.font = UIFont(name: NanumSquareR, size: titleLabelFontSize)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.center.x = SCREEN.WIDTH / 2
        titleLabel.center.y = titleLabelCenterY
        self.view.addSubview(titleLabel)
        
        
        let subTitle = UILabel(frame: CGRect(x: 0, y: titleLabel.frame.maxY + 10, width: SCREEN.WIDTH, height: 50))
        subTitle.text = "Geriatric Screening Tool"
        subTitle.font = UIFont(name: NanumSquareR, size: titleLabelFontSize)
        subTitle.textAlignment = .center
        subTitle.textColor = UIColor.white
        subTitle.font = UIFont.systemFont(ofSize: 26)
        subTitle.sizeToFit()
        subTitle.center.x = SCREEN.WIDTH / 2
        subTitle.center.y = titleLabelCenterY + 50
        self.view.addSubview(subTitle)
        
        
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: STATUS_BAR_HEIGHT))
//        statusBar.backgroundColor = UIColor.random.withAlphaComponent(0.3)
        self.view.addSubview(statusBar)
        
        let naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: SCREEN.WIDTH, height: NAVIGATION_BAR_HEIGHT))
//        naviBar.backgroundColor = UIColor.random.withAlphaComponent(0.3)
        self.view.addSubview(naviBar)
        
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        naviBar.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        let settingButton = ImageButton(frame: CGRect(x: naviBar.frame.size.width - naviBar.frame.size.height, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "btn_set"), ratio: 1)
        naviBar.addSubview(settingButton)
        settingButton.addTarget(event: .touchUpInside) { (button) in
            let settingVC = SettingViewController()
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
        
        //로고
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        logoImageView.setImageWithFrameWidth(image: UIImage(named: "logo"))
        logoImageView.center.x = SCREEN.WIDTH / 2
        logoImageView.frame.origin.y = SCREEN.HEIGHT - SAFE_AREA - logoImageView.frame.size.height - 15
        self.view.addSubview(logoImageView)
        
        let innerView = UIView(frame: CGRect(x: 0, y: (titleLabel.frame.maxY), width: SCREEN.WIDTH, height: logoImageView.frame.minY - titleLabel.frame.maxY))
//        innerView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        self.view.addSubview(innerView)
        
        let innerView2 = UIView(frame: innerView.bounds)
        innerView2.frame.size.height *= 0.95
//        innerView2.center = innerView.frame.center
//        innerView2.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        innerView.addSubview(innerView2)
        
        let buttonGap : CGFloat = 20
        let buttonWidth : CGFloat = innerView2.frame.size.width * 0.85
        let buttonHeight : CGFloat = (innerView2.frame.size.height - (buttonGap * 2)) / 3
        for i in 0..<MAIN_CONTENT_INFOS.count {
//            buttonInfos
            let button = MainButton(frame: CGRect(x: 0, y: CGFloat(i) * (buttonHeight + buttonGap), width: buttonWidth, height: buttonHeight), index: i, infoDic: MAIN_CONTENT_INFOS[i])
            button.center.x = innerView2.frame.size.width / 2
            innerView2.addSubview(button)
            
            button.addTarget(event: .touchUpInside) { (button) in
                print("i:\(i)")
                
                let nextVC = ToolViewController()
                nextVC.index = i
                nextVC.infoDic = MAIN_CONTENT_INFOS[i]
                self.navigationController?.pushViewController(nextVC, animated: true)
                
            }
        }

    }
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//         // 네비게이션 바 숨기기
//         self.navigationController?.setNavigationBarHidden(true, animated: animated)
//     }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("ko"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("en"), object: nil)
        print("--->\(naviLabel)")
        

        if naviLabel.text == "ko" {
            //한국어로 변경
                  UserDefaults.standard.set(["ko"], forKey: "AppleLanguages")
                  UserDefaults.standard.synchronize()
                  
                  //보통 메인화면으로 이동시켜줌
            setLanguage()
            
            
        }
        if naviLabel.text == "en" {
            //영어로 변경
                   UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
                   UserDefaults.standard.synchronize()
                   
                   //보통 메인화면으로 이동시켜줌
                   setLanguage()
            
         
        }
        
    }
    
    @objc func la(_ sender: UIButton) {
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
    }
//
//
//
//
//
//
//
    func setLanguage() {
        
        //설정된 언어 코드 가져오기
        let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String // 초기에 "ko-KR" , "en-KR" 등으로 저장되어있음
        let index = language.index(language.startIndex, offsetBy: 2)
        let languageCode = String(language[..<index]) //"ko" , "en" 등
        
        //설정된 언어 파일 가져오기
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundle = Bundle(path: path!)
        
//        idView.textFieldView.textField.text = bundle?.localizedString(forKey: "아이디", value: nil, table: nil)
//        nameView.textFieldView.textField.text = bundle?.localizedString(forKey: "이름", value: nil, table: nil)
//        idView = JoinComponentView_1Value(fieldTitle: (bundle?.localizedString(forKey: "아이디", value: nil, table: nil))!, motherVC: self)
        
        
        
        
    }
    
    
}

class MainButton: UIButton {
    init(frame : CGRect, index : Int, infoDic : [String:Any]) {
        super.init(frame: frame)
        
        if let backColor = infoDic[MAIN_CONTENT_INFO_KEY.BACKGROUND_COLOR] as? UIColor {
            self.backgroundColor = backColor
        }
        
        self.layer.cornerRadius = 5
        
        let rightImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 0))
        rightImageView.setImageWithFrameHeight(image: UIImage(named: "btn_d_next2"))
        rightImageView.frame.origin.x = self.frame.size.width - rightImageView.frame.size.width
        rightImageView.center.y = self.frame.size.height / 2
        self.addSubview(rightImageView)
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.origin.x = 20
        innerView.frame.size.width = rightImageView.frame.minX - innerView.frame.origin.x
        innerView.isUserInteractionEnabled = false
//        innerView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        self.addSubview(innerView)
        
        let indexLabel = UILabel(frame: innerView.bounds)
        indexLabel.text = "Tool \(index + 1)"
        indexLabel.font = UIFont(name: NanumSquareR, size: 15)
        if IS_IPHONE_SE {
            indexLabel.font = UIFont(name: NanumSquareR, size: 12)
        }
        indexLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        indexLabel.sizeToFit()
        innerView.addSubview(indexLabel)
        
        let titleLabel = UILabel(frame: innerView.bounds)
        titleLabel.numberOfLines = 0
        titleLabel.text = infoDic[MAIN_CONTENT_INFO_KEY.TITLE] as? String ?? ""
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = UIFont(name: NanumSquareB, size: 20)
        if IS_IPHONE_SE {
        titleLabel.font = UIFont(name: NanumSquareB, size: 17)
        }
        titleLabel.sizeToFit()
        titleLabel.frame.size.width = innerView.frame.size.width
        titleLabel.frame.origin.y = indexLabel.frame.maxY + 5
        innerView.addSubview(titleLabel)
        

        
        innerView.frame.size.height = titleLabel.frame.maxY
        innerView.center.y = self.frame.size.height / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

