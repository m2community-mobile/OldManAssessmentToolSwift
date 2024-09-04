//
//  PasswordEditViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 25/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class PasswordEditViewController: BaseViewController {

    var naviLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.titleLabel.text = "비밀번호 수정"
        
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
            self.titleLabel.text = "비밀번호 수정"
        }
        if naviLabel.text == "en" {
            self.titleLabel.text = "Edit Password"
        }
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: SCREEN.WIDTH, height: confirmButton.frame.minY - naviBar.frame.maxY))
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        
        
        
        let noticeLabel = UILabel(frame: CGRect(x: 0, y: 20, width: SCREEN.WIDTH * 0.9, height: 80))
        noticeLabel.font = UIFont(name: NanumSquareB, size: 14)
        noticeLabel.textColor = UIColor.white
        
        
        if naviLabel.text == "ko" {
            noticeLabel.text = "기존 비밀번호를 입력해주세요."
        }
        if naviLabel.text == "en" {
            noticeLabel.text = "Please enter your password."
        }
        
//        noticeLabel.text = "기존 비밀번호를 입력해주세요."
        noticeLabel.sizeToFit()
        noticeLabel.frame.size.width = SCREEN.WIDTH * 0.9
        noticeLabel.center.x = SCREEN.WIDTH / 2
        scrollView.addSubview(noticeLabel)
        
        //기존 비밀번호
        if naviLabel.text == "ko" {
            beforePWView = JoinComponentView_1Value(fieldTitle: "기존비밀번호", motherVC: self)
        }
        if naviLabel.text == "en" {
            beforePWView = JoinComponentView_1Value(fieldTitle: "Password", motherVC: self)
        }
        
//        beforePWView = JoinComponentView_1Value(fieldTitle: "기존비밀번호", motherVC: self)
        beforePWView.textFieldView.textField.isSecureTextEntry = true
        beforePWView.frame.origin.y = noticeLabel.frame.maxY + 20
        scrollView.addSubview(beforePWView)
        
        let separaterView1 = UIView(frame: CGRect(x: 0, y: beforePWView.frame.maxY + 30, width: SCREEN.WIDTH, height: 0.5))
        separaterView1.center.x = SCREEN.WIDTH / 2
        separaterView1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scrollView.addSubview(separaterView1)
        
        ////
        
        let noticeLabel2 = UILabel(frame: CGRect(x: 0, y: separaterView1.frame.maxY + 20, width: SCREEN.WIDTH * 0.9, height: 80))
        noticeLabel2.font = UIFont(name: NanumSquareB, size: 14)
        noticeLabel2.textColor = UIColor.white
        
        if naviLabel.text == "ko" {
            noticeLabel2.text = "새로운 비밀번호를 입력해주세요."
        }
        if naviLabel.text == "en" {
            noticeLabel2.text = "Please enter your new password."
        }
        
//        noticeLabel2.text = "새로운 비밀번호를 입력해주세요."
        noticeLabel2.sizeToFit()
        noticeLabel2.frame.size.width = SCREEN.WIDTH * 0.9
        noticeLabel2.center.x = SCREEN.WIDTH / 2
        scrollView.addSubview(noticeLabel2)
        
        //새 비밀번호
        
        if naviLabel.text == "ko" {
            newPWView = JoinComponentView_1Value(fieldTitle: "비밀번호", motherVC: self)
            
        }
        if naviLabel.text == "en" {
            newPWView = JoinComponentView_1Value(fieldTitle: "New Password", motherVC: self)
        }
//        newPWView = JoinComponentView_1Value(fieldTitle: "비밀번호", motherVC: self)
        newPWView.textFieldView.textField.isSecureTextEntry = true
        newPWView.frame.origin.y = noticeLabel2.frame.maxY + 20
        scrollView.addSubview(newPWView)
        
        //새 비밀번호 확인
        
        if naviLabel.text == "ko" {
            newPWView2 = JoinComponentView_1Value(fieldTitle: "비밀번호확인", motherVC: self)
        }
        if naviLabel.text == "en" {
            newPWView2 = JoinComponentView_1Value(fieldTitle: "Password Confirm", motherVC: self)
            
        }
//        newPWView2 = JoinComponentView_1Value(fieldTitle: "비밀번호확인", motherVC: self)
        newPWView2.textFieldView.textField.isSecureTextEntry = true
        newPWView2.frame.origin.y = newPWView.frame.maxY + 10
        scrollView.addSubview(newPWView2)
        
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)

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
    
    var beforePWView : JoinComponentView_1Value!
    var newPWView : JoinComponentView_1Value!
    var newPWView2 : JoinComponentView_1Value!
    
    @objc func confirmButtonPressed(){
        
        self.view.endEditing(true)
        
        let beforePW = beforePWView.textFieldView.textField.text ?? ""
        let savedPW = userD.string(forKey: USER_PW) ?? ""
        
        let newPW = newPWView.textFieldView.textField.text ?? ""
        let newPW2 = newPWView2.textFieldView.textField.text ?? ""
        
        var alertMessage = ""
        if isEmpty(textFieldView: beforePWView.textFieldView) {
            alertMessage = "기존 비밀번호를 입력해 주세요."
        }
        else if beforePW != savedPW {
            alertMessage = "비밀번호를 다시한번 확인해 주세요."
        }
        else if isEmpty(textFieldView: newPWView.textFieldView) {
            alertMessage = "새 비밀번호를 입력해 주세요."
        }
        else if isEmpty(textFieldView: newPWView2.textFieldView) {
            alertMessage = "확인 비밀번호를 입력해 주세요."
        }
        else if newPW != newPW2 {
            alertMessage = "새 비밀번호를 다시한번 확인해 주세요."
        }
       
        if alertMessage != "" {
            appDel.showAlert(title: "Notice", message: alertMessage)
            return
        }

        let urlString = "https://app.m2comm.co.kr/SNUH/user_update.php"
        let para = [
            "id":user_id,
            "new_pw":newPW,
            "pw":beforePW
        ]
        Server.postData(urlString: urlString, otherInfo: para) { [weak self] (kData : Data?) in
            guard let self = self else { return }
            if let data = kData {
                let dataString = data.toString() ?? ""
                print("edit Info resultDataString : \(dataString)")
                userD.set(newPW, forKey: USER_PW)
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
