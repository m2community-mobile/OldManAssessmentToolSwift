//
//  LoginViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 21/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

//{"sid":"161","name":"\uae30\ubbfc\uc815","office":"\uc5e0\ud22c\ucee4\ubba4\ub2c8\ud2f0","phone":"01024651238","email":"kimin@m2community.co.kr","app_YN":"Y","research_YN":"N","signdate":"1574210179","gubun":null}

let USER_SID = "USER_SID" //sid
var user_sid : String {
    get{
        if let value = userD.object(forKey: USER_SID) as? String {
            return value
        }else{
            return ""
        }
    }
}

let USER_NAME = "USER_NAME" //name
let USER_OFFICE = "USER_OFFICE" //office
let USER_PHONE = "USER_PHONE" //phone
let USER_EMAIL = "USER_EMAIL" //email
let USER_APP_YN = "USER_APP_YN" //app_YN
let USER_RESEARCH_YN = "USER_RESEARCH_YN" //research_YN
let USER_SIGNDATE = "USER_SIGNDATE" //signdate
let USER_GUBUN = "USER_GUBUN" //gubun

class LoginViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    var naviLabel: UILabel!
    var idView : LoginItemView!
    var pwView : LoginItemView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("LoginViewcontroller Viewdidload")
        
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
                return SCREEN.HEIGHT * 0.2
            }
            return SCREEN.HEIGHT * 0.23
        }
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = "en"
        naviLabel.textColor = .white
        self.view.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 1000))
        titleLabel.text = "노인평가도구"
        titleLabel.font = UIFont(name: NanumSquareR, size: titleLabelFontSize)
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.white
        titleLabel.sizeToFit()
        titleLabel.center.x = SCREEN.WIDTH / 2
        titleLabel.center.y = titleLabelCenterY
        self.view.addSubview(titleLabel)
        
        let subTitle = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 50))
        subTitle.text = "Geriatric Screening Tool"
        subTitle.font = UIFont(name: NanumSquareR, size: titleLabelFontSize)
        subTitle.textAlignment = .center
        subTitle.textColor = UIColor.white
        subTitle.font = UIFont.systemFont(ofSize: 26)
        subTitle.sizeToFit()
        subTitle.center.x = SCREEN.WIDTH / 2
        subTitle.center.y = titleLabelCenterY + 50
        self.view.addSubview(subTitle)
        
        
        
        let loginBox = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 0))
        self.view.addSubview(loginBox)
        
        //아이디
        idView = LoginItemView(iconImage: UIImage(named: "ic_id"), placeHolder: "ID")
        loginBox.addSubview(idView)
        
        //비밀번호
        pwView = LoginItemView(iconImage: UIImage(named: "ic_pw"), placeHolder: "Password")
        pwView.frame.origin.y = idView.frame.maxY + 10
        pwView.textFieldView.textField.isSecureTextEntry = true
        loginBox.addSubview(pwView)
        
        //로그인
        var buttonFontSize : CGFloat {
            if IS_IPHONE_SE {
                return 50 * 0.35
            }
            if IS_IPHONE_X {
                return 50 * 0.37
            }
            return 50 * 0.37
        }
        let loginButton = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.85, height: 50))
        loginButton.center.x = SCREEN.WIDTH / 2
        loginButton.frame.origin.y = pwView.frame.maxY + 25
        loginButton.backgroundColor = #colorLiteral(red: 0.1972873807, green: 0.4069689512, blue: 0.785780251, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: NanumSquareEB, size: buttonFontSize)!
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginBox.addSubview(loginButton)
        
        //회원가입
        let joinButton = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.85, height: 50))
        joinButton.center.x = SCREEN.WIDTH / 2
        joinButton.frame.origin.y = loginButton.frame.maxY + 10
        joinButton.backgroundColor = UIColor.clear
        joinButton.setTitle("Sign-up", for: .normal)
        joinButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        joinButton.titleLabel?.font = UIFont(name: NanumSquareB, size: buttonFontSize)!
        joinButton.layer.cornerRadius = 5
        joinButton.layer.borderWidth = 1
        joinButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        joinButton.addTarget(self, action: #selector(joinButtonPressed), for: .touchUpInside)
        loginBox.addSubview(joinButton)
        
        //비밀번호 찾기
        let findPasswordButton = UIButton(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.85, height: 40))
        findPasswordButton.center.x = SCREEN.WIDTH / 2
        findPasswordButton.frame.origin.y = joinButton.frame.maxY + 10
        findPasswordButton.backgroundColor = UIColor.clear
        findPasswordButton.setTitle("Find Password", for: .normal)
        findPasswordButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        findPasswordButton.titleLabel?.font = UIFont(name: NanumSquareB, size: findPasswordButton.frame.size.height * 0.4)!
        findPasswordButton.contentHorizontalAlignment = .left
        findPasswordButton.sizeToFit()
        findPasswordButton.frame.size.width += 10
        findPasswordButton.frame.size.height += 10
        findPasswordButton.addTarget(self, action: #selector(findPasswordButtonPressed), for: .touchUpInside)
        loginBox.addSubview(findPasswordButton)
        
        loginBox.frame.size.height = findPasswordButton.frame.maxY
        loginBox.center.y = SCREEN.HEIGHT / 2
        if !IS_NORCH {
        loginBox.center.y = SCREEN.HEIGHT * 0.6
        }
        
        //로고
        let logoImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        logoImageView.setImageWithFrameWidth(image: UIImage(named: "logo"))
        logoImageView.center.x = SCREEN.WIDTH / 2
        logoImageView.frame.origin.y = SCREEN.HEIGHT - SAFE_AREA - logoImageView.frame.size.height - 15
        self.view.addSubview(logoImageView)
        
        
        print(#function)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        self.idView.textFieldView.textField.text = ""
        self.pwView.textFieldView.textField.text = ""
    }
    
    @objc func findPasswordButtonPressed(){
        print("findPasswordButtonPressed")
        let findPasswordVC = FindPasswordViewController()
        self.navigationController?.pushViewController(findPasswordVC, animated: true)
    }
    
    @objc func joinButtonPressed(){
        print("joinButtonPressed")
        let joinVC = SelectedViewController()
        self.navigationController?.pushViewController(joinVC, animated: true)
    }
    
    //loginAction
    @objc func loginButtonPressed(){
        
        
        UserDefaults.standard.set(naviLabel.text, forKey: "la")
        
        print("loginButtonPressed")
        
        self.view.endEditing(true)
        
        
        let urlString = "https://app.m2comm.co.kr/SNUH/login.php"
        
        let id = idView.textFieldView.textField.text ?? ""
        let pw = pwView.textFieldView.textField.text ?? ""
        
        if id.replacingOccurrences(of: " ", with: "") == "" {
            appDel.showAlert(title: "Notice", message: "아이디를 입력해주세요.")
            return
        }
        if pw.replacingOccurrences(of: " ", with: "") == "" {
            appDel.showAlert(title: "Notice", message: "비밀번호를 입력해주세요.")
            return
        }
        
        let para = [
            "id":id,
            "pw":pw,
            "device":"IOS",
            "deviceid":deviceID,
            "token":token_id
        ]
        
        //todo login check
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        Server.postData(urlString: urlString, otherInfo: para, completion: { (kData : Data?) in
            hud.hide(animated: true)
            if let data = kData{
                
                if let dataString = data.toString() {
                    print("loginDataString : \(dataString)")
                }
                
                if let dataDic = data.toJson() as? [String:Any]{
                    if let app_YN = dataDic["app_YN"] as? String{
                        if app_YN == "Y"{
                            userD.set(id, forKey: USER_ID)
                            userD.set(pw, forKey: USER_PW)
                            userD.synchronize()
                            
                            saveUserD(jsonDic: dataDic, valueKey: "sid", saveKey: USER_SID)
                            saveUserD(jsonDic: dataDic, valueKey: "name", saveKey: USER_NAME)
                            saveUserD(jsonDic: dataDic, valueKey: "office", saveKey: USER_OFFICE)
                            saveUserD(jsonDic: dataDic, valueKey: "phone", saveKey: USER_PHONE)
                            saveUserD(jsonDic: dataDic, valueKey: "email", saveKey: USER_EMAIL)
                            saveUserD(jsonDic: dataDic, valueKey: "app_YN", saveKey: USER_APP_YN)
                            saveUserD(jsonDic: dataDic, valueKey: "research_YN", saveKey: USER_RESEARCH_YN)
                            saveUserD(jsonDic: dataDic, valueKey: "signdate", saveKey: USER_SIGNDATE)
                            saveUserD(jsonDic: dataDic, valueKey: "gubun", saveKey: USER_GUBUN)
                        
                            
                            
                            appDel.mainCon = MainViewController()
                            self.navigationController?.pushViewController(appDel.mainCon!, animated: true)
                            return
                        }
                        appDel.showAlert(title: "Notice", message: "승인이 필요한 아이디입니다.")
                        return
                    }
                }
            }
            appDel.showAlert(title: "Notice", message: "로그인에 실패하였습니다.")
            return
        })
        
    }

}

class LoginItemView: UIView {
    
    var textFieldView : TextFieldView!
    
    static var height : CGFloat {
        if IS_IPHONE_SE {
            return 45
        }
        if IS_IPHONE_X {
            return 45
        }
        return 50
    }
    
    init(iconImage : UIImage?, placeHolder : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.85, height: LoginItemView.height))
        
        self.center.x = SCREEN.WIDTH / 2
        
        let iconImageBackView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height * 1.5, height: self.frame.size.height))
        self.addSubview(iconImageBackView)
        
        let iconImageView = UIImageView(frame: iconImageBackView.bounds)
        iconImageView.frame.size.height *= 0.5
        iconImageView.setImageWithFrameWidth(image: iconImage)
        iconImageView.center = iconImageBackView.frame.center
        iconImageBackView.addSubview(iconImageView)
        
        textFieldView = TextFieldView(frame: CGRect(x: iconImageBackView.frame.maxX, y: 0, width: self.frame.size.width - iconImageBackView.frame.maxX, height: self.frame.size.height))
        textFieldView.setPlaseHolder(plaseHolder: placeHolder)
        self.addSubview(textFieldView)
        
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
