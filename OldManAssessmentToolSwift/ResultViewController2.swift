//
//  ResultViewController2.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 27/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class ResultViewController2: UIViewController {

    var naviBar : UIView!
    var backButton : ImageButton!
    
    var index = 0
    var infoDic = [String:Any]()
    
    var scrollView : UIScrollView!
    
    var score = 0
    var values = [String]()
    var buttons = [String]()
    
    var clinicalResearchInputView : ClinicalResearchInputView?
    var patientInputView : PatientInputView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = #colorLiteral(red: 0.8793651462, green: 0.8945010304, blue: 0.9114277959, alpha: 1)
        
        let bgImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: SCREEN.HEIGHT))
        bgImageView.image = UIImage(named: "bg")
        self.view.addSubview(bgImageView)
        
        let statusBar = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: STATUS_BAR_HEIGHT))
        self.view.addSubview(statusBar)
        
        
        naviBar = UIView(frame: CGRect(x: 0, y: statusBar.frame.maxY, width: SCREEN.WIDTH, height: NAVIGATION_BAR_HEIGHT))
        self.view.addSubview(naviBar)
        
        
        backButton = ImageButton(frame: CGRect(x: 0, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "btn_d_back2"), ratio: 1)
        backButton.addTarget(event: .touchUpInside) { (button) in
            if let numberOfViewCons = self.navigationController?.viewControllers.count {
                if numberOfViewCons >= 2 {
                    if let toolVC = self.navigationController?.viewControllers[numberOfViewCons - 2] as? ToolViewController {
                        toolVC.isReset = false
                    }
                }
            }
            self.navigationController?.popViewController(animated: true)
        }
        naviBar.addSubview(backButton)
        
        let resultButton = ImageButton(frame: CGRect(x: naviBar.frame.size.width - naviBar.frame.size.height, y: 0, width: naviBar.frame.size.height, height: naviBar.frame.size.height), image: UIImage(named: "btn_result"), ratio: 1)
        naviBar.addSubview(resultButton)
        resultButton.addTarget(event: .touchUpInside) { (button) in
            let nextVC = ResultListViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        }
        
        let titleView = ToolTitleView2(frame: CGRect(x: 0, y: naviBar.frame.maxY + 15, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 200), index: self.index, infoDic: self.infoDic)
        titleView.center.x = SCREEN.WIDTH / 2
        self.view.addSubview(titleView)
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: titleView.frame.maxY, width: SCREEN.WIDTH, height: SCREEN.HEIGHT - titleView.frame.maxY))
        scrollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        let scoreBackView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 150))
        scoreBackView.center.x = scrollView.frame.size.width / 2
        scoreBackView.backgroundColor = #colorLiteral(red: 0.148327142, green: 0.3321980238, blue: 0.6730743051, alpha: 1)
        scrollView.addSubview(scoreBackView)
        
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
        
        let scoreValuelabel = UILabel(frame: CGRect(x: 0, y: scoreTitleLabel.frame.maxY, width: scoreBackView2.frame.size.width, height: 90))
        scoreValuelabel.text = "\(score)"
        scoreValuelabel.textAlignment = .center
        scoreValuelabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 80)
        scoreValuelabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        scoreBackView2.addSubview(scoreValuelabel)
        
        let subLabel = UILabel(frame: CGRect(x: 0, y: scoreValuelabel.frame.maxY, width: scoreBackView2.frame.size.width, height: 90))
        subLabel.numberOfLines = 0
        
        let para = NSMutableParagraphStyle()
        para.lineSpacing = 10
        para.alignment = .center
        
        var risk = ""
        if score <= 5 {
            risk = "Score ≤ 5 recommends full geriatric assessment."
        }else{
            risk = "Score ≥ 6 is normal."
        }
        
        subLabel.attributedText = NSAttributedString(
            string: risk,
            attributes: [
                NSAttributedString.Key.font : UIFont(name: Nanum_Barun_Gothic_OTF, size: 15)!,
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
                NSAttributedString.Key.paragraphStyle : para,
                
            ])
        subLabel.sizeToFit()
        subLabel.center.x = scoreBackView2.frame.size.width / 2
        scoreBackView2.addSubview(subLabel)
        
        scoreBackView2.frame.size.height = subLabel.frame.maxY
        scoreBackView.frame.size.height = scoreBackView2.frame.maxY + 10
        
        scoreBackView.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.bottomLeft,.bottomRight])
        
        var patientInputViewY : CGFloat = scoreBackView.frame.maxY + 10
        var patientInputViewTitle = "환자번호를 입력해 주세요."
        
        if let isResearch = userD.object(forKey: USER_RESEARCH_YN) as? String,
            isResearch.lowercased() == "y" {
            
            patientInputViewTitle = "임상연구 환자번호를 입력해 주세요."
            
            clinicalResearchInputView = ClinicalResearchInputView()
            clinicalResearchInputView?.frame.origin.y = patientInputViewY
            scrollView.addSubview(clinicalResearchInputView!)
            
            patientInputViewY = clinicalResearchInputView!.frame.maxY + 10
            
            ////
            
            requestGubunList { (kDataArray :[[String : Any]]) in
                self.clinicalResearchInputView!.dataArray = kDataArray
            }
        }
        
        patientInputView = PatientInputView(title: patientInputViewTitle)
        patientInputView.frame.origin.y = patientInputViewY
        patientInputView.textFieldView.textField.delegate = self
        patientInputView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        patientInputView.resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        scrollView.addSubview(patientInputView)
        
        scrollView.contentSize.height = max(scrollView.frame.size.height, patientInputView.frame.maxY)
        
    }
    
    @objc func resetButtonPressed(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonPressed(){
        
        print("saveButtonPressed")
        
        self.view.endEditing(true)
        
//        if let isResearch = userD.object(forKey: USER_RESEARCH_YN) as? String,
//            isResearch.lowercased() == "y" {
//            
//            if clinicalResearchInputView?.valueLabel.text == "선택해 주세요." {
//                appDel.showAlert(title: "Notice", message: "임상연구를 선택하세요.")
//                return
//            }
//        }
        
        let patientName = patientInputView.textFieldView.textField.text ?? ""
        if patientName.replacingOccurrences(of: " ", with: "") == "" {
            appDel.showAlert(title: "Notice", message: patientInputView.title)
            return
        }
        
        let urlString = "https://app.m2comm.co.kr/SNUH/insert_research.php"
        
        let time = Int(Date().timeIntervalSince1970)
        print("time:\(time)")
        
        var para = [
            "sid":user_sid,
            "sum":"\(score)",
            "type":"2",
            "time":"\(time)",
            "patient":patientName
        ]
        if let isResearch = userD.object(forKey: USER_RESEARCH_YN) as? String,
            isResearch.lowercased() == "y" {
            print("isResearch is Y")
            if let gubun = self.clinicalResearchInputView?.selectedDic["sid"] as? String {
                print("gubun sid : \(gubun)")
                para["gubun"] = gubun
            }
        }else{
            print("isResearch is nil or N, gubun sid is 0")
            para["gubun"] = "0"
        }
        
        for i in 0..<self.values.count {
            para["val\(i+1)"] = values[i]
            para["btn\(i+1)"] = buttons[i]
        }
        
        para["signdate"] = "\(time)"
        
        var risk = "\(score)점 "
        if score <= 5 {
            risk = "\(risk) Score ≤ 5 recommends full geriatric assessment."
        }else{
            risk = "\(risk) Score ≥ 6 is normal."
        }
        para["risk"] = risk
        
        print("urlString :\(urlString)")
        para.showValue()
        
        Server.postData(urlString: urlString, otherInfo: para) { (kData : Data?) in
            if let data = kData {
                if let dataString = data.toString() {
                    print("\(#function) dataString : \(dataString)")
                    
                    saveToolData(dataDic: para)
                    
                    appDel.showAlert(title: "Notice", message: "성공적으로 저장되었습니다.", actions: [UIAlertAction(title: "확인", style: .default, handler: { (action : UIAlertAction) in
                        self.navigationController?.popViewController(animated: true)
                    })], complete: {
                        
                    })
                    return
                }
            }
            
            appDel.showAlert(title: "Notice", message: "네트워크가 불안정합니다.")
        }
    }
    

    

}

class ToolTitleView2: UIView {
    init(frame : CGRect, index : Int, infoDic : [String:Any]) {
        super.init(frame: frame)
        
        if let backColor = infoDic[MAIN_CONTENT_INFO_KEY.BACKGROUND_COLOR] as? UIColor {
            self.backgroundColor = backColor
        }
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.size.width -= 40
        innerView.center.x = self.frame.size.width / 2
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        let indexLabel = UILabel(frame: innerView.bounds)
        indexLabel.text = "Tool2"
        indexLabel.font = UIFont(name: NanumSquareR, size: 15)
        if IS_IPHONE_SE {
            indexLabel.font = UIFont(name: NanumSquareR, size: 12)
        }
        indexLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        indexLabel.sizeToFit()
        innerView.addSubview(indexLabel)
        
        let titleLabel = UILabel(frame: innerView.bounds)
        titleLabel.numberOfLines = 0
        titleLabel.text = "KCSG-Geriatric Score 7 (KG-7)"
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = UIFont(name: NanumSquareB, size: 20)
        if IS_IPHONE_SE {
            titleLabel.font = UIFont(name: NanumSquareB, size: 15)
        }
        titleLabel.sizeToFit()
        titleLabel.frame.size.width = innerView.frame.size.width
        titleLabel.frame.origin.y = indexLabel.frame.maxY + 10
        innerView.addSubview(titleLabel)
        
        //Br J Cancer. 2018 May;118(9):1169-1175.
        let titleLabel2 = UILabel(frame: innerView.bounds)
        titleLabel2.numberOfLines = 0
        titleLabel2.text = "PLoS One. 2015 Sep 24;10(9):e0138304.\nCancer Res Treat. 2019 Jul;51(3):1249-1256."
        titleLabel2.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel2.font = UIFont(name: NanumSquareB, size: 13)
        if IS_IPHONE_SE {
            titleLabel2.font = UIFont(name: NanumSquareB, size: 11)
        }
        titleLabel2.frame.size.width = innerView.frame.size.width
        titleLabel2.frame.origin.y = titleLabel.frame.maxY + 2
        titleLabel2.sizeToFit()
        innerView.addSubview(titleLabel2)
        
        innerView.frame.size.height = titleLabel2.frame.maxY
        self.frame.size.height = innerView.frame.size.height + 20
        innerView.center.y = self.frame.size.height / 2
        
        self.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.topLeft,.topRight])
        
        
        let contentOpenButton = UIButton(frame: self.bounds)
        self.addSubview(contentOpenButton)
        contentOpenButton.addTarget(event: .touchUpInside) { _ in
            if let url = URL(string: "https://pubmed.ncbi.nlm.nih.gov/26401951/") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
