//
//  PrivacyInformationEditViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 25/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class PrivacyInformationEditViewController: BaseViewController {

    var naviLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.titleLabel.text = "개인정보수정"

        //수정버튼
        let confirmButtonHeight : CGFloat = 50
        let confirmButton = UIButton(frame: CGRect(x: 0, y: SCREEN.HEIGHT - (confirmButtonHeight + SAFE_AREA), width: SCREEN.WIDTH, height: confirmButtonHeight + SAFE_AREA))
        confirmButton.backgroundColor = #colorLiteral(red: 0.2563343644, green: 0.4993571639, blue: 0.8275485635, alpha: 1)
        self.view.addSubview(confirmButton)
        
        let confirmButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: confirmButton.frame.size.width, height: confirmButtonHeight))
        confirmButtonLabel.text = "수정"
        confirmButtonLabel.font = UIFont(name: NanumSquareB, size: confirmButtonLabel.frame.size.height * 0.4)
        confirmButtonLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        confirmButtonLabel.textAlignment = .center
        confirmButtonLabel.isUserInteractionEnabled = false
        confirmButton.addSubview(confirmButtonLabel)
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        naviBar.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        if naviLabel.text == "ko" {
            self.titleLabel.text = "개인정보수정"
        }
        if naviLabel.text == "en" {
            self.titleLabel.text = "Edit Information"
        }
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: SCREEN.WIDTH, height: confirmButton.frame.minY - naviBar.frame.maxY))
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        
//        //설정된 언어 코드 가져오기
//        let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String // 초기에 "ko-KR" , "en-KR" 등으로 저장되어있음
//        let index = language.index(language.startIndex, offsetBy: 2)
//        let languageCode = String(language[..<index]) //"ko" , "en" 등
//        
//        //설정된 언어 파일 가져오기
//        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
//        let bundle = Bundle(path: path!)
        
        
        //아이디
        if naviLabel.text == "ko" {
            idView = JoinComponentView_1Value(fieldTitle: "아이디", motherVC: self)
        }
        if naviLabel.text == "en" {
            idView = JoinComponentView_1Value(fieldTitle: "ID", motherVC: self)
        }
//        idView = JoinComponentView_1Value(fieldTitle: (bundle?.localizedString(forKey: "아이디", value: "", table:""))!, motherVC: self)
        idView.textFieldView.textField.isEnabled = false
        idView.frame.origin.y = 20
        scrollView.addSubview(idView)
        
        //이름
        if naviLabel.text == "ko" {
            nameView = JoinComponentView_1Value(fieldTitle: "이름", motherVC: self)
        }
        if naviLabel.text == "en" {
            nameView = JoinComponentView_1Value(fieldTitle: "NAME", motherVC: self)
        }
//        nameView = JoinComponentView_1Value(fieldTitle: "이름", motherVC: self)
        nameView.textFieldView.textField.isEnabled = false
        nameView.frame.origin.y = idView.frame.maxY + 10
        scrollView.addSubview(nameView)
        
        //소속
        if naviLabel.text == "ko" {
            officeView = JoinComponentView_1Value(fieldTitle: "소속", motherVC: self)
        }
        if naviLabel.text == "en" {
            officeView = JoinComponentView_1Value(fieldTitle: "Affiliation", motherVC: self)
        }
//        officeView = JoinComponentView_1Value(fieldTitle: "소속", motherVC: self)
        officeView.frame.origin.y = nameView.frame.maxY + 10
        scrollView.addSubview(officeView)
        
        //휴대폰 번호
        
        if naviLabel.text == "ko" {
            phoneView = JoinComponentView_3Value(fieldTitle: "휴대폰 번호", motherVC: self)
            phoneView.textFieldView1.textField.keyboardType = .numberPad
            phoneView.textFieldView2.textField.keyboardType = .numberPad
            phoneView.textFieldView2.textField.keyboardType = .numberPad
            phoneView.frame.origin.y = officeView.frame.maxY + 10
            scrollView.addSubview(phoneView)
        }
        if naviLabel.text == "en" {
//            phoneView = JoinComponentView_3Value(fieldTitle: "Phone", motherVC: self)
        }
//        phoneView = JoinComponentView_3Value(fieldTitle: "휴대폰 번호", motherVC: self)
        
        
        //이메일
        
        if naviLabel.text == "ko" {
            emailView = JoinComponentView_2Value(fieldTitle: "이메일", motherVC: self)
            emailView.frame.origin.y = phoneView.frame.maxY + 10
        }
        if naviLabel.text == "en" {
            emailView = JoinComponentView_2Value(fieldTitle: "email", motherVC: self)
            emailView.frame.origin.y = officeView.frame.maxY + 10
        }
//        emailView = JoinComponentView_2Value(fieldTitle: "이메일", motherVC: self)
//        emailView.frame.origin.y = phoneView.frame.maxY + 10
        scrollView.addSubview(emailView)
        
        scrollView.contentSize.height = max(scrollView.frame.size.height, emailView.frame.maxY + 20)

        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)

        //value update
        idView.textFieldView.textField.text = userD.string(forKey: USER_ID)
        nameView.textFieldView.textField.text = userD.string(forKey: USER_NAME)
        officeView.textFieldView.textField.text = userD.string(forKey: USER_OFFICE)
        
        
        
        if naviLabel.text == "ko" {
            if let phoneNumber = userD.string(forKey: USER_PHONE) {
                if phoneNumber.count == 11 {
                    phoneView.textFieldView1.textField.text = phoneNumber.subString(start: 0, numberOf: 3)
                    phoneView.textFieldView2.textField.text = phoneNumber.subString(start: 3, numberOf: 4)
                    phoneView.textFieldView3.textField.text = phoneNumber.subString(start: 7, numberOf: 4)
                }else if phoneNumber.count == 10 {
                    phoneView.textFieldView1.textField.text = phoneNumber.subString(start: 0, numberOf: 3)
                    phoneView.textFieldView2.textField.text = phoneNumber.subString(start: 3, numberOf: 3)
                    phoneView.textFieldView3.textField.text = phoneNumber.subString(start: 6, numberOf: 4)
                }else if phoneNumber.count == 9{
                    phoneView.textFieldView1.textField.text = phoneNumber.subString(start: 0, numberOf: 3)
                    phoneView.textFieldView2.textField.text = phoneNumber.subString(start: 3, numberOf: 3)
                    phoneView.textFieldView3.textField.text = phoneNumber.subString(start: 6, numberOf: phoneNumber.count - 6)
                } else {
                    
                }
            }
        }
        if naviLabel.text == "en" {
            if let phoneNumber = userD.string(forKey: "") {
                
                
                
            }
        }
        
        if let email = userD.string(forKey: USER_EMAIL) {
            let emails = email.components(separatedBy: "@")
            if emails.count == 2 {
                emailView.textFieldView1.textField.text = emails[0]
                emailView.textFieldView2.textField.text = emails[1]
            }else{
                emailView.textFieldView1.textField.text = email
                emailView.textFieldView2.textField.text = ""
            }
        }
        

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
    
    var idView : JoinComponentView_1Value!
    var nameView : JoinComponentView_1Value!
    var officeView : JoinComponentView_1Value!
    var phoneView : JoinComponentView_3Value!
    var emailView : JoinComponentView_2Value!
    
    @objc func confirmButtonPressed(){
        
        self.view.endEditing(true)
        
        var alertMessage = ""
        if isEmpty(textFieldView: officeView.textFieldView) {
            alertMessage = "소속을 입력해 주세요."
        }
        else if isEmpty(textFieldView: phoneView.textFieldView1) ||
            isEmpty(textFieldView: phoneView.textFieldView2) ||
            isEmpty(textFieldView: phoneView.textFieldView3) {
            alertMessage = "전화번호를 입력해 주세요."
        }
        else if isEmpty(textFieldView: emailView.textFieldView1) ||
            isEmpty(textFieldView: emailView.textFieldView2){
            alertMessage = "이메일을 입력해 주세요."
        }
        
        if alertMessage != "" {
            appDel.showAlert(title: "Notice", message: alertMessage)
            return
        }
        
        let urlString = "https://app.m2comm.co.kr/SNUH/user_update.php"
        
        let phoneStr1 = phoneView.textFieldView1.textField.text ?? ""
        let phoneStr2 = phoneView.textFieldView2.textField.text ?? ""
        let phoneStr3 = phoneView.textFieldView3.textField.text ?? ""
        let phoneStr = "\(phoneStr1)\(phoneStr2)\(phoneStr3)"
        
        let emailStr1 = emailView.textFieldView1.textField.text ?? ""
        let emailStr2 = emailView.textFieldView2.textField.text ?? ""
        let emailStr = "\(emailStr1)@\(emailStr2)"
        
        let password = userD.object(forKey: USER_PW) as? String ?? ""
        
        let para = [
            "id":idView.textFieldView.textField.text ?? "",
            "office":officeView.textFieldView.textField.text ?? "",
            "phone":phoneStr,
            "email":emailStr,
            "pw":password,
            "device":"IOS",
            "deviceid":deviceID,
            "token":token_id
        ]
        
        print("signUp : \(urlString)")
        print("para:")
        para.showValue()
        
        Server.postData(urlString: urlString, otherInfo: para) { [weak self] (kData : Data?) in
            guard let self = self else { return }
            if let data = kData {
                let dataString = data.toString() ?? ""
                print("edit Info resultDataString : \(dataString)")
                userD.set(self.officeView.textFieldView.textField.text ?? "", forKey: USER_OFFICE)
                userD.set(phoneStr, forKey: USER_PHONE)
                userD.set(emailStr, forKey: USER_EMAIL)
                userD.synchronize()
                
                self.navigationController?.popViewController(animated: true)
                
                return
            }
            appDel.showAlert(title: "Notice", message: "네트워크 에러가 발생했습니다. 다시한번 시도해주세요.")
            return
        }
    }

    func isEmpty(textFieldView : TextFieldView) -> Bool {
        if let value = textFieldView.textField.text,
            value.replacingOccurrences(of: " ", with: "") != "" {
            //value가 있으면서 공백이 아니면 -> Empty가 아님
            return false
        }
        return true
    }
}
