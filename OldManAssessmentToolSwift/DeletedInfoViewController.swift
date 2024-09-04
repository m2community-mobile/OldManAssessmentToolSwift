//
//  DeletedInfoViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by m2comm on 2024/09/02.
//  Copyright © 2024 JinGu's iMac. All rights reserved.
//


import UIKit
import Alamofire



struct Deleted: Codable {
    var result: Int
    var message: String
    
}

class DeletedInfoViewController: BaseViewController, CustomAlertDelegate {
    func action() {
        let urlString = "https://app.m2comm.co.kr/SNUH/mem_out.php"
        
//                            let para = [
//
//
//                            ]
        
        
        let para = ["sid":user_sid,
                    "id" : self.yourId.text!,
                    "pw" : self.yourPw.text!] as [String : String]
        
        
        
        
        
        
        let request = Server.postData(urlString: urlString, otherInfo: para, completion: { (kData : Data?) in
            if let data = kData{
                
                
                
            
                
                
                
                
                
                if let dataString = data.toString() {
                    print("appdel : logoutDataString : \(dataString)")
                    
                    
                    
                    
                    
                    
                }
                
                
                
        
                
                
                
                if let dataDic = data.toJson() as? [String:Any]{
                    if let resultY = dataDic["result"] as? Int {
                        let messageS = dataDic["message"] as? String
                            print("\(messageS)")
                        if resultY == 1 {
                            print("YES")
                            
                            
                            
//                            let text: String = "노인평가도구\n회원 탈퇴가 완료되었습니다."
//                            let attributeString = NSMutableAttributedString(string: text) // 텍스트 일부분 색상, 폰트 변경 - https://icksw.tistory.com/152
//                            let font = UIFont.systemFont(ofSize: 20)
//                            attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "\(text)")) // 폰트 적용.
////                            attributeString.addAttribute(.foregroundColor, value: UIColor.yellow, range: (text as NSString).range(of: "노인평가도구")) // '먹어봤던 맥주 리뷰 1개' 부분 색상 옐로우 변경.
//                            attributeString.addAttribute(.foregroundColor, value: UIColor(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1), range: (text as NSString).range(of: "노인평가도구"))
//                            
//                            
//                            #colorLiteral(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1)
//                            attributeString.addAttribute(.foregroundColor, value: UIColor.white, range: (text as NSString).range(of: "만 남기면 모든 리뷰를 보실 수 있어요!"))
//
//                            let alertController = UIAlertController(title: text, message: "", preferredStyle: UIAlertController.Style.alert)
//                            alertController.setValue(attributeString, forKey: "attributedTitle") // 폰트 및 색상 적용.

                            
                            
                            
                            
                            
                            if self.naviLabel.text == "ko" {
                                let text: String = """

노인평가도구\n회원 탈퇴가 완료되었습니다.


"""
                                
                                let attributeString = NSMutableAttributedString(string: text)
                                let font = UIFont(name: NanumSquareR, size: 20)
                                
                                attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "\(text)")) // 폰트 적용.
    //                            attributeString.addAttribute(.foregroundColor, value: UIColor.yellow, range: (text as NSString).range(of: "노인평가도구")) // '먹어봤던 맥주 리뷰 1개' 부분 색상 옐로우 변경.
                                attributeString.addAttribute(.foregroundColor, value: UIColor(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1), range: (text as NSString).range(of: "노인평가도구"))
                                
                                
                                #colorLiteral(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1)
                                attributeString.addAttribute(.foregroundColor, value: UIColor.white, range: (text as NSString).range(of: "회원 탈퇴가 완료되었습니다."))

                                let alertController = UIAlertController(title: text, message: "", preferredStyle: UIAlertController.Style.alert)
                                alertController.setValue(attributeString, forKey: "attributedTitle") // 폰트 및 색상 적용.
                                
                                // 얼럿을 화면에 표시
                             self.present(alertController, animated: true, completion: {
                                    // 2초 후에 얼럿을 닫기 위한 디스패치 큐 설정
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        alertController.dismiss(animated: true, completion: nil)
                                        
                                        let rootViewController = LoginViewController() // YourRootViewController를 실제 루트 뷰 컨트롤러의 클래스 이름으로 변경하세요.
                                           
 //                                       rootViewController.navigationItem.hidesBackButton = true
                                        
                                        
                                           // 현재 네비게이션 컨트롤러의 viewControllers 배열을 루트 뷰 컨트롤러만 포함하도록 설정
                                           if let navigationController = self.navigationController {
                                               navigationController.setViewControllers([rootViewController], animated: true)
                                           } else {
                                               // 네비게이션 컨트롤러가 없는 경우
                                               // 현재 윈도우의 루트 뷰 컨트롤러를 설정
                                               if let window = UIApplication.shared.windows.first {
                                                   window.rootViewController = UINavigationController(rootViewController: rootViewController)
                                                   window.makeKeyAndVisible()
                                               }
                                           }
                                        
 //                                                           self.navigationController?.popViewController(animated: true)
                                        
 //                                                           let vc = LoginViewController()
 //                                                           //
 //                                                                                                                       vc.modalPresentationStyle = .fullScreen
 //                                                                                                                       self.present(vc, animated: false)
                                        
                                    }
                                })
                            }
                            if self.naviLabel.text == "en" {
                                
                                let text: String = """

Geriatric Screening Tool Membership withdrawal has been completed.


"""
                                let attributeString = NSMutableAttributedString(string: text)
//                                let font = UIFont.systemFont(ofSize: 20)
                                let font = UIFont(name: NanumSquareR, size: 20)
                                attributeString.addAttribute(.font, value: font, range: (text as NSString).range(of: "\(text)")) // 폰트 적용.
    //                            attributeString.addAttribute(.foregroundColor, value: UIColor.yellow, range: (text as NSString).range(of: "노인평가도구")) // '먹어봤던 맥주 리뷰 1개' 부분 색상 옐로우 변경.
                                attributeString.addAttribute(.foregroundColor, value: UIColor(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1), range: (text as NSString).range(of: "Geriatric Screening Tool"))
                                
                                
                                #colorLiteral(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1)
                                attributeString.addAttribute(.foregroundColor, value: UIColor.white, range: (text as NSString).range(of: "Membership withdrawal has been completed."))

                                let alertController = UIAlertController(title: text, message: "", preferredStyle: UIAlertController.Style.alert)
                                alertController.setValue(attributeString, forKey: "attributedTitle") // 폰트 및 색상 적용.
                                
                                // 얼럿을 화면에 표시
                             self.present(alertController, animated: true, completion: {
                                    // 2초 후에 얼럿을 닫기 위한 디스패치 큐 설정
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        alertController.dismiss(animated: true, completion: nil)
                                        
                                        let rootViewController = LoginViewController() // YourRootViewController를 실제 루트 뷰 컨트롤러의 클래스 이름으로 변경하세요.
                                           
 //                                       rootViewController.navigationItem.hidesBackButton = true
                                        
                                        
                                           // 현재 네비게이션 컨트롤러의 viewControllers 배열을 루트 뷰 컨트롤러만 포함하도록 설정
                                           if let navigationController = self.navigationController {
                                               navigationController.setViewControllers([rootViewController], animated: true)
                                           } else {
                                               // 네비게이션 컨트롤러가 없는 경우
                                               // 현재 윈도우의 루트 뷰 컨트롤러를 설정
                                               if let window = UIApplication.shared.windows.first {
                                                   window.rootViewController = UINavigationController(rootViewController: rootViewController)
                                                   window.makeKeyAndVisible()
                                               }
                                           }
                                        
 //                                                           self.navigationController?.popViewController(animated: true)
                                        
 //                                                           let vc = LoginViewController()
 //                                                           //
 //                                                                                                                       vc.modalPresentationStyle = .fullScreen
 //                                                                                                                       self.present(vc, animated: false)
                                        
                                    }
                                })
                            }
                            
                            
                            
                            
                            
                            
                            
                            
                            
//                            let alertController = UIAlertController(title: "노인평가도구", message: "회원 탈퇴가 완료되었습니다.", preferredStyle: .alert)
                               
//                               // 얼럿을 화면에 표시
//                            self.present(alertController, animated: true, completion: {
//                                   // 2초 후에 얼럿을 닫기 위한 디스패치 큐 설정
//                                   DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                                       alertController.dismiss(animated: true, completion: nil)
//                                       
//                                       let rootViewController = LoginViewController() // YourRootViewController를 실제 루트 뷰 컨트롤러의 클래스 이름으로 변경하세요.
//                                          
////                                       rootViewController.navigationItem.hidesBackButton = true
//                                       
//                                       
//                                          // 현재 네비게이션 컨트롤러의 viewControllers 배열을 루트 뷰 컨트롤러만 포함하도록 설정
//                                          if let navigationController = self.navigationController {
//                                              navigationController.setViewControllers([rootViewController], animated: true)
//                                          } else {
//                                              // 네비게이션 컨트롤러가 없는 경우
//                                              // 현재 윈도우의 루트 뷰 컨트롤러를 설정
//                                              if let window = UIApplication.shared.windows.first {
//                                                  window.rootViewController = UINavigationController(rootViewController: rootViewController)
//                                                  window.makeKeyAndVisible()
//                                              }
//                                          }
//                                       
////                                                           self.navigationController?.popViewController(animated: true)
//                                       
////                                                           let vc = LoginViewController()
////                                                           //
////                                                                                                                       vc.modalPresentationStyle = .fullScreen
////                                                                                                                       self.present(vc, animated: false)
//                                       
//                                   }
//                               })
                            
                            
                            
                            
                        } else {
                            print("NO")
                        }
                    }
                    
//                        if let app_YN = dataDic["app_YN"] as? String{
//                            if app_YN == "Y"{
//                                complete(true)
//                                self.loginTimer?.invalidate()
//                                return
//                            }
//                            appDel.showAlert(title: "Notice", message: "승인이 필요한 아이디입니다.")
//                            complete(false)
//                            self.loginTimer?.invalidate()
//                            return
//                        }
                }
            }
//                appDel.showAlert(title: "Notice", message: "로그인에 실패하였습니다.")
//                complete(false)
//                self.loginTimer?.invalidate()
            return
        })
    
    }
    
    func exit() {
    
    }
    
    
//    var deleted: UIButton!
    
//    var naviBar : UIView!
//    
//    var titleLabel: UILabel!
    var deleted: UIButton!
    
    var yourId : UITextField!
    var yourPw : UITextField!
    var yourPwCheck : UITextField!
    
    var naviLabel: UILabel!
    
    let labelOne: UILabel = {
      let label = UILabel()
      label.text = "Scroll Top"
      label.backgroundColor = .red
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()

    let labelTwo: UILabel = {
      let label = UILabel()
      label.text = ""
      label.backgroundColor = .red
      label.translatesAutoresizingMaskIntoConstraints = false
      return label
    }()

    let scrollView: UIScrollView = {
      let scrollView = UIScrollView()
//      scrollView.backgroundColor = .white
        scrollView.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)
      scrollView.translatesAutoresizingMaskIntoConstraints = false
      return scrollView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.hidesBackButton = true
//        view.backgroundColor = .white
        view.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: STATUS_BAR_HEIGHT))
        statusBar.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)
        
        
        self.view.addSubview(statusBar)
        
        naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: SCREEN.WIDTH, height: 50))
        naviBar.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)
//        self.view.addSubview(naviBar)
        
 
        
        
        
//        titleLabel = UILabel(frame: CGRect(x: self.view.frame.size.width / 2.5, y: 10, width: self.view.frame.size.width, height: 30))
        self.titleLabel.text = "회원탈퇴"
        //        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
//        titleLabel.font = UIFont(name: "SUITE-Regular", size: 25)
                titleLabel.font = UIFont(name: NanumSquareR, size: 20)
        titleLabel.textColor = .white
        //        titleLabel.font = UIFont.systemFont(ofSize: 25)
//        naviBar.addSubview(titleLabel)
        
        
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        naviBar.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        if naviLabel.text == "ko" {
            self.titleLabel.text = "회원탈퇴"
            self.titleLabel.font = UIFont(name: NanumSquareR, size: 20)
        }
        if naviLabel.text == "en" {
            self.titleLabel.text = "Membership Withdrawal"
            self.titleLabel.font = UIFont(name: NanumSquareR, size: 20)
        }

        
        let button = UIButton(type: .custom)
        //Set the image
        button.setImage(UIImage(named: "btn_d_back2"), for: .normal)
        button.tintColor = .white
        //Set the title
        button.setTitle("", for: .normal)
        button.tintColor = .black
        let origImage = UIImage(named: "btn_d_back2")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        button.tintColor = .white
        
        button.setTitleColor(.black, for: .normal)
        //Add target
        button.addTarget(self, action: #selector(callMethod), for: .touchUpInside)
        button.frame = CGRect(x: 20, y: 10, width: 60, height: 25)
        button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        button.sizeToFit()
        
//        naviBar.addSubview(button)
        
        
//        deleted = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
//        deleted.addTarget(self, action: #selector(deletedInfo(_ :)), for: .touchUpInside)
//        deleted.setTitle("회원 탈퇴", for: .normal)
//        deleted.setTitleColor(.black, for: .normal)
//        view.addSubview(deleted)
        
        
//        setupKeyboardEvent()
//        self.view.addSubview(UnderBar)
//        hideKeyboardWhenTappedAround()
        
        scrollView.keyboardDismissMode = .onDrag
        
        scrollView.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)

        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: naviBar.frame.maxY).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        //          scrollView.addSubview(labelOne)
        
        //          labelOne.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40).isActive = true
        //          labelOne.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40).isActive = true
        
        scrollView.addSubview(labelTwo)
        labelTwo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40).isActive = true
        labelTwo.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 3000).isActive = true
        labelTwo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40).isActive = true
        
        
        
        yourId = UITextField(frame: CGRect(x: 20, y: scrollView.frame.minY + 20, width: self.view.frame.size.width - 40, height: self.view.frame.size.height / 16))
//        originPw.layer.borderWidth = 1
//        yourId.isSecureTextEntry = true
        
//        yourId.placeholder = "아이디"
        
        
 
        
//        yourId.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        
        
        if naviLabel.text == "ko" {
            yourId.attributedPlaceholder = NSAttributedString(string: "아이디", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            yourId.font = UIFont(name: NanumSquareR, size: 20)
        }
        if naviLabel.text == "en" {
            yourId.attributedPlaceholder = NSAttributedString(string: "ID", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            yourId.font = UIFont(name: NanumSquareR, size: 20)
        }

        yourId.font = UIFont(name: NanumSquareR, size: 20)
        yourId.textColor = .white
        yourId.layer.borderWidth = 1
        yourId.layer.cornerRadius = 8
//        yourId.layer.borderColor = UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1.0).cgColor
        yourId.layer.borderColor = UIColor(red: 0.3269810677, green: 0.3502911031, blue: 0.3999183476, alpha: 1).cgColor
        
        
        yourId.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)
        
        
        
        
//        yourId.textColor = #colorLiteral(red: 0.8382223845, green: 0.8382223248, blue: 0.8382223248, alpha: 1)
        yourId.leftViewMode = .always
        yourId.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        yourId.font = UIFont(name: "SUITE-Regular", size: 22)
        scrollView.addSubview(yourId)
        
        yourPw = UITextField(frame: CGRect(x: 20, y: yourId.frame.maxY + 10, width: self.view.frame.size.width - 40, height: self.view.frame.size.height / 16))
//        originPw.layer.borderWidth = 1
        yourPw.isSecureTextEntry = true
        
        yourPw.placeholder = "비밀번호"
//        yourPw.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        if naviLabel.text == "ko" {
            yourPw.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            yourPw.font = UIFont(name: NanumSquareR, size: 20)
        }
        if naviLabel.text == "en" {
            yourPw.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            yourPw.font = UIFont(name: NanumSquareR, size: 20)
        }
        
        
        yourPw.textColor = .white
//        yourPw.textColor = #colorLiteral(red: 0.4742903709, green: 0.4996256232, blue: 0.5537593961, alpha: 1)
        yourPw.layer.borderWidth = 1
        yourPw.layer.cornerRadius = 8
//        yourPw.layer.borderColor = UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1.0).cgColor
        yourPw.layer.borderColor = UIColor(red: 0.3269810677, green: 0.3502911031, blue: 0.3999183476, alpha: 1).cgColor
        yourPw.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)
//        yourPw.textColor = #colorLiteral(red: 0.8382223845, green: 0.8382223248, blue: 0.8382223248, alpha: 1)
        yourPw.leftViewMode = .always
        yourPw.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        yourPw.font = UIFont(name: "SUITE-Regular", size: 22)
        yourPw.font = UIFont(name: NanumSquareR, size: 20)
        scrollView.addSubview(yourPw)

        
        yourPwCheck = UITextField(frame: CGRect(x: 20, y: yourPw.frame.maxY + 10, width: self.view.frame.size.width - 40, height: self.view.frame.size.height / 16))
//        originPw.layer.borderWidth = 1
        yourPwCheck.isSecureTextEntry = true
        
        yourPwCheck.placeholder = "비밀번호 재확인"
//        yourPwCheck.attributedPlaceholder = NSAttributedString(string: "비밀번호 재확인", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        if naviLabel.text == "ko" {
            yourPwCheck.attributedPlaceholder = NSAttributedString(string: "비밀번호 재확인", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            yourPwCheck.font = UIFont(name: NanumSquareR, size: 20)
        }
        if naviLabel.text == "en" {
            yourPwCheck.attributedPlaceholder = NSAttributedString(string: "Password Confirm", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
            yourPwCheck.font = UIFont(name: NanumSquareR, size: 20)
        }
        yourPwCheck.textColor = .white
        yourPwCheck.layer.borderWidth = 1
//        yourPwCheck.textColor = #colorLiteral(red: 0.4742903709, green: 0.4996256232, blue: 0.5537593961, alpha: 1)
        yourPwCheck.layer.cornerRadius = 8
//        yourPwCheck.layer.borderColor = UIColor(red: 205.0/255.0, green: 205.0/255.0, blue: 205.0/255.0, alpha: 1.0).cgColor
        yourPwCheck.layer.borderColor = UIColor(red: 0.3269810677, green: 0.3502911031, blue: 0.3999183476, alpha: 1).cgColor
        yourPwCheck.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)
//        yourPwCheck.textColor = #colorLiteral(red: 0.8382223845, green: 0.8382223248, blue: 0.8382223248, alpha: 1)
        yourPwCheck.leftViewMode = .always
        yourPwCheck.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        yourPwCheck.font = UIFont(name: "SUITE-Regular", size: 22)
        yourPwCheck.font = UIFont(name: NanumSquareR, size: 20)
        scrollView.addSubview(yourPwCheck)
        
        var checkView = UIView(frame: CGRect(x: 0, y: yourPwCheck.frame.maxY + 20, width: self.view.frame.width, height: 10))
        checkView.backgroundColor = #colorLiteral(red: 0.1692932546, green: 0.1824641526, blue: 0.2285180092, alpha: 1)
//        scrollView.addSubview(checkView)
        
        var infoString = UILabel(frame: CGRect(x: 25, y: yourPwCheck.frame.maxY + 20, width: self.view.frame.size.width - 50, height: 60))
        infoString.numberOfLines = 0
        infoString.font = UIFont(name: "SUITE-Regular", size: 15)
        infoString.text = "- 회원탈퇴 시 모든 정보가 삭제 되며, 이후 복구가 불가능합니다."
        
        
        
        if naviLabel.text == "ko" {
            infoString.text = "- 회원탈퇴 시 모든 정보가 삭제 되며, 이후 복구가 불가능합니다."
            infoString.font = UIFont(name: NanumSquareR, size: 15)
        }
        if naviLabel.text == "en" {
            
             infoString = UILabel(frame: CGRect(x: 25, y: yourPwCheck.frame.maxY + 20, width: self.view.frame.size.width - 50, height: 80))
            infoString.numberOfLines = 0
            infoString.font = UIFont(name: "SUITE-Regular", size: 15)
            infoString.font = UIFont(name: NanumSquareR, size: 15)
            infoString.text = "- All information will be deleted when membership is withdrawn, and recovery will not be possible afterwards."
        }
        
        infoString.textColor = .white
        infoString.font = UIFont(name: NanumSquareR, size: 15)
        scrollView.addSubview(infoString)
        
        var infoString2 = UILabel(frame: CGRect(x: 25, y: infoString.frame.maxY + 5, width: self.view.frame.size.width - 50, height: 60))
        infoString2.text = "- 본인이 직접 신청하셔야 하며, 회원 DB에 있는 정보와 일치하여야만 탈퇴가 가능합니다."
        
        if naviLabel.text == "ko" {
            infoString2.text = "- 본인이 직접 신청하셔야 하며, 회원 DB에 있는 정보와 일치하여야만 탈퇴가 가능합니다."
        }
        if naviLabel.text == "en" {
            
             infoString2 = UILabel(frame: CGRect(x: 25, y: infoString.frame.maxY + 5, width: self.view.frame.size.width - 50, height: 80))
            infoString2.numberOfLines = 0
            infoString2.font = UIFont(name: "SUITE-Regular", size: 15)
            infoString2.text = "- You have to apply for it yourself, and you can only leave if you match the information in the member DB."
        }
        
        
        infoString2.font = UIFont(name: "SUITE-Regular", size: 15)
        infoString2.textColor = .white
        infoString2.numberOfLines = 0
        infoString2.font = UIFont(name: NanumSquareR, size: 15)
        scrollView.addSubview(infoString2)
//        var originalPw = UILabel(frame: CGRect(x: 20, y: naviBar.frame.maxY + 20, width: 130, height: self.view.frame.size.height / 16))
//        originalPw.text = "아이디"
//        originalPw.font = UIFont(name: "SUITE-Regular", size: 16)
////        originalPw.font = UIFont.systemFont(ofSize: 18)
////        originalPw.layer.borderWidth = 1
//        scrollView.addSubview(originalPw)
       
        
        
        if naviLabel.text == "ko" {
            if IS_IPHONE_12PRO {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 310, width: self.view.frame.size.width, height: 65))
                
            } else if IS_IPHONE_15PRO {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 310, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_N_PLUS {
                        deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 270, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_N {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 215, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_12PRO_MAX {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 370, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_15PRO_MAX {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 370, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_MINI {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 270, width: self.view.frame.size.width, height: 65))
            } else {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 260, width: self.view.frame.size.width, height: 65))
            }
        }
        if naviLabel.text == "en" {
            
            if IS_IPHONE_12PRO {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 290, width: self.view.frame.size.width, height: 65))
                
            } else if IS_IPHONE_15PRO {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 290, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_N_PLUS {
                        deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 250, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_N {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 195, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_12PRO_MAX {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 350, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_15PRO_MAX {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 350, width: self.view.frame.size.width, height: 65))
            } else if IS_IPHONE_MINI {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 250, width: self.view.frame.size.width, height: 65))
            } else {
                deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 240, width: self.view.frame.size.width, height: 65))
            }
        }
        
        
        
        
        
//        deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 350, width: self.view.frame.size.width, height: 65))
//        if IS_IPHONE_12PRO {
//            deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 290, width: self.view.frame.size.width, height: 65))
//            
//        } else if IS_IPHONE_15PRO {
//            deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 290, width: self.view.frame.size.width, height: 65))
//        } else if IS_IPHONE_N_PLUS {
//                    deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 250, width: self.view.frame.size.width, height: 65))
//        } else if IS_IPHONE_N {
//            deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 195, width: self.view.frame.size.width, height: 65))
//        } else if IS_IPHONE_12PRO_MAX {
//            deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 350, width: self.view.frame.size.width, height: 65))
//        } else if IS_IPHONE_15PRO_MAX {
//            deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 350, width: self.view.frame.size.width, height: 65))
//        } else if IS_IPHONE_MINI {
//            deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 250, width: self.view.frame.size.width, height: 65))
//        } else {
//            deleted = UIButton(frame: CGRect(x: 0, y: infoString2.frame.maxY + 240, width: self.view.frame.size.width, height: 65))
//        }
//        deleted.setTitle("회원탈퇴 신청", for: .normal)
        
        
        if naviLabel.text == "ko" {
            deleted.setTitle("회원탈퇴 신청", for: .normal)
        }
        if naviLabel.text == "en" {
            
            deleted.setTitle("Member withdrawal request", for: .normal)
        }
        
        
        
        deleted.titleLabel?.font = UIFont(name: "NanumSquareR", size: 20)
        
        deleted.backgroundColor = #colorLiteral(red: 0.2607549131, green: 0.3430478871, blue: 0.5002248287, alpha: 1)
        deleted.addTarget(self, action: #selector(deletedInfo(_ :)), for: .touchUpInside)
        scrollView.addSubview(deleted)
       
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: naviBar.frame.maxY).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: deleted.bottomAnchor, constant: 50).isActive = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         // 네비게이션 바 숨기기
         self.navigationController?.setNavigationBarHidden(true, animated: animated)
     }
    @objc func callMethod(){
//        self.dismiss(animated: false)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func deletedInfo(_ sender: UIButton)
    {
//        let sid = "\(UserDefaults.standard.object(forKey: "userSid") ?? 0)"
        
        
        
        
//        //post data
//        let url = "http://strokedb.or.kr/app_new/user_out.asp"
//        
//        let para = ["user_sid" : sid,
//                    "user_id" : yourId.text!,
//                    "passwd" : yourPw.text!] as [String : Any]
        
        
//        let urlString = "https://app.m2comm.co.kr/SNUH/mem_out.php"
//        
//        let para = [
//            "sid":user_sid
//        
//        ]
        
        
        
        if yourId.text!.replacingOccurrences(of: " ", with: "") == "" {
//                    appDel.showAlert(title: "Notice", message: "비밀번호를 입력해주세요.")
//            showToast(message: "계정정보를 모두 입력해 주세요.", font: UIFont.systemFont(ofSize: 15))
            
            if naviLabel.text == "ko" {
                showToast(message: "계정정보를 모두 입력해 주세요.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            if naviLabel.text == "en" {
                
                showToast(message: "Please enter your account.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
//            deleted.titleLabel?.font = UIFont(name: "NanumSquareR", size: 20)
            
            return
        }
        if yourPw.text!.replacingOccurrences(of: " ", with: "") == "" {
//                    appDel.showAlert(title: "Notice", message: "비밀번호를 입력해주세요.")
//            showToast(message: "계정정보를 모두 입력해 주세요.", font: UIFont.systemFont(ofSize: 15))
            
            
            if naviLabel.text == "ko" {
                showToast(message: "계정정보를 모두 입력해 주세요.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            if naviLabel.text == "en" {
                
                showToast(message: "Please enter your account.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            
            
            return
        }
        if yourPwCheck.text!.replacingOccurrences(of: " ", with: "") == "" {
//                    appDel.showAlert(title: "Notice", message: "비밀번호를 입력해주세요.")
//            showToast(message: "계정정보를 모두 입력해 주세요.", font: UIFont.systemFont(ofSize: 15))
            
            
            if naviLabel.text == "ko" {
                showToast(message: "계정정보를 모두 입력해 주세요.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            if naviLabel.text == "en" {
                
                showToast(message: "Please enter your account.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            return
        }
        
        
        if yourPw.text!.replacingOccurrences(of: " ", with: "") != yourPwCheck.text!.replacingOccurrences(of: " ", with: "") {
//            showToast(message: "비밀번호가 일치하지 않습니다.", font: UIFont.systemFont(ofSize: 15))
            
            
            
            if naviLabel.text == "ko" {
                showToast(message: "비밀번호가 일치하지 않습니다.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            if naviLabel.text == "en" {
                
                showToast(message: "Invalied password.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            
            
            return
        }
        
        if yourId.text != UserDefaults.standard.value(forKey: "USER_ID") as! String {
            
//            showToast(message: "일치하는 계정이 없습니다.", font: UIFont.systemFont(ofSize: 15))
            
            
            if naviLabel.text == "ko" {
                showToast(message: "일치하는 계정이 없습니다.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            if naviLabel.text == "en" {
                
                showToast(message: "Invalied id.", font: UIFont(name: "NanumSquareR", size: 15)!)
            }
            
            
        } else {
//            show(alertType: .canCancel, alertText: "노인평가도구 회원에서\n탈퇴 하시겠습니까?", confirmButtonText: "아니오", cancelButtonText: "예")
        
        
            if naviLabel.text == "ko" {
                show(alertType: .canCancel, alertText: "노인평가도구 회원에서\n탈퇴 하시겠습니까?", confirmButtonText: "아니오", cancelButtonText: "예")
            }
            if naviLabel.text == "en" {
                
                show(alertType: .canCancel, alertText: "Do you want to leave the membership?", confirmButtonText: "No", cancelButtonText: "Yes")
            }
            
            
            
//            let alert = UIAlertController(title: "알림", message: "탈퇴 하시겠습니까?", preferredStyle: .alert)
//            
//                        alert.addAction(UIAlertAction(title: "취소", style: .default) { action in
//                          //취소처리...
//                        })
//                        alert.addAction(UIAlertAction(title: "확인", style: .default) { action in
//                            let urlString = "https://app.m2comm.co.kr/SNUH/mem_out.php"
//                            
////                            let para = [
////
////
////                            ]
//                            
//                            
//                            let para = ["sid":user_sid,
//                                        "id" : self.yourId.text!,
//                                        "pw" : self.yourPw.text!] as [String : String]
//                            
//                            
//                            
//                            
//                            
//                            
//                            let request = Server.postData(urlString: urlString, otherInfo: para, completion: { (kData : Data?) in
//                                if let data = kData{
//                                    
//                                    
//                                    
//                                
//                                    
//                                    
//                                    
//                                    
//                                    
//                                    if let dataString = data.toString() {
//                                        print("appdel : logoutDataString : \(dataString)")
//                                        
//                                        
//                                        
//                                        
//                                        
//                                        
//                                    }
//                                    
//                                    
//                                    
//                            
//                                    
//                                    
//                                    
//                                    if let dataDic = data.toJson() as? [String:Any]{
//                                        if let resultY = dataDic["result"] as? Int {
//                                            let messageS = dataDic["message"] as? String
//                                                print("\(messageS)")
//                                            if resultY == 1 {
//                                                print("YES")
//                                                
//                                                
//                                                let alertController = UIAlertController(title: "노인평가도구", message: "회원 탈퇴가 완료되었습니다.", preferredStyle: .alert)
//                                                   
//                                                   // 얼럿을 화면에 표시
//                                                self.present(alertController, animated: true, completion: {
//                                                       // 2초 후에 얼럿을 닫기 위한 디스패치 큐 설정
//                                                       DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                                                           alertController.dismiss(animated: true, completion: nil)
//                                                           
//                                                           let rootViewController = LoginViewController() // YourRootViewController를 실제 루트 뷰 컨트롤러의 클래스 이름으로 변경하세요.
//                                                              
//                                                           rootViewController.navigationItem.hidesBackButton = true
//                                                           
//                                                           
//                                                              // 현재 네비게이션 컨트롤러의 viewControllers 배열을 루트 뷰 컨트롤러만 포함하도록 설정
//                                                              if let navigationController = self.navigationController {
//                                                                  navigationController.setViewControllers([rootViewController], animated: true)
//                                                              } else {
//                                                                  // 네비게이션 컨트롤러가 없는 경우
//                                                                  // 현재 윈도우의 루트 뷰 컨트롤러를 설정
//                                                                  if let window = UIApplication.shared.windows.first {
//                                                                      window.rootViewController = UINavigationController(rootViewController: rootViewController)
//                                                                      window.makeKeyAndVisible()
//                                                                  }
//                                                              }
//                                                           
////                                                           self.navigationController?.popViewController(animated: true)
//                                                           
////                                                           let vc = LoginViewController()
////                                                           //
////                                                                                                                       vc.modalPresentationStyle = .fullScreen
////                                                                                                                       self.present(vc, animated: false)
//                                                           
//                                                       }
//                                                   })
//                                                
//                                                
//                                                
//                                                
//                                            } else {
//                                                print("NO")
//                                            }
//                                        }
//                                        
//                //                        if let app_YN = dataDic["app_YN"] as? String{
//                //                            if app_YN == "Y"{
//                //                                complete(true)
//                //                                self.loginTimer?.invalidate()
//                //                                return
//                //                            }
//                //                            appDel.showAlert(title: "Notice", message: "승인이 필요한 아이디입니다.")
//                //                            complete(false)
//                //                            self.loginTimer?.invalidate()
//                //                            return
//                //                        }
//                                    }
//                                }
//                //                appDel.showAlert(title: "Notice", message: "로그인에 실패하였습니다.")
//                //                complete(false)
//                //                self.loginTimer?.invalidate()
//                                return
//                            })
//                        })
//                        self.present(alert, animated: true, completion: nil)
//                        
//                        
//                        
//                        
//                        
//            //            let urlString = "https://app.m2comm.co.kr/SNUH/mem_out.php"
//            //
//            //            let para = [
//            //                "sid":user_sid
//            //
//            //            ]
//            //
//            //
//            //            let request = Server.postData(urlString: urlString, otherInfo: para, completion: { (kData : Data?) in
//            //                if let data = kData{
//            //
//            //
//            //
//            //
//            //
//            //
//            //
//            //
//            //
//            //                    if let dataString = data.toString() {
//            //                        print("appdel : logoutDataString : \(dataString)")
//            //                    }
//            //
//            //
//            //
//            //
//            //
//            //
//            //
//            //                    if let dataDic = data.toJson() as? [String:Any]{
//            //                        if let resultY = dataDic["result"] as? String {
//            //                            if resultY == "Y" {
//            //                                print("YES")
//            //                            } else {
//            //                                print("NO")
//            //                            }
//            //                        }
//            //
//            ////                        if let app_YN = dataDic["app_YN"] as? String{
//            ////                            if app_YN == "Y"{
//            ////                                complete(true)
//            ////                                self.loginTimer?.invalidate()
//            ////                                return
//            ////                            }
//            ////                            appDel.showAlert(title: "Notice", message: "승인이 필요한 아이디입니다.")
//            ////                            complete(false)
//            ////                            self.loginTimer?.invalidate()
//            ////                            return
//            ////                        }
//            //                    }
//            //                }
//            ////                appDel.showAlert(title: "Notice", message: "로그인에 실패하였습니다.")
//            ////                complete(false)
//            ////                self.loginTimer?.invalidate()
//            //                return
//            //            })
//                        
//                        
//            //            self.loginTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
//            //                print("2초 이내 로그인 실패 -> 실패")
//            //                request?.cancel()
//            //                complete(false)
//            //            }
//
//                        
//                        
//                        
//                        
//                        
//                        
//                        
//            //            let nextVC = LoginViewController()
//            //            self.navigationController?.pushViewController(nextVC, animated: true)
//                        return
//        
//        
//        
////        AF.request(url, method: .post, parameters: para, encoding: URLEncoding.default)
////            .responseJSON { [self] response in
////                
////                print("success??")
////                print("result\(response)")
////                
////                
////                
////                switch response.result {
////                case .success(let suc):
////                    print("su")
////                    
////                    
////                    guard let result = response.data else {return}
////                    
////                    do {
////                        let decoder = JSONDecoder()
////                        let json = try decoder.decode(Deleted.self, from: result)
////                        
////                        print("????\(json.message)")
////                        
////                        
////                        
////                        
////                        if json.message == "탈퇴처리 되었습니다." {
////                            let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
////                            loginVC?.navigationController?.navigationBar.isHidden = true
////                    //        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
////                            UIApplication.shared.windows.first?.rootViewController = loginVC
////                            UIApplication.shared.windows.first?.makeKeyAndVisible()
////                            
////                            
////                            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
////                            self.navigationController?.navigationBar.shadowImage = UIImage()
////                            
////                            
////                            
////                    //        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
////                    //
////                    //
////                    //          let homeVC = ViewController()
////                    //          homeVC.modalPresentationStyle = .fullScreen
////                    //          let appDelegate = UIApplication.shared.delegate as! AppDelegate
////                    //          appDelegate.window?.rootViewController?.present(homeVC, animated: true, completion: nil)
////                    //
////                    //
////                    //        })
////                            
////                            
////                            print("logout: \(UserDefaults.standard.value(forKey: "username"))")
////                                        UserDefaults.standard.removeObject(forKey: "username")
////                                        
////                                        
////                                        
////                                        UserDefaults.standard.set("", forKey: "username")
////                                        
////                                        
////                                        UserDefaults.standard.synchronize()
////                  
////                            
////                        } else {
////                            showToast(message: json.message, font: UIFont.systemFont(ofSize: 15))
////                        }
////                        
////                        
////                        
//////                        if json.message == "가입이 완료되었습니다." {
//////
//////                            let vc = FinishJoinViewController()
//////                            vc.modalPresentationStyle = .fullScreen
//////                            self.present(vc, animated: false)
//////
//////                        } else {
//////                            showToast(message: json.message, font: UIFont.systemFont(ofSize: 15))
//////                        }
//////
//////                        showToast(message: json.message, font: UIFont.systemFont(ofSize: 15))
//////
//////
//////                        //                        toastShow(message: json.message)
//////
////                        UserDefaults.standard.synchronize()
////            
//////            let loginVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
//////            loginVC?.navigationController?.navigationBar.isHidden = true
//////    //        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "tabBarcontroller") as! UITabBarController
//////            UIApplication.shared.windows.first?.rootViewController = loginVC
//////            UIApplication.shared.windows.first?.makeKeyAndVisible()
//////
//////
//////            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//////            self.navigationController?.navigationBar.shadowImage = UIImage()
//////
//////
//////
//////    //        self.view.window?.rootViewController?.dismiss(animated: false, completion: {
//////    //
//////    //
//////    //          let homeVC = ViewController()
//////    //          homeVC.modalPresentationStyle = .fullScreen
//////    //          let appDelegate = UIApplication.shared.delegate as! AppDelegate
//////    //          appDelegate.window?.rootViewController?.present(homeVC, animated: true, completion: nil)
//////    //
//////    //
//////    //        })
//////
//////
//////            print("logout: \(UserDefaults.standard.value(forKey: "username"))")
//////                        UserDefaults.standard.removeObject(forKey: "username")
//////
//////
//////
//////                        UserDefaults.standard.set("", forKey: "username")
//////
//////
//////                        UserDefaults.standard.synchronize()
//////
////                        
////                        
////                        
////                        
////                        
////                        
////                        
////                        
////                    }
////                    catch {
////                        print("err \(error)")
////                    }
////                default:
////                    return
////                    
////                    
////                    
////                }
////                
////                
////                
////                
////                
////            }
////        
//        
        
        
    }
    
}
    
    func showToast(message : String, font: UIFont) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/3.6, y: self.view.frame.size.height / 1.8 , width: 200, height: 35))
            toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            toastLabel.textColor = UIColor.white
            toastLabel.font = font
        toastLabel.font = UIFont(name: NanumSquareR, size: 15)
            toastLabel.textAlignment = .center
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 0.8, delay: 0.1, options: .curveEaseOut, animations: {
                 toastLabel.alpha = 0.0
            }, completion: {(isCompleted) in
                toastLabel.removeFromSuperview()
            })
        }
//    func setupKeyboardEvent() {
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillShow),
//                                               name: UIResponder.keyboardWillShowNotification,
//                                               object: nil)
//        NotificationCenter.default.addObserver(self,
//                                               selector: #selector(keyboardWillHide),
//                                               name: UIResponder.keyboardWillHideNotification,
//                                               object: nil)
//    }
//    @objc func keyboardWillShow(_ sender: Notification) {
//        // keyboardFrame: 현재 동작하고 있는 이벤트에서 키보드의 frame을 받아옴
//        // currentTextField: 현재 응답을 받고있는 UITextField를 알아냅니다.
//        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
//              let currentTextField = UIResponder.currentResponder as? UITextField else { return }
//        
//        // Y축으로 키보드의 상단 위치
//        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//        // 현재 선택한 텍스트 필드의 Frame 값
//        let convertedTextFieldFrame = view.convert(currentTextField.frame,
//                                                  from: currentTextField.superview)
//        // Y축으로 현재 텍스트 필드의 하단 위치
//        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
//        
//        // Y축으로 텍스트필드 하단 위치가 키보드 상단 위치보다 클 때 (즉, 텍스트필드가 키보드에 가려질 때가 되겠죠!)
//        if textFieldBottomY > keyboardTopY {
//            let textFieldTopY = convertedTextFieldFrame.origin.y
//            // 노가다를 통해서 모든 기종에 적절한 크기를 설정함.
//            let newFrame = textFieldTopY - keyboardTopY/1.6
//            view.frame.origin.y -= newFrame
//        }
//    }
//    func hideKeyboardWhenTappedAround() {
//          let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//          tap.cancelsTouchesInView = false
//        tap.delegate = self
//          view.addGestureRecognizer(tap)
//      }
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}
