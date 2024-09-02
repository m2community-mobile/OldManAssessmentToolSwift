//
//  ResultViewController1.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 27/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class ResultViewController1: UIViewController {

    var naviBar : UIView!
    var backButton : ImageButton!
    
    var index = 0
    var infoDic = [String:Any]()
    
    var scrollView : UIScrollView!
    
    var score = 0
    var values = [String]()
    var buttons = [String]()
    
    var naviLabel : UILabel!
    
    var clinicalResearchInputView : ClinicalResearchInputView?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var patientInputView : PatientInputView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        naviBar.addSubview(naviLabel)
        naviLabel.isHidden = true
        
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
        
        let titleView = ToolTitleView1(frame: CGRect(x: 0, y: naviBar.frame.maxY + 15, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 200), index: self.index, infoDic: self.infoDic)
        titleView.center.x = SCREEN.WIDTH / 2
        self.view.addSubview(titleView)
        
        
        scrollView = UIScrollView(frame: CGRect(x: 0, y: titleView.frame.maxY, width: SCREEN.WIDTH, height: SCREEN.HEIGHT - titleView.frame.maxY))
        scrollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        let scoreBackView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 150))
        scoreBackView.center.x = scrollView.frame.size.width / 2
        scoreBackView.backgroundColor = #colorLiteral(red: 0.148327142, green: 0.3321980238, blue: 0.6730743051, alpha: 1)
        scoreBackView.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.bottomLeft,.bottomRight])
        scrollView.addSubview(scoreBackView)
        
        let scoreBackView2 = UIView(frame: scoreBackView.bounds)
        scoreBackView2.frame.size.height -= 20
        scoreBackView2.center = scoreBackView.frame.center
        scoreBackView.addSubview(scoreBackView2)
        
        let scoreTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: scoreBackView2.frame.size.width, height: 40))
        
        if naviLabel.text == "ko" {
            scoreTitleLabel.text = "점수"
        }
        if naviLabel.text == "en" {
            scoreTitleLabel.text = "score"
        }
//        scoreTitleLabel.text = "점수"
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
        let resultGraphView = UIImageView(frame: CGRect(x: 0, y: scoreBackView2.frame.maxY + 20, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        resultGraphView.setImageWithFrameHeight(image: UIImage(named: resultGraphViewImageName))
        resultGraphView.center.x = scrollView.frame.size.width / 2
        scrollView.addSubview(resultGraphView)
        
        var patientInputViewY : CGFloat = resultGraphView.frame.maxY + 10
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
        patientInputView.textFieldView.textField.delegate = self
        patientInputView.frame.origin.y = patientInputViewY
        patientInputView.saveButton.addTarget(self, action: #selector(saveButtonPressed), for: .touchUpInside)
        patientInputView.resetButton.addTarget(self, action: #selector(resetButtonPressed), for: .touchUpInside)
        scrollView.addSubview(patientInputView)
        
        scrollView.contentSize.height = max(scrollView.frame.size.height, patientInputView.frame.maxY)
        
        
        /////
//        self.clinicalResearchInputView?.selectedDic
        
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
            "type":"1",
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
        
        para["tool"] = "1"
        
        var risk = "\(score)점 "
        if score < 2 {
            risk = "\(risk) Low risk"
        }else if score >= 2 && score < 4 {
            risk = "\(risk) Medium-low risk"
        }else if score >= 4 && score < 6 {
            risk = "\(risk) Medium-high risk"
        }else{
            risk = "\(risk) High risk"
        }
        para["risk"] = risk
        
        print("urlString :\(urlString)")
        para.showValue()

        Server.postData(urlString: urlString, otherInfo: para) { (kData : Data?) in
            if let data = kData {
                if let dataString = data.toString() {
                    print("\(#function) dataString : \(dataString)")
                    //todo save
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

class ToolTitleView1: UIView {
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
        indexLabel.text = "Tool1"
        indexLabel.font = UIFont(name: NanumSquareR, size: 15)
        if IS_IPHONE_SE {
            indexLabel.font = UIFont(name: NanumSquareR, size: 12)
        }
        indexLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        indexLabel.sizeToFit()
        innerView.addSubview(indexLabel)
        
        let titleLabel = UILabel(frame: innerView.bounds)
        titleLabel.numberOfLines = 0
        titleLabel.text = "a\na"
        titleLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        titleLabel.font = UIFont(name: NanumSquareB, size: 20)
        if IS_IPHONE_SE {
            titleLabel.font = UIFont(name: NanumSquareB, size: 15)
        }
        titleLabel.sizeToFit()
        titleLabel.text = infoDic[MAIN_CONTENT_INFO_KEY.TITLE] as? String ?? ""
        titleLabel.frame.size.width = innerView.frame.size.width
        titleLabel.frame.origin.y = indexLabel.frame.maxY + 5
        innerView.addSubview(titleLabel)
        
        //Br J Cancer. 2018 May;118(9):1169-1175.
        let titleLabel2 = UILabel(frame: innerView.bounds)
        titleLabel2.text = "Br J Cancer. 2018 May;118(9):1169-1175."
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
            if let url = URL(string: "https://pubmed.ncbi.nlm.nih.gov/29576622/") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

