//
//  ToolBaseViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 25/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

let TOOL_VIEW_CONTENT_WIDTH_RATIO : CGFloat = 0.9

class ToolViewController: UIViewController {

    var naviBar : UIView!
    var backButton : ImageButton!

    var index = 0
    var infoDic = [String:Any]()
    
    var toolComponentViews = [ToolComponentView]()
    
    var scrollView : UIScrollView!
    
    var la: UILabel!
    var naviLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        print("here??")
        
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("ko"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("en"), object: nil)
        
        print("--->\(naviLabel)")
        
        self.view.backgroundColor = #colorLiteral(red: 0.8793651462, green: 0.8945010304, blue: 0.9114277959, alpha: 1)
        
        let bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: SCREEN.HEIGHT))
        bgImageView.image = UIImage(named: "bg")
        self.view.addSubview(bgImageView)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: STATUS_BAR_HEIGHT))
        self.view.addSubview(statusBar)
        
        
        naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: SCREEN.WIDTH, height: NAVIGATION_BAR_HEIGHT))
        self.view.addSubview(naviBar)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("ko"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("en"), object: nil)
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        naviBar.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        backButton = ImageButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "btn_d_back2"), ratio: 1)
        backButton.addTarget(event: .touchUpInside) { (button) in
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.addSubview(backButton)
        
        let resultButton = ImageButton(frame: CGRect(x: naviBar.frame.size.width - naviBar.frame.size.height, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "btn_result"), ratio: 1)
        naviBar.addSubview(resultButton)
        resultButton.addTarget(event: .touchUpInside) { (button) in
            let settingVC = ResultListViewController()
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
        
        let titleView = ToolTitleView(frame: CGRect(x: 0, y: naviBar.frame.maxY + 15, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 200), index: self.index, infoDic: self.infoDic)
        titleView.center.x = SCREEN.WIDTH / 2
        self.view.addSubview(titleView)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: titleView.frame.maxY, width: SCREEN.WIDTH, height: SCREEN.HEIGHT - titleView.frame.maxY))
        scrollView.backgroundColor = #colorLiteral(red: 0.8793651462, green: 0.8945010304, blue: 0.9114277959, alpha: 1)
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        let scrollInnerView = UIView(frame: scrollView.bounds)
        scrollInnerView.frame.size.width = titleView.frame.size.width
        scrollInnerView.center.x = scrollView.frame.size.width / 2
        scrollInnerView.backgroundColor = UIColor.white
        scrollView.addSubview(scrollInnerView)
        
        guard let questions = infoDic[MAIN_CONTENT_INFO_KEY.QUESTIONS] as? [[String:Any]] else { return }
        print("questions:\(questions)")
        
        var maxY : CGFloat = 0
        var lastSeparaterView : UIView?
        for i in 0..<questions.count {
            print("iiii:\(i)")
            let toolComponentView = ToolComponentView(index: i, infoDic: questions[i])
            toolComponentView.frame.origin.y = maxY
            scrollInnerView.addSubview(toolComponentView)
            maxY = toolComponentView.frame.maxY
            
            lastSeparaterView = toolComponentView.lastSeparaterView
            
            toolComponentViews.append(toolComponentView)
            
            
            
        }

        lastSeparaterView?.isHidden = true
        
        scrollInnerView.frame.size.height = maxY + 10
        scrollInnerView.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.bottomLeft,.bottomRight])
        
        let calculateButton = UIButton(frame: CGRect(x: 0, y: scrollInnerView.frame.maxY + 20, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 50))
        calculateButton.center.x = SCREEN.WIDTH / 2
        calculateButton.layer.cornerRadius = 5
        calculateButton.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        calculateButton.setTitle("Calculate", for: .normal)
        calculateButton.titleLabel?.font = UIFont(name: NanumSquareB, size: calculateButton.frame.size.height * 0.35)
        calculateButton.titleLabel?.textAlignment = .center
        calculateButton.backgroundColor = #colorLiteral(red: 0.170592159, green: 0.1802100539, blue: 0.2273285985, alpha: 1)
        calculateButton.addTarget(self, action: #selector(calculateButtonPressed), for: .touchUpInside)
        scrollView.addSubview(calculateButton)
        
        scrollView.contentSize.height = max(scrollView.frame.size.height, calculateButton.frame.maxY + 20)
        
//        la = UILabel(frame: CGRect(x: 200, y: 50, width: 100, height: 100))
//        la.text = "0"
//        la.textColor = .yellow
//        view.addSubview(la)
    }
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("ko"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("en"), object: nil)
        print("--->\(naviLabel)")
//
//        
//
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
    
//
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
//    
//
//  
//    
//    
//    
//    
    func setLanguage() {
            
            //설정된 언어 코드 가져오기
            let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.last as! String // 초기에 "ko-KR" , "en-KR" 등으로 저장되어있음
            let index = language.index(language.startIndex, offsetBy: 2)
            let languageCode = String(language[..<index]) //"ko" , "en" 등
            
            //설정된 언어 파일 가져오기
            let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
            let bundle = Bundle(path: path!)
        
       

        
        print("what[0]: \(toolComponentViews[0].titleLabel.text ?? "")")
       
        print(toolComponentViews[0].titleLabel.text == "혈중 단백질 (g/dL)")
        
        if toolComponentViews[0].titleLabel.text == "혈중 단백질 (g/dL)" {
            print("here!")
            //        if MAIN_CONTENT_INFO_KEY.TITLE == "Prediction tool for occurrence of adverse envets≥G3 (servere)" {
            toolComponentViews[0].titleLabel.text = bundle?.localizedString(forKey: "혈중 단백질 (g/dL)" , value: nil, table: nil)
//            MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
            
//            toolComponentViews[0].
            toolComponentViews[1].selectButtons[0].setTitle(bundle?.localizedString(forKey: "예" , value: nil, table: nil), for: .normal)
            toolComponentViews[1].selectButtons[1].setTitle(bundle?.localizedString(forKey: "아니오" , value: nil, table: nil), for: .normal)
            
            
            toolComponentViews[1].titleLabel.text = bundle?.localizedString(forKey: "첫번째 cycle에서 항암제 용량감량", value: nil, table: nil)
            toolComponentViews[2].titleLabel.text = bundle?.localizedString(forKey: "최근 3달간 심한 스트레스를 받거나 병을 앓은 적이 있다", value: nil, table: nil)
            
            toolComponentViews[2].selectButtons[0].setTitle(bundle?.localizedString(forKey: "예" , value: nil, table: nil), for: .normal)
            toolComponentViews[2].selectButtons[1].setTitle(bundle?.localizedString(forKey: "아니오" , value: nil, table: nil), for: .normal)

            
            toolComponentViews[3].titleLabel.text = bundle?.localizedString(forKey: "1일 수분 섭취량 (물, 주스, 커피, 차, 우유포함)", value: nil, table: nil)
            toolComponentViews[3].selectButtons[0].setTitle(bundle?.localizedString(forKey: "3컵 이상" , value: nil, table: nil), for: .normal)
            toolComponentViews[3].selectButtons[1].setTitle(bundle?.localizedString(forKey: "2컵 이하" , value: nil, table: nil), for: .normal)
            
            toolComponentViews[4].titleLabel.text = bundle?.localizedString(forKey: "말씀 드리는 대로 해 보십시오.\n\"오른손으로 받는다\"\n\n(지시를 끝낸 후에 종이를 건내 준다.\n지시를 반복하거나 옆에서 도와주면 안 됨", value: nil, table: nil)
            toolComponentViews[4].selectButtons[0].setTitle(bundle?.localizedString(forKey: "맞음" , value: nil, table: nil), for: .normal)
            toolComponentViews[4].selectButtons[1].setTitle(bundle?.localizedString(forKey: "틀림" , value: nil, table: nil), for: .normal)
            
            toolComponentViews[5].titleLabel.text = bundle?.localizedString(forKey: "본인의 현재 상태를 스스로 평가하면?", value: nil, table: nil)
            toolComponentViews[5].selectButtons[0].setTitle(bundle?.localizedString(forKey: "보통이거나\n아주 건강하다" , value: nil, table: nil), for: .normal)
            toolComponentViews[5].selectButtons[1].setTitle(bundle?.localizedString(forKey: "건강하지\n못하다" , value: nil, table: nil), for: .normal)
        } else if toolComponentViews[0].titleLabel.text == "도움 없이 혼자서 목욕을 하실 수 있습니까?" {
            
            //        } else if MAIN_CONTENT_INFO_KEY.TITLE == "KCSG-Geriatric Score 7\n(KG-7)" {
            toolComponentViews[0].titleLabel.text = bundle?.localizedString(forKey: "도움 없이 혼자서 목욕을 하실 수 있습니까?", value: nil, table: nil)
            toolComponentViews[0].selectButtons[0].setTitle(bundle?.localizedString(forKey: "예" , value: nil, table: nil), for: .normal)
            toolComponentViews[0].selectButtons[1].setTitle(bundle?.localizedString(forKey: "아니오" , value: nil, table: nil), for: .normal)
            
            toolComponentViews[1].titleLabel.text = bundle?.localizedString(forKey: "도움 없이 혼자서 계단을 오를 수 있습니까?", value: nil, table: nil)
            toolComponentViews[1].selectButtons[0].setTitle(bundle?.localizedString(forKey: "예" , value: nil, table: nil), for: .normal)
            toolComponentViews[1].selectButtons[1].setTitle(bundle?.localizedString(forKey: "아니오" , value: nil, table: nil), for: .normal)
            
            toolComponentViews[2].titleLabel.text = bundle?.localizedString(forKey: "필요한 물건은 모두 혼자서 구입할 수 있습니까?", value: nil, table: nil)
            toolComponentViews[2].selectButtons[0].setTitle(bundle?.localizedString(forKey: "예" , value: nil, table: nil), for: .normal)
            toolComponentViews[2].selectButtons[1].setTitle(bundle?.localizedString(forKey: "아니오" , value: nil, table: nil), for: .normal)
            
            toolComponentViews[3].titleLabel.text = bundle?.localizedString(forKey: "본인의 영양 상태를 스스로 평가하시면 어떻습니까?", value: nil, table: nil)
            toolComponentViews[3].selectButtons[0].setTitle(bundle?.localizedString(forKey: "양호" , value: nil, table: nil), for: .normal)
            toolComponentViews[3].selectButtons[1].setTitle(bundle?.localizedString(forKey: "불량" , value: nil, table: nil), for: .normal)
            
            toolComponentViews[4].titleLabel.text = bundle?.localizedString(forKey: "현재 매일 3가지 이상의 약물을 복용하고 있습니까?", value: nil, table: nil)
            toolComponentViews[4].selectButtons[0].setTitle(bundle?.localizedString(forKey: "아니오" , value: nil, table: nil), for: .normal)
            toolComponentViews[4].selectButtons[1].setTitle(bundle?.localizedString(forKey: "예" , value: nil, table: nil), for: .normal)
            
            
            toolComponentViews[5].titleLabel.text = bundle?.localizedString(forKey: "오늘이 몇 년도 몇 월 며칠 입니까?", value: nil, table: nil)
            toolComponentViews[5].selectButtons[0].setTitle(bundle?.localizedString(forKey: "맞춤" , value: nil, table: nil), for: .normal)
            toolComponentViews[5].selectButtons[1].setTitle(bundle?.localizedString(forKey: "못 맞춤" , value: nil, table: nil), for: .normal)
            
            toolComponentViews[6].titleLabel.text = bundle?.localizedString(forKey: "활동이나 의욕이 많이 줄었습니까?", value: nil, table: nil)
            toolComponentViews[6].selectButtons[0].setTitle(bundle?.localizedString(forKey: "아니오" , value: nil, table: nil), for: .normal)
            toolComponentViews[6].selectButtons[1].setTitle(bundle?.localizedString(forKey: "예" , value: nil, table: nil), for: .normal)
        } else if MAIN_CONTENT_INFO_KEY.TITLE == "Geriatric Prognosis Index" {
            toolComponentViews[0].titleLabel.text = bundle?.localizedString(forKey: "Age(years)", value: nil, table: nil)
            toolComponentViews[1].titleLabel.text = bundle?.localizedString(forKey: "ADL", value: nil, table: nil)
            toolComponentViews[2].titleLabel.text = bundle?.localizedString(forKey: "IADL", value: nil, table: nil)
            toolComponentViews[3].titleLabel.text = bundle?.localizedString(forKey: "Comorbidity", value: nil, table: nil)
            toolComponentViews[4].titleLabel.text = bundle?.localizedString(forKey: "Mood", value: nil, table: nil)
            toolComponentViews[5].titleLabel.text = bundle?.localizedString(forKey: "Cognition", value: nil, table: nil)
            toolComponentViews[6].titleLabel.text = bundle?.localizedString(forKey: "Nutritional status", value: nil, table: nil)
            
            
        }
//        } else {
//            
//        }
        
        
        
        
//            toolComponentViews[0].titleLabel.text = bundle?.localizedString(forKey: "혈중 단백질 (g/dL)", value: nil, table: nil)
//            toolComponentViews[1].titleLabel.text = bundle?.localizedString(forKey: "첫번째 cycle에서 항암제 용량감량", value: nil, table: nil)
//            toolComponentViews[2].titleLabel.text = bundle?.localizedString(forKey: "최근 3달간 심한 스트레스를 받거나 병을 앓은 적이 있다", value: nil, table: nil)
//            toolComponentViews[3].titleLabel.text = bundle?.localizedString(forKey: "1일 수분 섭취량 (물, 주스, 커피, 차, 우유포함)", value: nil, table: nil)
//            toolComponentViews[4].titleLabel.text = bundle?.localizedString(forKey: "말씀 드리는 대로 해 보십시오.\n\"오른손으로 받는다\"\n\n(지시를 끝낸 후에 종이를 건내 준다.\n지시를 반복하거나 옆에서 도와주면 안 됨", value: nil, table: nil)
//            toolComponentViews[5].titleLabel.text = bundle?.localizedString(forKey: "본인의 현재 상태를 스스로 평가하면?", value: nil, table: nil)
        
        
        
//        } else if MAIN_CONTENT_INFO_KEY.TITLE == "KCSG-Geriatric Score 7\n(KG-7)" {
//            toolComponentViews[6].titleLabel.text = bundle?.localizedString(forKey: "도움 없이 혼자서 목욕을 하실 수 있습니까?", value: nil, table: nil)
//            toolComponentViews[7].titleLabel.text = bundle?.localizedString(forKey: "도움 없이 혼자서 계단을 오를 수 있습니까?", value: nil, table: nil)
//            toolComponentViews[8].titleLabel.text = bundle?.localizedString(forKey: "필요한 물건은 모두 혼자서 구입할 수 있습니까?", value: nil, table: nil)
//            toolComponentViews[9].titleLabel.text = bundle?.localizedString(forKey: "본인의 영양 상태를 스스로 평가하시면 어떻습니까?", value: nil, table: nil)
//            toolComponentViews[10].titleLabel.text = bundle?.localizedString(forKey: "현재 매일 3가지 이상의 약물을 복용하고 있습니까?", value: nil, table: nil)
//            toolComponentViews[11].titleLabel.text = bundle?.localizedString(forKey: "오늘이 몇 년도 몇 월 며칠 입니까?", value: nil, table: nil)
//            toolComponentViews[12].titleLabel.text = bundle?.localizedString(forKey: "활동이나 의욕이 많이 줄었습니까?", value: nil, table: nil)
//        } else if MAIN_CONTENT_INFO_KEY.TITLE == "Geriatric Prognosis Index" {
//            
//            
//        }
//        if MAIN_CONTENT_INFO_KEY.TITLE == "Prediction tool for occurrence of adverse envets≥G3 (servere)" {
//            toolComponentViews[0].titleLabel.text = bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil)
//            toolComponentViews[1].titleLabel.text = bundle?.localizedString(forKey: "첫번째 cycle에서 항암제 용량감량", value: nil, table: nil)
//            toolComponentViews[2].titleLabel.text = bundle?.localizedString(forKey: "최근 3달간 심한 스트레스를 받거나 병을 앓은 적이 있다", value: nil, table: nil)
//            toolComponentViews[3].titleLabel.text = bundle?.localizedString(forKey: "1일 수분 섭취량 (물, 주스, 커피, 차, 우유포함)", value: nil, table: nil)
//            toolComponentViews[4].titleLabel.text = bundle?.localizedString(forKey: "말씀 드리는 대로 해 보십시오.\n\"오른손으로 받는다\"\n\n(지시를 끝낸 후에 종이를 건내 준다.\n지시를 반복하거나 옆에서 도와주면 안 됨", value: nil, table: nil)
//            toolComponentViews[5].titleLabel.text = bundle?.localizedString(forKey: "본인의 현재 상태를 스스로 평가하면?", value: nil, table: nil)
//        } else if MAIN_CONTENT_INFO_KEY.TITLE == "KCSG-Geriatric Score 7\n(KG-7)" {
//            toolComponentViews[0].titleLabel.text = bundle?.localizedString(forKey: "도움 없이 혼자서 목욕을 하실 수 있습니까?", value: nil, table: nil)
//            toolComponentViews[1].titleLabel.text = bundle?.localizedString(forKey: "도움 없이 혼자서 계단을 오를 수 있습니까?", value: nil, table: nil)
//            toolComponentViews[2].titleLabel.text = bundle?.localizedString(forKey: "필요한 물건은 모두 혼자서 구입할 수 있습니까?", value: nil, table: nil)
//            toolComponentViews[3].titleLabel.text = bundle?.localizedString(forKey: "본인의 영양 상태를 스스로 평가하시면 어떻습니까?", value: nil, table: nil)
//            toolComponentViews[4].titleLabel.text = bundle?.localizedString(forKey: "현재 매일 3가지 이상의 약물을 복용하고 있습니까?", value: nil, table: nil)
//            toolComponentViews[5].titleLabel.text = bundle?.localizedString(forKey: "오늘이 몇 년도 몇 월 며칠 입니까?", value: nil, table: nil)
//            toolComponentViews[6].titleLabel.text = bundle?.localizedString(forKey: "활동이나 의욕이 많이 줄었습니까?", value: nil, table: nil)
//        } else if MAIN_CONTENT_INFO_KEY.TITLE == "Geriatric Prognosis Index" {
//            
//            
//        }
        
        
        
//        MAIN_CONTENT_INFO_KEY.QUESTION = (bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil))!
//        _ = (bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil))!
//            myLabel.text = bundle?.localizedString(forKey: "Hello", value: nil, table: nil)
//            buttonKorean.setTitle(bundle?.localizedString(forKey: "buttonKorean", value: nil, table: nil), for: .normal)
        }
    
    
    
//    func setLa() {
//    
//    
//            let language = UserDefaults.standard.array(forKey: "AppleLanguges")?.first as! String
//            let index = language.index(language.startIndex, offsetBy: 2)
//            let languageCode = String(language[..<index])
//    
//            let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
//            let bundle = Bundle(path: path!)
//    
//            
//    
//    
//        }
    
    @objc func la(_ sender: UIButton) {
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
    }

    var isReset = true
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isReset {
            self.reset()
            self.scrollView.setContentOffset(CGPoint.zero, animated: false)
        }
        isReset = true
    }
    func reset(){
        
        GPIScore = 0
        score = 0
        values = [String]()
        buttons = [String]()
        
        for toolComponentView in toolComponentViews {
            toolComponentView.reset()
        }
    }

    var GPIScore : CGFloat = 0
    var score = 0
    var values = [String]()
    var buttons = [String]()
    
    @objc func calculateButtonPressed(){
        
        GPIScore = 0
        score = 0
        values = [String]()
        buttons = [String]()
        
        
        for i in 0..<self.toolComponentViews.count {
            let toolComponentView = toolComponentViews[i]
            let selectedIndex = toolComponentView.selectedIndex
            print("selectedIndex:\(selectedIndex)")
            if selectedIndex == -1 {
                let offSetY = min(toolComponentView.frame.origin.y, self.scrollView.contentOffset.y)
                self.scrollView.setContentOffset(CGPoint(x: 0, y: offSetY), animated: true)
                appDel.showAlert(title: "안내", message: "모든 항목을 입력해 주세요.")
                return
            }
            
            if self.index == 0 {
                calculateTool1(selectedIndex: selectedIndex, i: i + 1)
            }
            if self.index == 1 {
                calculateTool2(selectedIndex: selectedIndex, i: i + 1)
            }
            if self.index == 2 {
                calculateTool3(selectedIndex: selectedIndex, i: i + 1)
            }
        }
    
        if self.index == 0 {
            let resultVC = ResultViewController1()
            resultVC.index = index
            resultVC.infoDic = infoDic
            resultVC.values = values
            resultVC.buttons = buttons
            resultVC.score = score
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        if self.index == 1 {
            let resultVC = ResultViewController2()
            resultVC.index = index
            resultVC.infoDic = infoDic
            resultVC.values = values
            resultVC.buttons = buttons
            resultVC.score = score
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        if self.index == 2 {
            
            if (GPIScore == 0) {
                threePredictedMortalityRate = 0.7
                three95CI = "0.0 - 12.6"
                fivePredictedMortalityRate = 14.7
                five95CI = "0.0 - 14.7"
                flag = "1"
                
            }else if (GPIScore == 0.5) {
                threePredictedMortalityRate = 1.1
                three95CI = "0.0 - 15.2"
                fivePredictedMortalityRate = 15.9
                five95CI = "0.0 - 15.9"
                flag = "2"
                
            }else if (GPIScore == 1) {
                threePredictedMortalityRate = 1.5
                three95CI = "0.0 - 7.7"
                fivePredictedMortalityRate = 10.1
                five95CI = "0.4 - 10.1"
                flag = "3"
                
            }else if (GPIScore == 1.5) {
                threePredictedMortalityRate = 2.2
                three95CI = "0.2 - 8.6"
                fivePredictedMortalityRate = 12.1
                five95CI = "0.9 - 12.1"
                flag = "4"
                
            }else if (GPIScore == 2) {
                threePredictedMortalityRate = 3.1
                three95CI = "0.7 - 8.1"
                fivePredictedMortalityRate = 12.7
                five95CI = "2.6 - 12.7"
                flag = "5"
                
            }else if (GPIScore == 2.5) {
                threePredictedMortalityRate = 4.4
                three95CI = "1.4 - 9.8"
                fivePredictedMortalityRate = 15.9
                five95CI = "4.7 - 15.9"
                flag = "6"
                
            }else if (GPIScore == 3) {
                threePredictedMortalityRate = 6.1
                three95CI = "2.5 - 12.2"
                fivePredictedMortalityRate = 20.6
                five95CI = "7.5 - 20.6"
                flag = "7"
                
            }else if (GPIScore == 3.5) {
                threePredictedMortalityRate = 8.6
                three95CI = "4.1 - 15.4"
                fivePredictedMortalityRate = 26.5
                five95CI = "11.7 - 26.5"
                flag = "8"
                
            }else if (GPIScore == 4) {
                threePredictedMortalityRate = 11.9
                three95CI = "6.0 - 20.5"
                fivePredictedMortalityRate = 35.1
                five95CI = "16.3 - 35.1"
                flag = "9"
                
            }else if (GPIScore == 4.5) {
                threePredictedMortalityRate = 16.3
                three95CI = "9.2 - 25.7"
                fivePredictedMortalityRate = 43.7
                five95CI = "23.1 - 43.7"
                flag = "10"
                
            }else if (GPIScore == 5) {
                threePredictedMortalityRate = 21.8
                three95CI = "11.0 - 36.5"
                fivePredictedMortalityRate = 57.5
                five95CI = "27.5 - 57.5"
                flag = "11"
                
            }else if (GPIScore == 5.5) {
                threePredictedMortalityRate = 28.6
                three95CI = "15.3 - 45.4"
                fivePredictedMortalityRate = 68.1
                five95CI = "35.1 - 68.1"
                flag = "12"
                
            }else if (GPIScore == 6) {
                threePredictedMortalityRate = 36.6
                three95CI = "19.5 - 56.6"
                fivePredictedMortalityRate = 78.8
                five95CI = "41.4 - 78.8"
                flag = "13"
                
            }else if (GPIScore == 6.5) {
                threePredictedMortalityRate = 43.1
                three95CI = "8.0 - 85.7"
                fivePredictedMortalityRate = 97.7
                five95CI = "23.8 - 97.7"
                flag = "14"
                
            }else {
                threePredictedMortalityRate = 54.4
                three95CI = "7.6 - 96.2"
                fivePredictedMortalityRate = 100
                five95CI = "19.9 - 100.0"
                flag = "15"
                
            }
            
            let resultVC = ResultViewController3()
            resultVC.index = index
            resultVC.infoDic = infoDic
            resultVC.values = values
            resultVC.buttons = buttons
            resultVC.score = GPIScore
            
//            resultVC.threePredictedMortalityRate = threePredictedMortalityRate
            resultVC.threePredictedMortalityRateString = "\(threePredictedMortalityRate)"
            resultVC.three95CI = three95CI
//            resultVC.fivePredictedMortalityRate = fivePredictedMortalityRate
            resultVC.fivePredictedMortalityRateString = "\(fivePredictedMortalityRate)"
            resultVC.five95CI = five95CI
            resultVC.flag = flag
            
//            print("values:\(values)")
//            print("buttons:\(buttons)")
//            print("GPIScore:\(GPIScore)")
//            print("three95CI:\(three95CI)")
//            print("five95CI:\(five95CI)")
//            print("threePredictedMortalityRate:\(threePredictedMortalityRate)")
//            print("fivePredictedMortalityRate:\(fivePredictedMortalityRate)")
            
            self.navigationController?.pushViewController(resultVC, animated: true)
        }
        
        
    }

    
    func calculateTool1(selectedIndex : Int, i : Int){
        if selectedIndex == 1 {
            buttons.append("2")
            if i == 2 || i == 4 {
                score += 2
                values.append("2")
            }else if i == 3 {
                values.append("0")
            }else{
                score += 1
                values.append("1")
            }
        }else{
            buttons.append("1")
            if i == 3 {
                score += 1
                values.append("1")
            }else{
                values.append("0")
            }
        }
    }
    
    func calculateTool2(selectedIndex : Int, i : Int){
        print("calculateTool2:\(selectedIndex),\(i)")
        if selectedIndex == 0 {
            score += 1
            values.append("1")
            buttons.append("1")
        }else{
            values.append("0")
            buttons.append("2")
        }
    }
    
    
    var threePredictedMortalityRate : CGFloat = 0
    var fivePredictedMortalityRate : CGFloat = 0
    
    var threePredictedMortalityRateStirng = ""
    var fivePredictedMortalityRateString = ""
    
    
    var three95CI = ""
    var five95CI = ""
    
    var flag = "0"
    func calculateTool3(selectedIndex : Int, i : Int){
        print("calculateTool3:\(selectedIndex),\(i)")
        
        if i == 1 { //age
            if selectedIndex == 0 {
                values.append("0")
                buttons.append("1")
            }else if selectedIndex == 1 {
                GPIScore += 0.5
                values.append("0.5")
                buttons.append("2")
            }else{
                GPIScore += 1
                values.append("1")
                buttons.append("3")
            }
        }
        
        if i == 2 { //gender
            if selectedIndex == 0 {
                values.append("0")
                buttons.append("1")
            }else{
                GPIScore += 1
                values.append("1")
                buttons.append("2")
            }
        }
        
        if i >= 3 {
            if selectedIndex == 0 {
                GPIScore += 0
                values.append("0")
                buttons.append("1")
            }else if selectedIndex == 1 {
                if i == 5 {
                    GPIScore += 1
                    values.append("1")
                }else{
                    GPIScore += 0.5
                    values.append("0.5")
                }
                buttons.append("2")
            }else{
                GPIScore += 1
                values.append("1")
                buttons.append("3")
            }
        }
        
    }
}

