//
//  SettingViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 25/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit




class SettingViewController: BaseViewController {

    var tableView : UITableView!
    var naviLabel: UILabel!
    
    
    var button: UIButton!
    var button2: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.titleLabel.text = "Setting"
        titleLabel.font = UIFont(name: NanumSquareB, size: 20)
        if IS_IPHONE_SE {
            titleLabel.font = UIFont(name: NanumSquareB, size: 17.5)
        }
        
        self.backButton.isHidden = true
        
        let closeButton = ImageButton(frame: CGRect(x: naviBar.frame.size.width - naviBar.frame.size.height, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "btn_x"), ratio: 1)
        naviBar.addSubview(closeButton)
        closeButton.addTarget(event: .touchUpInside) { (button) in
            self.navigationController?.popViewController(animated: true)
        }
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        naviBar.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        
        //로그아웃 버튼
        let logoutButtonHeight : CGFloat = 50
        let logoutButton = UIButton(frame: CGRect(x: 0, y: SCREEN.HEIGHT - (logoutButtonHeight + SAFE_AREA), width: SCREEN.WIDTH, height: logoutButtonHeight + SAFE_AREA))
        logoutButton.backgroundColor = #colorLiteral(red: 0.3224981427, green: 0.4246884584, blue: 0.5770310163, alpha: 1)
        self.view.addSubview(logoutButton)
        
        let logoutButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: logoutButton.frame.size.width, height: logoutButtonHeight))
        logoutButtonLabel.text = "Logout"
        logoutButtonLabel.font = UIFont(name: NanumSquareB, size: logoutButtonLabel.frame.size.height * 0.4)
        logoutButtonLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        logoutButtonLabel.textAlignment = .center
        logoutButtonLabel.isUserInteractionEnabled = false
        logoutButton.addSubview(logoutButtonLabel)
        
        logoutButton.addTarget(event: .touchUpInside) { (button) in
            userD.removeObject(forKey: USER_ID)
            
            userD.removeObject(forKey: USER_SID)
            userD.removeObject(forKey: USER_NAME)
            userD.removeObject(forKey: USER_OFFICE)
            userD.removeObject(forKey: USER_PHONE)
            userD.removeObject(forKey: USER_EMAIL)
            userD.removeObject(forKey: USER_APP_YN)
            userD.removeObject(forKey: USER_RESEARCH_YN)
            userD.removeObject(forKey: USER_SIGNDATE)
            userD.removeObject(forKey: USER_GUBUN)
            
            userD.synchronize()
            
            if !(self.navigationController?.viewControllers.first == appDel.loginVC) {
                appDel.loginVC = LoginViewController()
                self.navigationController?.viewControllers.insert(appDel.loginVC!, at: 0)
            }
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        tableView = UITableView(frame:  CGRect(x: 0, y: naviBar.frame.maxY, width: SCREEN.WIDTH, height: logoutButton.frame.minY - naviBar.frame.maxY))
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "SettingTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.backgroundColor = UIColor.clear
        
        self.view.addSubview(tableView)

    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         // 네비게이션 바 숨기기
         self.navigationController?.setNavigationBarHidden(true, animated: animated)
     }
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
    
    @objc func koBtnAc(_ sender: UIButton) {
        print("ko")
        
     
        
        
        UserDefaults.standard.setValue("korean", forKey: "setset")
        
        NotificationCenter.default.post(name:NSNotification.Name("ko"), object: UserDefaults.standard.set("ko", forKey: "la"))
        
        tableView.reloadData()
        
        
    }
    
    @objc func enBtnAc(_ sender: UIButton) {
        
        UserDefaults.standard.setValue("english", forKey: "setset")
        
        
        NotificationCenter.default.post(name:NSNotification.Name("en"), object: UserDefaults.standard.set("en", forKey: "la"))
        print("en")
        
        tableView.reloadData()
    }

    let titles = [
    "개인정보 수정",
    "비밀번호 수정",
    "결과보기",
    "언어선택",
    "회원탈퇴"
    ]
    
    let enTitles = [
    "Personal Information",
    "Change your password",
    "Result",
    "Language",
    "Membership Withdrawal"
    ]
    
}

extension SettingViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        naviLabel.isHidden = true
        
        if naviLabel.text == "ko" {
            return titles.count
        }
        if naviLabel.text == "en" {
            return enTitles.count
        }
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SettingTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
        
        if naviLabel.text == "ko" {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
            
            if indexPath.row < self.titles.count {
                cell.titleLabel.text = self.titles[indexPath.row]
                cell.koBtn.isHidden = true
                cell.rightImageView.setImageWithFrameHeight(image: UIImage(named: "btn_d_next2"))
            }
            if indexPath.row == 3 {
                cell.rightImageView.image = UIImage(named: "")
                
                cell.koBtn = UIButton(type: UIButton.ButtonType.custom) as UIButton
                cell.koBtn.frame = CGRect(x: self.view.frame.size.width / 1.8, y: 13, width: 80, height: 28)
                cell.koBtn.layer.borderWidth = 1
                cell.koBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                cell.koBtn.addTarget(self, action: #selector(koBtnAc(_ :)), for: UIControl.Event.touchUpInside)
                
                
                cell.koBtn.setTitle("Korean", for: .normal)
                
                
                
                //Remove all subviews so the button isn't added twice when reusing the cell.
                //                for view: UIView in cell.contentView.subviews as! Array<UIView> {
                //                    view.removeFromSuperview()
                //                }
                cell.contentView.addSubview(cell.koBtn)
                
                cell.koBtn.backgroundColor = #colorLiteral(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1)
                
                
                
                cell.enBtn = UIButton(type: UIButton.ButtonType.custom) as UIButton
                cell.enBtn.frame = CGRect(x: cell.koBtn.frame.maxX + 4, y: 13, width: 80, height: 28)
                cell.enBtn.layer.borderWidth = 1
                cell.enBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                cell.enBtn.addTarget(self, action: #selector(enBtnAc(_ :)), for: UIControl.Event.touchUpInside)
                cell.enBtn.setTitle("English", for: .normal)
                cell.enBtn.setTitleColor(.lightGray, for: .normal)
                //Remove all subviews so the button isn't added twice when reusing the cell.
                //                for view: UIView in cell.contentView.subviews as! Array<UIView> {
                //                    view.removeFromSuperview()
                //                }
                cell.contentView.addSubview(cell.enBtn)
                
            }
            
            return cell
        }
        if naviLabel.text == "en" {
//            button.isHidden = true
//            button2.isHidden = true
            
            
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableViewCell", for: indexPath) as! SettingTableViewCell
            
            if indexPath.row < self.enTitles.count {
                cell.titleLabel.text = self.enTitles[indexPath.row]
                cell.rightImageView.setImageWithFrameHeight(image: UIImage(named: "btn_d_next2"))
            }
            if indexPath.row == 3 {
                cell.rightImageView.image = UIImage(named: "")
                
                cell.koBtn = UIButton(type: UIButton.ButtonType.custom) as UIButton
                cell.koBtn.frame = CGRect(x: self.view.frame.size.width / 1.8, y: 13, width: 80, height: 28)
                cell.koBtn.layer.borderWidth = 1
                cell.koBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                cell.koBtn.addTarget(self, action: #selector(koBtnAc(_ :)), for: UIControl.Event.touchUpInside)
                
                
                cell.koBtn.setTitle("Korean", for: .normal)
                
                //Remove all subviews so the button isn't added twice when reusing the cell.
                //                for view: UIView in cell.contentView.subviews as! Array<UIView> {
                //                    view.removeFromSuperview()
                //                }
                cell.contentView.addSubview(cell.koBtn)
                
                cell.enBtn = UIButton(type: UIButton.ButtonType.custom) as UIButton
                cell.enBtn.frame = CGRect(x: cell.koBtn.frame.maxX + 4, y: 13, width: 80, height: 28)
                cell.enBtn.layer.borderWidth = 1
                cell.enBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                cell.enBtn.addTarget(self, action: #selector(enBtnAc(_ :)), for: UIControl.Event.touchUpInside)
                cell.enBtn.setTitle("English", for: .normal)
                
                
                cell.enBtn.backgroundColor = #colorLiteral(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1)
                cell.koBtn.setTitleColor(.lightGray, for: .normal)
                
                //Remove all subviews so the button isn't added twice when reusing the cell.
                //                for view: UIView in cell.contentView.subviews as! Array<UIView> {
                //                    view.removeFromSuperview()
                //                }
                cell.contentView.addSubview(cell.enBtn)
                
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let nextVC = PrivacyInformationEditViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
            return
        }
        if indexPath.row == 1 {
            let nextVC = PasswordEditViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
            return
        }
        if indexPath.row == 2 {
            let nextVC = ResultListViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
            return
        }
     
        if indexPath.row == 4 {
            
            let nextVC = DeletedInfoViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
            return
            
            
            
          
        }
        
    }
    
    
}

class SettingTableViewCell: UITableViewCell {
    static let height : CGFloat = 55
    
    var titleLabel : UILabel!
    var underBar : UIView!
    var rightImageView: UIImageView!
    var koBtn: UIButton!
    var enBtn: UIButton!
    
//    override var isSelected: Bool {
//        willSet(newIsSelected) {
//            titleLabel.textColor = newIsSelected ? leftViewColor2_191207 : UIColor.black
//        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        let myHeight = SettingTableViewCell.height
        self.frame.size = CGSize(width: SCREEN.WIDTH, height: myHeight)
        
        rightImageView = UIImageView(frame: CGRect(x: SCREEN.WIDTH - myHeight, y: 0, width: myHeight, height: myHeight))
        
        
        
        rightImageView.setImageWithFrameHeight(image: UIImage(named: "btn_d_next2"))
        
        
        
        rightImageView.center.y = self.frame.size.height / 2
        self.addSubview(rightImageView)
        
        titleLabel = UILabel(frame: CGRect(x: 25, y: 0, width: SCREEN.WIDTH - 25, height: myHeight))
        titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.3)
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(titleLabel)
        
        koBtn = UIButton(frame: CGRect(x: self.frame.size.width / 1.8, y: 13, width: 80, height: 28))
                         
        
                         
                         self.addSubview(koBtn)
        
        
    enBtn = UIButton(frame: CGRect(x: 0, y: 13, width: 80, height: 28))
        
        self.addSubview(enBtn)
        
        underBar = UIView(frame: CGRect(x: 0, y: myHeight - 0.5, width: self.frame.size.width, height: 0.5))
        underBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.addSubview(underBar)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        koBtn.isHidden = true
        enBtn.isHidden = true
        
    }
}
