//
//  FindPasswordViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 25/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class FindPasswordViewController: BaseViewController {

    var naviLabel: UILabel!
    
    var woman: UIButton!
    var man: UIButton!
    var arrBTN: [UIButton]!
    
    var noticeLabel: UILabel!
    
    
    var isSendSMSCertification = false
    var availableTime = 0
    var availableTimer : Timer?
    var certificationNumber = ""
    
    var phoneNumberInputView : FPComponentView!
    var smsInputView : FPComponentView!
    var timeStampLabel : UILabel!
    
    var newPasswordBackView : UIView!
    var confirmButton : UIButton!
    var passwordView : FPComponentViewTextFieldView!
    var passwordView2 : FPComponentViewTextFieldView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isSendSMSCertification = false
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.titleLabel.text = "비밀번호 찾기"
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        naviBar.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        
        backButton = ImageButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "btn_d_back2"), ratio: 1)
        backButton.addTarget(event: .touchUpInside) { (button) in
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
               appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
               (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
            }
            
            
////            self.navigationController?.popViewController(animated: true)
//            self.view.window?.rootViewController?.dismiss(animated: false)
////            self.view.window?.rootViewController?.dismiss(animated: false, completion: {
//              let homeVC = LoginViewController()
//              homeVC.modalPresentationStyle = .fullScreen
////              let appDelegate = UIApplication.shared.delegate as! AppDelegate
////              appDelegate.window?.rootViewController?.present(homeVC, animated: true, completion: nil)
////            })
            
        }
        naviBar.addSubview(backButton)
        
        
        woman = UIButton(frame: CGRect(x: 20, y: naviBar.frame.maxY + 10, width: self.view.frame.size.width / 2.5, height: 50))
        woman.setTitle("  Domestic", for: .normal)
        woman.layer.cornerRadius = 8
        woman.backgroundColor = .clear
        woman.setTitleColor(UIColor(red: 0.7011209726, green: 0.7713823915, blue: 0.8184124827, alpha: 1), for: .normal)
        woman.contentHorizontalAlignment = .center
        woman.addTarget(self, action: #selector(womanClick(_ :)), for: .touchUpInside)
//        woman.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        woman.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        woman.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        
        
        woman.tag = 0
        
        //        womanBTN.setImage(UIImage(named: "id"), for: .normal)
//        womanBTN.addTarget(self, action: #selector(test(_ :)), for: .touchUpInside)
        self.view.addSubview(woman)
        
        if IS_IPHONE_X {
            man = UIButton(frame: CGRect(x: woman.frame.maxX + 19, y: naviBar.frame.maxY + 10, width: self.view.frame.size.width / 2.5, height: 50))
        } else {
            man = UIButton(frame: CGRect(x: woman.frame.maxX + 25, y: naviBar.frame.maxY + 10, width: self.view.frame.size.width / 2.5, height: 50))
        }
//        man = UIButton(frame: CGRect(x: woman.frame.maxX + 25, y: birthdayTF.frame.maxY + 10, width: self.view.frame.size.width / 2.5, height: 50))
        man.setTitle("  International", for: .normal)
        man.backgroundColor = .clear
        man.layer.cornerRadius = 8
        
        man.setTitleColor(UIColor(red: 0.7011209726, green: 0.7713823915, blue: 0.8184124827, alpha: 1), for: .normal)
        man.contentHorizontalAlignment = .center
//        man.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        man.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        man.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        man.tag = 1
        
        //        womanBTN.setImage(UIImage(named: "id"), for: .normal)
        man.addTarget(self, action: #selector(manclick(_ :)), for: .touchUpInside)
        self.view.addSubview(man)
        
        arrBTN = [woman, man]
        
        self.arrBTN.forEach {
            $0.addTarget(self, action: #selector(test(_ :)), for: .touchUpInside)
            
        }
        
        
         noticeLabel = UILabel(frame: CGRect(x: 0, y: woman.frame.maxY + 10, width: SCREEN.WIDTH, height: 80))
        noticeLabel.textAlignment = .center
        noticeLabel.font = UIFont(name: NanumSquareB, size: 14)
        noticeLabel.textColor = UIColor.white
        noticeLabel.text = "회원가입 시 입력하신 휴대폰번호를 입력해주세요."
        noticeLabel.numberOfLines = 0
        self.view.addSubview(noticeLabel)
        
        //휴대폰번호 입력
        phoneNumberInputView = FPComponentView(placeHoder: "휴대폰번호", buttonTitle: "인증번호 받기")
        phoneNumberInputView.textFieldView.textField.keyboardType = .numberPad
        phoneNumberInputView.frame.origin.y = noticeLabel.frame.maxY
        phoneNumberInputView.actionButton.backgroundColor = #colorLiteral(red: 0.2591966987, green: 0.3456728458, blue: 0.5022798777, alpha: 1)
        phoneNumberInputView.actionButton.addTarget(self, action: #selector(requestSMS), for: .touchUpInside)
        self.view.addSubview(phoneNumberInputView)
        
        
        //인증번호 입력
        smsInputView = FPComponentView(placeHoder: "인증번호", buttonTitle: "확인")
        smsInputView.frame.origin.y = phoneNumberInputView.frame.maxY + 10
        smsInputView.actionButton.backgroundColor = #colorLiteral(red: 0.1972873807, green: 0.4069689512, blue: 0.785780251, alpha: 1)
        smsInputView.actionButton.addTarget(self, action: #selector(smsConfirmButtonPressed), for: .touchUpInside)
        self.view.addSubview(smsInputView)
        
        //인증번호 유효시간
        timeStampLabel = UILabel(frame: CGRect(x: 0, y: smsInputView.frame.maxY + 5, width: SCREEN.WIDTH * 0.9, height: 30))
        timeStampLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 13)
        timeStampLabel.textColor = UIColor.white
        timeStampLabel.text = "인증번호 유효시간 00:00"
        timeStampLabel.sizeToFit()
        timeStampLabel.frame.size.width = SCREEN.WIDTH * 0.9
        timeStampLabel.frame.size.height += 10
        timeStampLabel.center.x = SCREEN.WIDTH / 2
        timeStampLabel.text = ""
        self.view.addSubview(timeStampLabel)
        
        //새로운 비밀번호
        newPasswordBackView = UIView(frame: CGRect(x: 0, y: timeStampLabel.frame.maxY + 20, width: SCREEN.WIDTH, height: 0))
        self.view.addSubview(newPasswordBackView)
        
        let noticeLabel2 = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 80))
        noticeLabel2.textAlignment = .center
        noticeLabel2.font = UIFont(name: NanumSquareB, size: 14)
        noticeLabel2.textColor = UIColor.white
        noticeLabel2.text = "새로운 비밀번호를 입력해 주세요."
        newPasswordBackView.addSubview(noticeLabel2)
        
        passwordView = FPComponentViewTextFieldView(frame: CGRect(x: 0, y: noticeLabel2.frame.maxY, width: SCREEN.WIDTH * 0.9, height: 45))
        passwordView.center.x = newPasswordBackView.frame.size.width / 2
        passwordView.setPlaseHolder(plaseHolder: "새로운 비밀번호")
        passwordView.textField.isSecureTextEntry = true
        newPasswordBackView.addSubview(passwordView)
        
        
        passwordView2 = FPComponentViewTextFieldView(frame: CGRect(x: 0, y: passwordView.frame.maxY + 10, width: SCREEN.WIDTH * 0.9, height: 45))
        passwordView2.center.x = newPasswordBackView.frame.size.width / 2
        passwordView2.setPlaseHolder(plaseHolder: "새로운 비밀번호 확인")
        passwordView2.textField.isSecureTextEntry = true
        newPasswordBackView.addSubview(passwordView2)
        
        newPasswordBackView.frame.size.height = passwordView2.frame.maxY
        
        
        //확인버튼
        let confirmButtonHeight : CGFloat = 50
        confirmButton = UIButton(frame: CGRect(x: 0, y: SCREEN.HEIGHT - (confirmButtonHeight + SAFE_AREA), width: SCREEN.WIDTH, height: confirmButtonHeight + SAFE_AREA))
        confirmButton.backgroundColor = #colorLiteral(red: 0.2563343644, green: 0.4993571639, blue: 0.8275485635, alpha: 1)
        confirmButton.addTarget(self, action: #selector(requestNewPW), for: .touchUpInside)
        
        self.view.addSubview(confirmButton)
        
        let confirmButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: confirmButton.frame.size.width, height: confirmButtonHeight))
        confirmButtonLabel.text = "저장"
        confirmButtonLabel.font = UIFont(name: NanumSquareB, size: confirmButtonLabel.frame.size.height * 0.4)
        confirmButtonLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        confirmButtonLabel.textAlignment = .center
        confirmButtonLabel.isUserInteractionEnabled = false
        confirmButton.addSubview(confirmButtonLabel)
        
        confirmButton.isHidden = true
        newPasswordBackView.isHidden = true
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//         super.viewWillAppear(animated)
//         // 네비게이션 바 숨기기
//         self.navigationController?.setNavigationBarHidden(true, animated: animated)
//     }
    @objc func womanClick(_ sender: UIButton) {
        
        
    }
    @objc func manclick(_ sender: UIButton) {
        let vc = EnFindPasswordViewController()
        //
                                                                    vc.modalPresentationStyle = .fullScreen
                                                                    self.present(vc, animated: false)
        
    }
    
    @objc func test(_ sender: UIButton) {
        print("\(sender.tag)")
        
        self.arrBTN.forEach {
            if $0.tag == sender.tag {
                $0.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
//                $0.backgroundColor = #colorLiteral(red: 0.04341550916, green: 0.639064908, blue: 0.9187603593, alpha: 1)
                $0.setTitleColor(.white, for: .normal)
                
            } else {
                $0.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
//                $0.backgroundColor = #colorLiteral(red: 0.8938891292, green: 0.9134108424, blue: 0.9262667298, alpha: 1)
                $0.setTitleColor(UIColor(red: 0.7011209726, green: 0.7713823915, blue: 0.8184124827, alpha: 1), for: .normal)
            }
        }
    }
    
//    @objc func requestSMS2() {
//        
//        let urlStirng = "http://www.lungkorea.org/mobile/login.php"
//        
//        let para = ["id":"webmaster",
//                    "passwd":"lung1234",
//                    "device":"IOS",
//                    "deviceid":"1234"]
//        
//        Server.postData(urlString: urlStirng, method: .get, otherInfo: para) { (kData : Data?) in
//            if let data = kData {
//                if let dataString = data.toString() {
//                    print("get dataString:\(dataString)")
//                }
//            }
//        }
//        Server.postData(urlString: urlStirng, method: .post, otherInfo: para) { (kData : Data?) in
//            if let data = kData {
//                if let dataString = data.toString() {
//                    print("post dataString:\(dataString)")
//                }
//            }
//        }
//        
//    }
    @objc func requestSMS() {
        
        
        
        
        guard let phoneNumber = phoneNumberInputView.textFieldView.textField.text,
            phoneNumber.replacingOccurrences(of: " ", with: "") != ""
        else {
            return appDel.showAlert(title: "Notice", message: "휴대폰번호를 입력해 주세요.")
            
        }
        
        let urlString = "https://app.m2comm.co.kr/SNUH/sms.php"
        let para = ["phone":phoneNumber]
        
        print("requestSMS:\(urlString)")
        print("para:\(para)")
        
//        self.timerStart() //test
        
        
        
        Server.postData(urlString: urlString, otherInfo: para) { (kData : Data?) in
            if let data = kData {
                if let dataString = data.toString() {
                    print("requestSMS:\(dataString)")
                    
                    if dataString == "-1" {
                        appDel.showAlert(title: "Notice", message: "휴대폰 번호를 확인해 주세요")
                        return
                    }
                    DispatchQueue.main.async {
                        self.phoneNumberInputView.change(name: "재전송")
                    }
                    
                    self.certificationNumber = dataString
                    self.timerStart()
                }
            
            }
            
        }
    }
    
    @objc func smsConfirmButtonPressed(){
        print("smsConfirmButtonPressed:\(availableTime)")
        if self.availableTime <= 0 {
            appDel.showAlert(title: "Notice", message: "우선 인증번호를 받아주세요.")
            return
            
                
                
        }
        
        if self.certificationNumber != "", self.certificationNumber == self.smsInputView.textFieldView.textField.text {
            appDel.showAlert(title: "Notice", message: "인증이 완료되었습니다.")
            availableTimer?.invalidate()
            confirmButton.isHidden = false
            newPasswordBackView.isHidden = false
            phoneNumberInputView.actionButton.isEnabled = false
            smsInputView.actionButton.isEnabled = false
            
            phoneNumberInputView.textFieldView.textField.isEnabled = false
            

        }else{
            appDel.showAlert(title: "Notice", message: "발송된 인증번호를 입력해주세요.")
        }
    }
  
    func timerStart(){
        availableTimer?.invalidate()
        availableTime = 3 * 60
        availableTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            if self.availableTime == 0 {
             timer.invalidate()
            }else{
                self.availableTime -= 1
                self.timeStampUpdate(time: self.availableTime)
            }
        
        })
    }
    func timeStampUpdate(time : Int){
        if time == 0 {
            timeStampLabel.text = ""
        }else{
            let minute = time / 60
            let second = time - (minute * 60)
            timeStampLabel.text = "인증번호 유효시간 \(minute):\(second)"
        }
    }
    
    @objc func requestNewPW(){
        let urlString = "https://app.m2comm.co.kr/SNUH/new_pw.php"
        
        let phone = phoneNumberInputView.textFieldView.textField.text!
        let pw = passwordView.textField.text!
        let pw2 = passwordView2.textField.text!
 
        if pw.replacingOccurrences(of: " ", with: "") == "" {
            appDel.showAlert(title: "Notice", message: "새로운 비밀번호를 입력해주세요.")
        }
        
        if pw != pw2 {
            appDel.showAlert(title: "Notice", message: "비밀번호를 다시 확인해주세요.")
            return
        }
        
        let para = [
            "pw":pw,
            "phone":phone
        ]
        Server.postData(urlString: urlString, otherInfo: para) { (kData : Data?) in
            if let data = kData {
                if let dataString = data.toString() {
                    print("requestNewPW:\(dataString)")
                    appDel.showAlert(title: "Notice", message: "비밀번호 변경이 완료되었습니다.", actions: [UIAlertAction(title: "확인", style: .default, handler: { (action : UIAlertAction) in
                        self.navigationController?.popViewController(animated: true)
                    })], complete: {
                        
                    })
                }
            }
        }
    }
}

class FPComponentView: UIView {
    
    var textFieldView : FPComponentViewTextFieldView!
    var actionButton : UIButton!
    
    func change(name : String) {
        self.actionButton.setTitle(name, for: .normal)
        self.actionButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        self.actionButton.layer.borderWidth = 1
        self.actionButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        self.actionButton.backgroundColor = #colorLiteral(red: 0.170592159, green: 0.1802100539, blue: 0.2273285985, alpha: 1)
    }
    
    init(placeHoder : String, buttonTitle : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 50))
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.size.width *= 0.9
        innerView.center = self.frame.center
        self.addSubview(innerView)
        
        let widthGap : CGFloat = 10
        
        let textFieldViewWidthRatio : CGFloat = 0.7
        textFieldView = FPComponentViewTextFieldView(frame: CGRect(x: 0, y: 0, width: (innerView.frame.size.width - widthGap) * textFieldViewWidthRatio, height: innerView.frame.size.height))
        textFieldView.setPlaseHolder(plaseHolder: placeHoder)
        innerView.addSubview(textFieldView)
        
        actionButton = UIButton(frame: CGRect(x: textFieldView.frame.maxX + widthGap, y: 0, width: innerView.frame.size.width - (textFieldView.frame.maxX + widthGap), height: innerView.frame.size.height))
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.titleLabel?.font = UIFont(name: NanumSquareR, size: 15)
        if IS_IPHONE_SE {
            actionButton.titleLabel?.font = UIFont(name: NanumSquareR, size: 12)
        }
        actionButton.layer.cornerRadius = 5
        actionButton.setTitleColor(UIColor.white, for: .normal)
        innerView.addSubview(actionButton)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

class FPComponentViewTextFieldView: TextFieldView {
    
    override var textFieldFontSize : CGFloat {
        if IS_IPHONE_SE {
            return 13
        }
        return 15
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 5
        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        self.layer.borderWidth = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

