//
//  ResultShowViewController1.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 29/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class ResultShowViewController1: UIViewController {
    
    var naviBar : UIView!
    var backButton : ImageButton!
    
    var index = 0
    var infoDic = [String:Any]()
    
    var toolComponentViews = [ToolComponentView]()
    
    var scrollView : UIScrollView!
    
    var dataDic = [String:Any]()
    
    var score = 0
    var values = [String]()
    var buttons = [String]()
    
    
    var la: UILabel!
    var naviLabel: UILabel!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func dataDicToValue(dataDic : [String:Any]) {
        score = 0
        values = [String]()
        buttons = [String]()
        
        for i in 0..<10 {
            let key = "btn\(i+1)"
            if let value = dataDic[key] as? String {
                buttons.append(value)
            }else{
                break
            }
        }
        for i in 0..<10 {
            let key = "val\(i+1)"
            if let value = dataDic[key] as? String {
                values.append(value)
            }else{
                break
            }
        }
        if let scoreString = dataDic["sum"] as? String {
            if let scoreInt = Int(scoreString, radix: 10) {
                score = scoreInt
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("result1")
        
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("ko"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("en"), object: nil)
        
        self.dataDicToValue(dataDic: self.dataDic)
        
        self.view.backgroundColor = #colorLiteral(red: 0.8793651462, green: 0.8945010304, blue: 0.9114277959, alpha: 1)
        
        let bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: SCREEN.HEIGHT))
        bgImageView.image = UIImage(named: "bg")
        self.view.addSubview(bgImageView)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: STATUS_BAR_HEIGHT))
        self.view.addSubview(statusBar)
        
        
        naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: SCREEN.WIDTH, height: NAVIGATION_BAR_HEIGHT))
        self.view.addSubview(naviBar)
        
        
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
            let toolComponentView = ToolComponentView(index: i, infoDic: questions[i])
            toolComponentView.frame.origin.y = maxY
            scrollInnerView.addSubview(toolComponentView)
            maxY = toolComponentView.frame.maxY
            
            lastSeparaterView = toolComponentView.lastSeparaterView
            
            toolComponentViews.append(toolComponentView)
            
            if i < self.buttons.count {
                let buttonValueString = self.buttons[i]
                if let buttonValueInt = Int(buttonValueString, radix: 10) {
                    if (buttonValueInt - 1) < toolComponentView.selectButtons.count {
                        toolComponentView.buttonPressed(button: toolComponentView.selectButtons[buttonValueInt - 1])
                    }
                }else{
                    print("error tool1 buttons에 저장된 값이 버튼 항목을 초과")
                }
                
            }else{
                print("error - tool1 저장된 buttons 갯수보다 실제 질문 갯수가 더 많음")
            }
            
            for selectButton in toolComponentView.selectButtons {
                selectButton.isEnabled = false
            }
            
        }
        
        lastSeparaterView?.isHidden = true
        
        scrollInnerView.frame.size.height = maxY + 10
        scrollInnerView.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.bottomLeft,.bottomRight])
        
        let bottomView = UIView(frame: CGRect(x: 0, y: scrollInnerView.frame.maxY + 10, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        bottomView.clipsToBounds = true
        bottomView.center.x = SCREEN.WIDTH / 2
        bottomView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        scrollView.addSubview(bottomView)
        
        let titleView2 = ToolTitleView1(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 200), index: self.index, infoDic: self.infoDic)
        bottomView.addSubview(titleView2)
        
        let scoreBackView = UIView(frame: CGRect(x: 0, y: titleView2.frame.maxY, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 150))
        scoreBackView.backgroundColor = #colorLiteral(red: 0.148327142, green: 0.3321980238, blue: 0.6730743051, alpha: 1)
//        scoreBackView.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.bottomLeft,.bottomRight])
        bottomView.addSubview(scoreBackView)
        
        let scoreBackView2 = UIView(frame: scoreBackView.bounds)
        scoreBackView2.frame.size.height -= 20
        scoreBackView2.center = scoreBackView.frame.center
        scoreBackView.addSubview(scoreBackView2)
        
        let scoreTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: scoreBackView2.frame.size.width, height: 40))
        scoreTitleLabel.text = "점수"
        scoreTitleLabel.textAlignment = .center
        scoreTitleLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 20)
        scoreTitleLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        scoreBackView2.addSubview(scoreTitleLabel)
        
        let scoreValuelabel = UILabel(frame: CGRect(x: 0, y: scoreTitleLabel.frame.maxY, width: scoreBackView2.frame.size.width, height: scoreBackView2.frame.size.height - scoreTitleLabel.frame.maxY))
        scoreValuelabel.text = "\(score)"
        scoreValuelabel.textAlignment = .center
        scoreValuelabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 80)
        scoreValuelabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        scoreBackView2.addSubview(scoreValuelabel)
        
        var resultGraphViewImageName = ""
        if score < 2 {
            resultGraphViewImageName = "tool1_graph1"
        }else if score >= 2 && score < 4 {
            resultGraphViewImageName = "tool1_graph2"
        }else if score >= 4 && score < 6 {
            resultGraphViewImageName = "tool1_graph3"
        }else{
            resultGraphViewImageName = "tool1_graph4"
        }
        let resultGraphView = UIImageView(frame: CGRect(x: 0, y: scoreBackView.frame.maxY + 20, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        resultGraphView.setImageWithFrameHeight(image: UIImage(named: resultGraphViewImageName))
        bottomView.addSubview(resultGraphView)
        
        bottomView.frame.size.height = resultGraphView.frame.maxY + 20
        bottomView.layer.cornerRadius = 5
        
        
        scrollView.contentSize.height = max(scrollView.frame.size.height, bottomView.frame.maxY + 20)
        
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
    
    
    func setLanguage() {
            
            //설정된 언어 코드 가져오기
            let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String // 초기에 "ko-KR" , "en-KR" 등으로 저장되어있음
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
    
    @objc func la(_ sender: UIButton) {
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
    }
}

