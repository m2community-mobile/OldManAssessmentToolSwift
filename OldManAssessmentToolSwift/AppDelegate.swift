//
//  AppDelegate.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 21/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var mainCon : MainViewController?
    var loginVC : LoginViewController?
    var naviCon : UINavigationController?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //todo remove
//        userD.removeObject(forKey: USER_ID)
        
        WebCacheCleaner.clean()
        
        addKeyboardObserver()
        
//        FirebaseApp.configure()
//        NotiCenter.shared.authorizationCheck()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        isLoading = true
        
        if isLogin {
            login { (success : Bool) in
                if success {
                    self.mainCon = MainViewController()
                    self.naviCon = UINavigationController(rootViewController: self.mainCon!)
                    self.naviCon?.isNavigationBarHidden = true
                    self.window?.rootViewController = self.naviCon
                    
                    self.window?.makeKeyAndVisible()
                }else{
                    self.loginVC = LoginViewController()
                    self.naviCon = UINavigationController(rootViewController: self.loginVC!)
                    self.naviCon?.isNavigationBarHidden = true
                    self.window?.rootViewController = self.naviCon
                    
                    self.window?.makeKeyAndVisible()
                }
                self.isLoading = false
            }
        }else{
            self.loginVC = LoginViewController()
            self.naviCon = UINavigationController(rootViewController: self.loginVC!)
            self.naviCon?.isNavigationBarHidden = true
            self.window?.rootViewController = self.naviCon
            
            self.window?.makeKeyAndVisible()
            
            self.isLoading = false
        }

        while isLoading {
            RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.01))
        }
        
//        if isLogin {
//            mainCon = MainViewController()
//            naviCon = UINavigationController(rootViewController: mainCon!)
//            naviCon?.isNavigationBarHidden = true
//            window?.rootViewController = naviCon
//        }else{
//            loginVC = LoginViewController()
//            naviCon = UINavigationController(rootViewController: loginVC!)
//            naviCon?.isNavigationBarHidden = true
//            window?.rootViewController = naviCon
//        }
//
//        window?.makeKeyAndVisible()
        
        
        versionCheck()
        
        return true
    }
    
    var isLoading = false
    var loginTimer : Timer?
    func login(complete:@escaping(_ success : Bool)->Void) {
        
        let urlString = "https://app.m2comm.co.kr/SNUH/login.php"
        
        let para = [
            "id":user_id,
            "pw":userD.string(forKey: USER_PW) ?? "",
            "device":"IOS",
            "deviceid":deviceID,
            "token":token_id
        ]
        
        
        let request = Server.postData(urlString: urlString, otherInfo: para, completion: { (kData : Data?) in
            if let data = kData{
                
                if let dataString = data.toString() {
                    print("appdel : loginDataString : \(dataString)")
                }
                
                if let dataDic = data.toJson() as? [String:Any]{
                    if let app_YN = dataDic["app_YN"] as? String{
                        if app_YN == "Y"{
                            complete(true)
                            self.loginTimer?.invalidate()
                            return
                        }
                        appDel.showAlert(title: "Notice", message: "승인이 필요한 아이디입니다.")
                        complete(false)
                        self.loginTimer?.invalidate()
                        return
                    }
                }
            }
//            appDel.showAlert(title: "Notice", message: "로그인에 실패하였습니다.")
            complete(false)
            self.loginTimer?.invalidate()
            return
        })
        
        
        self.loginTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (timer) in
            print("2초 이내 로그인 실패 -> 실패")
            request?.cancel()
            complete(false)
        }
    }
}


func versionCheck(){

    newVersionCheck2 { (isNew : Bool, urlString : String?) in
        if isNew {
            if let newVersionDownloadURLString = urlString {
                if let url = URL(string: newVersionDownloadURLString) {
                    if UIApplication.shared.canOpenURL(url) {

//                            let alertCon = UIAlertController(title: "Update", message: "A new version of the app has been released.", preferredStyle: UIAlertController.Style.alert)
//
//                            alertCon.addAction(UIAlertAction(title: "Update", style: .default, handler: { (action) in
//                                DispatchQueue.main.async {
//                                    UIApplication.shared.open(url, options: [:], completionHandler: { (fi) in
//
//                                    })
//                                }
//                            }))
                        
                        let alertCon = UIAlertController(title: "업데이트", message: "새로운 버전의 앱이 출시되었습니다.", preferredStyle: UIAlertController.Style.alert)
//                            let alertCon = UIAlertController(title: "업데이트", message: "버전이 업데이트되었습니다.\n앱스토어에서 업데이트 해주세요.", preferredStyle: UIAlertController.Style.alert)

                        alertCon.addAction(UIAlertAction(title: "업데이트", style: .default, handler: { (action) in
                            DispatchQueue.main.async {
                                UIApplication.shared.open(url, options: [:], completionHandler: { (fi) in

                                })
                            }
                        }))

                        DispatchQueue.main.async {
                            appDel.topVC?.present(alertCon, animated: true, completion: {

                            })
                        }
                    }
                }
            }
        }
    }
    
}

func newVersionCheck2( complete:@escaping( _ isNew : Bool, _ urlString : String?) -> Void ) {
    
    guard let bundleId = Bundle.main.bundleIdentifier else {
        complete(false, nil)
        return
    }
    
    let urlString = "https://itunes.apple.com/lookup?bundleId=\(bundleId)&asdf=\(Date().timeIntervalSince1970)"
    print("newVersionCheck urlString : \(urlString)")
    
    Server.postData(urlString: urlString) { (kData : Data?) in
        if let data = kData {
            if let dataDic = data.toJson() as? [String:Any] {
//                print("newVersionCheck dataDic :\(dataDic)")
                
                if let results = dataDic["results"] as? [[String:Any]] {
                    if results.count >= 1 {
                        let firstResultsDic = results[0]
                        if var versionString = firstResultsDic["version"] as? String {
                            versionString = versionString.replacingOccurrences(of: ".", with: "")
                            versionString = versionString.replacingOccurrences(of: " ", with: "")
                            if versionString.count == 2 {
                                versionString = "\(versionString)0"
                            }
                            if let appStoreVersion = Int(versionString, radix: 10) {
                                print("appStoreVersion:\(appStoreVersion)")
                                print("currentAppVersion:\(currentAppVersion())")
                                if appStoreVersion > currentAppVersion() {
                                    if let downloadURLString = firstResultsDic["trackViewUrl"] as? String {
                                        complete(true, downloadURLString)
                                        return
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    complete(false, nil)
    return
}

func currentAppVersion() -> Int {
    
    let infoDic = Bundle.main.infoDictionary
    if var versionString = infoDic!["CFBundleShortVersionString"] as? String {
        versionString = versionString.replacingOccurrences(of: ".", with: "")
        versionString = versionString.replacingOccurrences(of: " ", with: "")
        if versionString.count == 2 {
            versionString = "\(versionString)0"
        }
        if let currentVersion = Int(versionString, radix: 10) {
            return currentVersion
        }
    }
    return 0
}

