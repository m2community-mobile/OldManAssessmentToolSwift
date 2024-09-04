//
//  JoinViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 22/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit
import WebKit

class JoinViewController: BaseViewController {
    
    
    
    var naviLabel: UILabel!
    var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        self.view.addSubview(naviLabel)
        
        naviLabel.isHidden = true
        
        if naviLabel.text == "ko" {
            titleLabel.text = "노인평가도구"
        }
        if naviLabel.text == "en" {
            titleLabel.text = "Geriatric Screening Tool"
        }
        
        
        if naviLabel.text == "ko" {
            //한국어로 변경
                  UserDefaults.standard.set(["ko"], forKey: "AppleLanguages")
//                  UserDefaults.standard.synchronize()
                  
                  //보통 메인화면으로 이동시켜줌
                  setLanguage()
            
            
        }
        if naviLabel.text == "en" {
            //영어로 변경
                   UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
//                   UserDefaults.standard.synchronize()
            
            
                   
                   //보통 메인화면으로 이동시켜줌
                   setLanguage()
            
            
            
         
        }
        
        
        //확인버튼
        let confirmButtonHeight : CGFloat = 50
        let confirmButton = UIButton(frame: CGRect(x: 0, y: SCREEN.HEIGHT - (confirmButtonHeight + SAFE_AREA), width: SCREEN.WIDTH, height: confirmButtonHeight + SAFE_AREA))
        confirmButton.backgroundColor = #colorLiteral(red: 0.2563343644, green: 0.4993571639, blue: 0.8275485635, alpha: 1)
        self.view.addSubview(confirmButton)
        
        let confirmButtonLabel = UILabel(frame: CGRect(x: 0, y: 0, width: confirmButton.frame.size.width, height: confirmButtonHeight))
        
        
        
//        confirmButtonLabel.text = "확인"
        
        if naviLabel.text == "ko" {
            confirmButtonLabel.text = "확인"
        }
        if naviLabel.text == "en" {
            confirmButtonLabel.text = "OK"
        }
        
        confirmButtonLabel.font = UIFont(name: NanumSquareB, size: confirmButtonLabel.frame.size.height * 0.4)
        confirmButtonLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        confirmButtonLabel.textAlignment = .center
        confirmButtonLabel.isUserInteractionEnabled = false
        confirmButton.addSubview(confirmButtonLabel)
        
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: SCREEN.WIDTH, height: confirmButton.frame.minY - naviBar.frame.maxY))
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        //아이디
////        idView = JoinComponentView_1Value(fieldTitle: "아이디", motherVC: self)
//        idView = JoinComponentView_1Value(fieldTitle: "\(NSLocalizedString("아이디", comment: ""))", motherVC: self)
        if naviLabel.text == "ko" {
            idView = JoinComponentView_1Value(fieldTitle: "아이디", motherVC: self)
            idView.textFieldView.textField.isSecureTextEntry = true
            idView.frame.origin.y = idView.frame.maxY + 10
            scrollView.addSubview(idView)
        }
        if naviLabel.text == "en" {
            idView = JoinComponentView_1Value(fieldTitle: "ID", motherVC: self)
            idView.textFieldView.textField.isSecureTextEntry = true
            idView.frame.origin.y = idView.frame.maxY + 10
            scrollView.addSubview(idView)
        }
        
        idView.frame.origin.y = 20
        scrollView.addSubview(idView)
        
        if naviLabel.text == "ko" {
            pwView = JoinComponentView_1Value(fieldTitle: "비밀번호", motherVC: self)
            pwView.textFieldView.textField.isSecureTextEntry = true
            pwView.frame.origin.y = idView.frame.maxY + 10
            scrollView.addSubview(pwView)
        }
        if naviLabel.text == "en" {
            pwView = JoinComponentView_1Value(fieldTitle: "Password", motherVC: self)
            pwView.textFieldView.textField.isSecureTextEntry = true
            pwView.frame.origin.y = idView.frame.maxY + 10
            scrollView.addSubview(pwView)
        }
        
 
//        //비밀번호
//        pwView = JoinComponentView_1Value(fieldTitle: "\(NSLocalizedString("비밀번호", comment: ""))", motherVC: self)
//        pwView.textFieldView.textField.isSecureTextEntry = true
//        pwView.frame.origin.y = idView.frame.maxY + 10
//        scrollView.addSubview(pwView)

        
        if naviLabel.text == "ko" {
            pwView2 = JoinComponentView_1Value(fieldTitle: "비밀번호 확인", motherVC: self)
            pwView2.textFieldView.textField.isSecureTextEntry = true
                  pwView2.frame.origin.y = pwView.frame.maxY + 10
                  scrollView.addSubview(pwView2)
        }
        if naviLabel.text == "en" {
            pwView2 = JoinComponentView_1Value(fieldTitle: "Password Confirm", motherVC: self)
            pwView2.textFieldView.textField.isSecureTextEntry = true
                  pwView2.frame.origin.y = pwView.frame.maxY + 10
                  scrollView.addSubview(pwView2)
        }
        //비밀번호2
//        pwView2 = JoinComponentView_1Value(fieldTitle: "\(NSLocalizedString("비밀번호 확인", comment: ""))", motherVC: self)
//        pwView2.textFieldView.textField.isSecureTextEntry = true
//        pwView2.frame.origin.y = pwView.frame.maxY + 10
//        scrollView.addSubview(pwView2)
        
        
        if naviLabel.text == "ko" {
            nameView = JoinComponentView_1Value(fieldTitle: "이름", motherVC: self)
            nameView.frame.origin.y = pwView2.frame.maxY + 10
            scrollView.addSubview(nameView)
        }
        if naviLabel.text == "en" {
            nameView = JoinComponentView_1Value(fieldTitle: "Name", motherVC: self)
            nameView.frame.origin.y = pwView2.frame.maxY + 10
            scrollView.addSubview(nameView)
        }
        
        //이름
//        nameView = JoinComponentView_1Value(fieldTitle: "\(NSLocalizedString("이름", comment: ""))", motherVC: self)
//        nameView.frame.origin.y = pwView2.frame.maxY + 10
//        scrollView.addSubview(nameView)
        
        if naviLabel.text == "ko" {
            officeView = JoinComponentView_1Value(fieldTitle: "소속", motherVC: self)
            officeView.frame.origin.y = nameView.frame.maxY + 10
            scrollView.addSubview(officeView)
        }
        if naviLabel.text == "en" {
            officeView = JoinComponentView_1Value(fieldTitle: "Affiliation", motherVC: self)
            officeView.frame.origin.y = nameView.frame.maxY + 10
            scrollView.addSubview(officeView)
        }
        //소속
//        officeView = JoinComponentView_1Value(fieldTitle: "\(NSLocalizedString("소속", comment: ""))", motherVC: self)
//        officeView.frame.origin.y = nameView.frame.maxY + 10
//        scrollView.addSubview(officeView)
        
        if naviLabel.text == "ko" {
            //휴대폰 번호
            phoneView = JoinComponentView_3Value(fieldTitle: "휴대폰 번호", motherVC: self)
            phoneView.textFieldView1.textField.keyboardType = .numberPad
            phoneView.textFieldView2.textField.keyboardType = .numberPad
            phoneView.textFieldView2.textField.keyboardType = .numberPad
            phoneView.frame.origin.y = officeView.frame.maxY + 10
            scrollView.addSubview(phoneView)
        }
        if naviLabel.text == "en" {
            
        }
        
        if naviLabel.text == "ko" {
            //이메일
            emailView = JoinComponentView_2Value(fieldTitle: "이메일", motherVC: self)
            emailView.frame.origin.y = phoneView.frame.maxY + 10
            scrollView.addSubview(emailView)
        }
        if naviLabel.text == "en" {
            //이메일
            emailView = JoinComponentView_2Value(fieldTitle: "Email", motherVC: self)
            emailView.frame.origin.y = officeView.frame.maxY + 10
            scrollView.addSubview(emailView)
        }
        
        let para = NSMutableParagraphStyle()
        para.lineSpacing = 10
        
        let titleAtt : [NSAttributedString.Key : NSObject] = [
            NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 15)!,
            NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.paragraphStyle:para]
        let bodyAtt : [NSAttributedString.Key : NSObject] = [
            NSAttributedString.Key.font:UIFont(name: Nanum_Barun_Gothic_OTF, size: 13)!,
            NSAttributedString.Key.foregroundColor:#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedString.Key.paragraphStyle:para]
        
        
        //개인정보 수집 동의
        agreeView1 = AgreeView(title: "개인정보의 수집 및 이용에 대한 동의")
        agreeView1.frame.origin.y = emailView.frame.maxY + 20
        scrollView.addSubview(agreeView1)
        
        let infos : [(String,[NSAttributedString.Key:NSObject])] = [
            ("개인정보 활용 동의서\n",titleAtt),
            ("분당서울대병원(당사)은 『개인정보 보호법』등 관계 법령의 준수를 위하여 귀하의 개인정보 수집∙이용에 관하여 아래와 같이 동의를 받고자 합니다.  제공된 개인정보는 아래에 기재된 목적으로만 처리할 것이며, 그 목적을 변경할 때에는 별도의 사전 동의를 구할 것입니다.\n\n",bodyAtt),
            ("1. 개인정보의 수집 및 이용에 대한 동의\n",titleAtt),
            ("① 수집 및 이용목적:의약품관련 정보전달을 위한 모바일앱 이용을 위함\n② 수집항목: 성명, 소속지역, 휴대폰 번호, 설문을 통해 수집된 정보\n③ 보유 및 이용기간: 당사는 위의 개인정보 항목을 해당 이용목적 달성 이후 귀하께서 동의를 철회하시기 전까지 5년 동안 보유·이용합니다.\n④ 거부권 및 거부에 따른 불이익: 귀하는 위와 같은 개인정보의 수집 및 이용을 거부할 수 있습니다. 다만, 개인정보의 수집 및 이용에 동의하지 않을 경우 당사의 모바일앱 이용 및 정보제공이 제한될 수 있습니다.\n⑤ 귀하께서는 동의 의사를 언제든지 철회하실 수 있으며, 귀하께서 동의를 철회하시면 위와 같은 정보 전달은 즉시 중지됩니다.당사의 안전한 데이터베이스에 보관된 귀하의 개인정보에 대해 열람이나 삭제를 희망하시는 경우, gasnubh@gmail.com로 연락하여 주시기 바랍니다.",bodyAtt),
        ]
        
        let agreeTextView1 = AgreeTextView(attText: NSMutableAttributedString(stringsInfos: infos))
        agreeTextView1.frame.origin.y = agreeView1.frame.maxY + 5
        scrollView.addSubview(agreeTextView1)
        
        //개인정보의 취급 위탁
        agreeView2 = AgreeView(title: "개인정보의 취급 위탁")
        agreeView2.frame.origin.y = agreeTextView1.frame.maxY + 15
        scrollView.addSubview(agreeView2)
        
        let infos2 : [(String,[NSAttributedString.Key:NSObject])] = [
            ("2. 개인정보의 취급 위탁\n",titleAtt),
            ("① 수집 및 이용목적: 당사는 수집한 정보를 다음과 같은 목적으로 ㈜엠투커뮤니티에 제공합니다.\n  • 이용자가 당사 모바일앱 서비스를 원활히 이용할 수 있도록 돕기 위함\n  • 본인확인과 부정 이용 방지 \n  • 당사 서비스 이용에 관한 통계 데이터를 작성\n  • 이용자들로부터 문의가 있을 때 본인 여부를 확인하고 문의사항에 대응\n  • 중요한 공지사항 등을 필요에 따라 공지\n  • 행사 안내 및 이벤트 등 정보의 전달\n② 수집항목: 이름, 소속, 휴대폰 번호, 이메일, 메뉴 입력을 통해 수집된 정보",bodyAtt),
        ]
        
        let agreeTextView2 = AgreeTextView(attText: NSMutableAttributedString(stringsInfos: infos2))
        agreeTextView2.frame.origin.y = agreeView2.frame.maxY + 5
        scrollView.addSubview(agreeTextView2)
        
        //민감정보수집 및 이용동의
        agreeView3 = AgreeView(title: "민감정보수집 및 이용동의")
        agreeView3.frame.origin.y = agreeTextView2.frame.maxY + 15
        scrollView.addSubview(agreeView3)
        
//        let infos3 : [(String,[NSAttributedString.Key:NSObject])] = [
//            ("3. 민감정보수집 및 이용동의\n",titleAtt),
//            ("① 수집 · 이용 항목: 사용자의 평가 분석을 위한 데이터 입력 정보\n② 수집 · 이용 목적: 서비스 제공, 신규 서비스 개발 및 분석\n ③보유기간 : 이용목적 달성시 까지\n\n위 민감정보 수집. 이용에 대한 동의를 거부할 권리가 있습니다.\n다만, 동의를 거부하는 경우 앱 서비스 이용에 제한이 있을 수 있습니다.",bodyAtt),
//        ]
        
//        let agreeTextView3 = AgreeTextView(attText: NSMutableAttributedString(stringsInfos: infos3))
//        agreeTextView3.frame.origin.y = agreeView3.frame.maxY + 5
//        scrollView.addSubview(agreeTextView3)
        
        let agreeWebView1 = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.85, height: 250))
        agreeWebView1.frame.origin.y = agreeView3.frame.maxY + 5
        agreeWebView1.center.x = SCREEN.WIDTH / 2
        scrollView.addSubview(agreeWebView1)
        let agreeUrlString1 = "https://ezv.kr:4447/oldman/agree3.php?deviceid=\(deviceID)&device=IOS&asdf=\(Date().timeIntervalSince1970)".addPercenterEncoding()
        print("agreeUrlString1 = \(agreeUrlString1)")
        
        if let url = URL(string: agreeUrlString1) {
            let request = URLRequest(url: url)
            agreeWebView1.load(request)
        }
        
        
        //연구데이터 이용동의
        agreeView4 = AgreeView(title: "연구데이터 이용동의")
        agreeView4.frame.origin.y = agreeWebView1.frame.maxY + 15
        scrollView.addSubview(agreeView4)
        
//        let infos4 : [(String,[NSAttributedString.Key:NSObject])] = [
//            ("3. 민감정보수집 및 이용동의\n",titleAtt),
//            ("① 수집 · 이용 항목: 사용자의 평가 분석을 위한 데이터 입력 정보\n② 수집 · 이용 목적: 서비스 제공, 신규 서비스 개발 및 분석\n ③보유기간 : 이용목적 달성시 까지\n\n위 연구데이터 이용에 대한 동의를 거부할 권리가 있습니다.\n다만, 동의를 거부하는 경우 앱 서비스 이용에 제한이 있을 수 있습니다.",bodyAtt),
//        ]
        
//        let agreeTextView4 = AgreeTextView(attText: NSMutableAttributedString(stringsInfos: infos4))
//        agreeTextView4.frame.origin.y = agreeView4.frame.maxY + 5
//        scrollView.addSubview(agreeTextView4)
        
        let agreeWebView2 = WKWebView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * 0.85, height: 250))
        agreeWebView2.frame.origin.y = agreeView4.frame.maxY + 5
        agreeWebView2.center.x = SCREEN.WIDTH / 2
        scrollView.addSubview(agreeWebView2)
        let agreeUrlString2 = "https://ezv.kr:4447/oldman/agree4.php?deviceid=\(deviceID)&device=IOS&asdf=\(Date().timeIntervalSince1970)".addPercenterEncoding()
        print("agreeUrlString2 = \(agreeUrlString2)")
        
        if let url = URL(string: agreeUrlString2) {
            let request = URLRequest(url: url)
            agreeWebView2.load(request)
        }
        
        scrollView.contentSize.height = max(scrollView.frame.size.height, agreeWebView2.frame.maxY + 20)
        
        
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         // 네비게이션 바 숨기기
         self.navigationController?.setNavigationBarHidden(true, animated: animated)
     }
    @objc func back() {
        dismiss(animated: false)
    }
    
    func setLanguage() {
            
            //설정된 언어 코드 가져오기
            let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String // 초기에 "ko-KR" , "en-KR" 등으로 저장되어있음
            let index = language.index(language.startIndex, offsetBy: 2)
            let languageCode = String(language[..<index]) //"ko" , "en" 등
            
            //설정된 언어 파일 가져오기
            let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
            let bundle = Bundle(path: path!)
            
        
        
//        titleLabel.text = (bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil))!
//        titleLabel.text = (bundle?.localizedString(forKey: "첫번째 cycle에서 항암제 용량감량", value: nil, table: nil))!
//        _ = (bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil))!
//            myLabel.text = bundle?.localizedString(forKey: "Hello", value: nil, table: nil)
//            buttonKorean.setTitle(bundle?.localizedString(forKey: "buttonKorean", value: nil, table: nil), for: .normal)
        }
    
    
    
    var idView : JoinComponentView_1Value!
    var pwView : JoinComponentView_1Value!
    var pwView2 : JoinComponentView_1Value!
    var nameView : JoinComponentView_1Value!
    var officeView : JoinComponentView_1Value!
    var phoneView : JoinComponentView_3Value!
    var emailView : JoinComponentView_2Value!
    var agreeView1 : AgreeView!
    var agreeView2 : AgreeView!
    var agreeView3 : AgreeView!
    var agreeView4 : AgreeView!
    
    @objc func confirmButtonPressed(){
        
        self.view.endEditing(true)
        
        var alertMessage = ""
        if isEmpty(textFieldView: idView.textFieldView) {
//            alertMessage = "아이디를 입력해 주세요."
            
            if naviLabel.text == "ko" {
                alertMessage = "아이디를 입력해 주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please enter your ID."
            }
            
            
        }
        else if isEmpty(textFieldView: pwView.textFieldView) {
//            alertMessage = "비밀번호를 입력해 주세요."
            
            if naviLabel.text == "ko" {
                alertMessage = "비밀번호를 입력해 주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please enter your password."
            }
            
        }
        else if isEmpty(textFieldView: nameView.textFieldView) {
//            alertMessage = "이름을 입력해 주세요."
            
            if naviLabel.text == "ko" {
                            alertMessage = "이름을 입력해 주세요."
            }
            if naviLabel.text == "en" {
                            alertMessage = "Please enter your name."
            }
            
        }
        else if isEmpty(textFieldView: officeView.textFieldView) {
//            alertMessage = "소속을 입력해 주세요."
            
            if naviLabel.text == "ko" {
                alertMessage = "소속을 입력해 주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please enter your affiliation."
            }
        }
//        else if isEmpty(textFieldView: phoneView.textFieldView1) ||
//            isEmpty(textFieldView: phoneView.textFieldView2) ||
//            isEmpty(textFieldView: phoneView.textFieldView3) {
//            alertMessage = "전화번호를 입력해 주세요."
//        }
        else if isEmpty(textFieldView: emailView.textFieldView1) ||
            isEmpty(textFieldView: emailView.textFieldView2){
//            alertMessage = "이메일을 입력해 주세요."
            
            
            if naviLabel.text == "ko" {
                alertMessage = "이메일을 입력해 주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please enter your email."
            }
            
        }
        else if !agreeView1.isAgree {
//            alertMessage = "개인정보의 수집 및 이용에 대한 동의에 체크해 주세요."
            
            
            if naviLabel.text == "ko" {
                alertMessage = "개인정보의 수집 및 이용에 대한 동의에 체크해 주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please check if you agree to the collection and use of personal information."
            }
            
        }
        else if !agreeView2.isAgree {
//            alertMessage = "개인정보의 취급 위탁에 대한 동의에 체크해 주세요."
            
            
            if naviLabel.text == "ko" {
                alertMessage = "개인정보의 취급 위탁에 대한 동의에 체크해 주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please check if you agree to the consignment of personal information handling."
            }
        }
        else if !agreeView3.isAgree {
//            alertMessage = "민감정보수집 및 이용동의에 대한 동의에 체크해 주세요."
            
            if naviLabel.text == "ko" {
                alertMessage = "민감정보수집 및 이용동의에 대한 동의에 체크해 주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please check the consent to collection and use of sensitive information."
            }
            
        }
        else if !agreeView4.isAgree {
//            alertMessage = "연구데이터 이용동의에 대한 동의에 체크해 주세요."
            if naviLabel.text == "ko" {
                alertMessage = "연구데이터 이용동의에 대한 동의에 체크해 주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please check the consent to use research data."
            }
        }
        else if pwView.textFieldView.textField.text != pwView2.textFieldView.textField.text {
//            alertMessage = "비밀번호를 다시한번 확인해주세요."
            
            
            if naviLabel.text == "ko" {
                alertMessage = "비밀번호를 다시한번 확인해주세요."
            }
            if naviLabel.text == "en" {
                alertMessage = "Please check your password again."
            }
            
        }
        
        if alertMessage != "" {
            appDel.showAlert(title: "Notice", message: alertMessage)
            return
        }
        
        let urlString = "https://app.m2comm.co.kr/SNUH/sign.php"
        
        
        
        let phoneStr1 = naviLabel.text == "ko" ? phoneView.textFieldView1.textField.text ?? "" : ""
        let phoneStr2 = naviLabel.text == "ko" ? phoneView.textFieldView2.textField.text ?? "" : ""
        let phoneStr3 = naviLabel.text == "ko" ? phoneView.textFieldView3.textField.text ?? "" : ""
        let phoneStr = "\(phoneStr1)\(phoneStr2)\(phoneStr3)"
        
        let emailStr1 = emailView.textFieldView1.textField.text ?? ""
        let emailStr2 = emailView.textFieldView2.textField.text ?? ""
        let emailStr = "\(emailStr1)@\(emailStr2)"
        
        
        let para = [
            "idea":idView.textFieldView.textField.text ?? "",
            "password":pwView.textFieldView.textField.text ?? "",
            "name":nameView.textFieldView.textField.text ?? "",
            "office":officeView.textFieldView.textField.text ?? "",
            "phone":phoneStr,
            "email":emailStr,
            "device":"IOS",
            "deviceid":deviceID,
            "token":token_id,
            "foreign":naviLabel.text == "en" ? "Y" : "N"
        ]
        
        print("signUp : \(urlString)")
        print("para:")
        para.showValue()
        
        Server.postData(urlString: urlString, otherInfo: para) { [weak self] (kData : Data?) in
            guard let self = self else { return }
            if let data = kData {
                let dataString = data.toString() ?? ""
                print("sighUp resultDataString : \(dataString)")
                let dataArray = dataString.components(separatedBy: ":")
                if dataArray.count >= 2 {
                    userD.set(self.idView.textFieldView.textField.text ?? "", forKey: USER_ID)
                    userD.set(self.pwView.textFieldView.textField.text ?? "", forKey: USER_PW)
                    userD.set(dataArray[1], forKey: USER_SID)
                    userD.set(self.nameView.textFieldView.textField.text ?? "", forKey: USER_NAME)
                    userD.set(self.officeView.textFieldView.textField.text ?? "", forKey: USER_OFFICE)
                    userD.set(phoneStr, forKey: USER_PHONE)
                    userD.set(emailStr, forKey: USER_EMAIL)
                    userD.set("Y", forKey: USER_APP_YN)
                    userD.set("N", forKey: USER_RESEARCH_YN)
                    userD.set("", forKey: USER_SIGNDATE)
                    userD.synchronize()
                    
                    appDel.mainCon = MainViewController()
                    self.navigationController?.pushViewController(appDel.mainCon!, animated: true)
                    
                    return
                }
                appDel.showAlert(title: "Notice", message: dataString)
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

class JoinComponentView_1Value: UIView {
    
    var textFieldView : JoinComponentViewTextFieldView!

    init(fieldTitle : String, motherVC : UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 45))
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.size.width *= 0.9
        innerView.center = self.frame.center
        self.addSubview(innerView)
        
        let titleLabelWidthRatio : CGFloat = 0.3
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: innerView.frame.size.width * titleLabelWidthRatio, height: innerView.frame.size.height))
        
        titleLabel.text = fieldTitle
        titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.4)
        if IS_IPHONE_N || IS_IPHONE_X {
            titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.35)
        }
        if IS_IPHONE_SE {
            titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.3)
        }
        titleLabel.numberOfLines = 0
        titleLabel.textColor = UIColor.white
        innerView.addSubview(titleLabel)
        
        textFieldView = JoinComponentViewTextFieldView(frame: CGRect(x: titleLabel.frame.maxX, y: 0, width: innerView.frame.size.width - titleLabel.frame.maxX, height: innerView.frame.size.height))
        textFieldView.textField.delegate = motherVC
        innerView.addSubview(textFieldView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class JoinComponentView_2Value: UIView {
    
    var textFieldView1 : JoinComponentViewTextFieldView!
    var textFieldView2 : JoinComponentViewTextFieldView!
    
    init(fieldTitle : String, motherVC : UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 45))
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.size.width *= 0.9
        innerView.center = self.frame.center
        self.addSubview(innerView)
        
        let titleLabelWidthRatio : CGFloat = 0.3
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: innerView.frame.size.width * titleLabelWidthRatio, height: innerView.frame.size.height))
        titleLabel.text = fieldTitle
        titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.4)
        if IS_IPHONE_N || IS_IPHONE_X {
            titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.35)
        }
        if IS_IPHONE_SE {
            titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.3)
        }
        titleLabel.textColor = UIColor.white
        innerView.addSubview(titleLabel)
        
        let atLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: innerView.frame.size.height))
        atLabel.text = "@"
        atLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.4)
        atLabel.textColor = UIColor.white
        atLabel.textAlignment = .center
        atLabel.sizeToFit()
        atLabel.frame.size.height = innerView.frame.size.height
        atLabel.frame.size.width += 5
        innerView.addSubview(atLabel)
        
        
        let textFieldViewGap : CGFloat = atLabel.frame.size.width
        let textFieldViewWidth1 = ((innerView.frame.size.width - titleLabel.frame.maxX) - (textFieldViewGap * 1)) * 0.4
        let textFieldViewWidth2 = ((innerView.frame.size.width - titleLabel.frame.maxX) - (textFieldViewGap * 1)) * 0.6
        
        textFieldView1 = JoinComponentViewTextFieldView(frame: CGRect(x: titleLabel.frame.maxX, y: 0, width: textFieldViewWidth1, height: innerView.frame.size.height))
        textFieldView1.textField.delegate = motherVC
        textFieldView1.textField.textAlignment = .center
        innerView.addSubview(textFieldView1)
        
        atLabel.frame.origin.x = textFieldView1.frame.maxX
        
        textFieldView2 = JoinComponentViewTextFieldView(frame: CGRect(x: atLabel.frame.maxX, y: 0, width: textFieldViewWidth2, height: innerView.frame.size.height))
        textFieldView2.textField.delegate = motherVC
        textFieldView2.textField.textAlignment = .center
        innerView.addSubview(textFieldView2)
        
        //        innerView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        //        titleLabel.backgroundColor = UIColor.random.withAlphaComponent(0.3)
        //        textFieldBackView.backgroundColor = UIColor.random.withAlphaComponent(0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class JoinComponentView_3Value: UIView {
    
    var textFieldView1 : JoinComponentViewTextFieldView!
    var textFieldView2 : JoinComponentViewTextFieldView!
    var textFieldView3 : JoinComponentViewTextFieldView!
    
    init(fieldTitle : String, motherVC : UIViewController) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 45))
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.size.width *= 0.9
        innerView.center = self.frame.center
        self.addSubview(innerView)
        
        let titleLabelWidthRatio : CGFloat = 0.3
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: innerView.frame.size.width * titleLabelWidthRatio, height: innerView.frame.size.height))
        titleLabel.text = fieldTitle
        titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.4)
        if IS_IPHONE_N || IS_IPHONE_X {
            titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.35)
        }
        if IS_IPHONE_SE {
            titleLabel.font = UIFont(name: NanumSquareR, size: titleLabel.frame.size.height * 0.3)
        }
        titleLabel.textColor = UIColor.white
        innerView.addSubview(titleLabel)
        
        let textFieldViewGap : CGFloat = 5
        let textFieldViewWidth = ((innerView.frame.size.width - titleLabel.frame.maxX) - (textFieldViewGap * 2)) / 3
        
        textFieldView1 = JoinComponentViewTextFieldView(frame: CGRect(x: titleLabel.frame.maxX, y: 0, width: textFieldViewWidth, height: self.frame.size.height))
        textFieldView1.textField.delegate = motherVC
        textFieldView1.textField.textAlignment = .center
        innerView.addSubview(textFieldView1)
        
        textFieldView2 = JoinComponentViewTextFieldView(frame: CGRect(x: textFieldView1.frame.maxX + textFieldViewGap, y: 0, width: textFieldViewWidth, height: innerView.frame.size.height))
        textFieldView2.textField.delegate = motherVC
        textFieldView2.textField.textAlignment = .center
        innerView.addSubview(textFieldView2)
        
        textFieldView3 = JoinComponentViewTextFieldView(frame: CGRect(x: textFieldView2.frame.maxX + textFieldViewGap, y: 0, width: textFieldViewWidth, height: innerView.frame.size.height))
        textFieldView3.textField.delegate = motherVC
        textFieldView3.textField.textAlignment = .center
        innerView.addSubview(textFieldView3)
        
        //        innerView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        //        titleLabel.backgroundColor = UIColor.random.withAlphaComponent(0.3)
        //        textFieldBackView.backgroundColor = UIColor.random.withAlphaComponent(0.3)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AgreeView: UIView {
    
    var agreeImageView : UIImageView!
    
    var isAgree = false {
        willSet(newIsAgree){
            if newIsAgree {
                agreeImageView.image = UIImage(named: "check_on")
            }else{
                agreeImageView.image = UIImage(named: "check_off")
            }
//            check_off
        }
    }
    
    init(title : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 40))
        
        var labelFontSize : CGFloat {
            if IS_IPHONE_SE {
                return self.frame.size.height * 0.35
            }
            return self.frame.size.height * 0.4
        }
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.size.width *= 0.9
        innerView.center = self.frame.center
        self.addSubview(innerView)
        
        //동의 레이블
        let agreeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: innerView.frame.size.height))
        agreeLabel.text = "동의"
        agreeLabel.font = UIFont(name: NanumSquareR, size: labelFontSize)!
        agreeLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        agreeLabel.sizeToFit()
        agreeLabel.frame.size.width += 10
        agreeLabel.frame.size.height = self.frame.size.height
        agreeLabel.frame.origin.x = innerView.frame.size.width - agreeLabel.frame.size.width
        innerView.addSubview(agreeLabel)
        
        let agreeImageBackViewSize : CGFloat = innerView.frame.size.height
        let agreeImageBackView = UIView(frame: CGRect(x: agreeLabel.frame.minX - agreeImageBackViewSize, y: 0, width: agreeImageBackViewSize, height: agreeImageBackViewSize))
        innerView.addSubview(agreeImageBackView)
        
        agreeImageView = UIImageView(frame: agreeImageBackView.bounds)
        agreeImageView.frame.size.width *= 0.5
        agreeImageView.setImageWithFrameHeight(image: UIImage(named: "check_off"))
        agreeImageView.center = agreeImageBackView.frame.center
        agreeImageBackView.addSubview(agreeImageView)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: agreeImageBackView.frame.minX, height: innerView.frame.size.height))
        titleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        titleLabel.font = UIFont(name: NanumSquareEB, size: labelFontSize)!
        titleLabel.text = title
        innerView.addSubview(titleLabel)
        
        let agreeButton = UIButton(frame: self.bounds)
        self.addSubview(agreeButton)
        
        agreeButton.addTarget(event: .touchUpInside) { (button ) in
            self.isAgree = !self.isAgree
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AgreeTextView: UIView {
    
    var textView : UITextView!
    
    init(attText : NSAttributedString) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 180))
        
        textView = UITextView(frame: self.bounds)
        textView.frame.size.width *= 0.85
        textView.frame.size.height *= 0.95
        textView.center = self.frame.center
        textView.attributedText = attText
        textView.isSelectable = false
        textView.isEditable = false
        textView.bounces = false
        self.addSubview(textView)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class JoinComponentViewTextFieldView: TextFieldView {
    
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
