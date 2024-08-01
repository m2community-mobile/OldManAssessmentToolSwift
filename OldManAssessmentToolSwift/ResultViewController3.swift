//
//  ResultViewController3.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 27/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class ResultViewController3: UIViewController {

    var naviBar : UIView!
    var backButton : ImageButton!
    
    var index = 0
    var infoDic = [String:Any]()
    
    var scrollView : UIScrollView!
    
    var score : CGFloat = 0
    var values = [String]()
    var buttons = [String]()
    
    var clinicalResearchInputView : ClinicalResearchInputView?
    var patientInputView : PatientInputView!

    
//    var threePredictedMortalityRate : CGFloat = 0
//    var fivePredictedMortalityRate : CGFloat = 0
    
    var threePredictedMortalityRateString = ""
    var fivePredictedMortalityRateString = ""
    
    var three95CI = ""
    var five95CI = ""
    
    var flag = "0"
    
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
        
        let titleView = ToolTitleView3(frame: CGRect(x: 0, y: naviBar.frame.maxY + 15, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 200), index: self.index, infoDic: self.infoDic)
        titleView.center.x = SCREEN.WIDTH / 2
        self.view.addSubview(titleView)
        
        ////////////////////////////////////////////////////////////////
        scrollView = UIScrollView(frame: CGRect(x: 0, y: titleView.frame.maxY, width: SCREEN.WIDTH, height: SCREEN.HEIGHT - titleView.frame.maxY))
        scrollView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        ////////////////////////////////////////////////////////////////
        let scoreTitleView = ScoreTitleView(numberOfYears: 3, motaliteRateString: threePredictedMortalityRateString, ci_string: three95CI)
        scoreTitleView.center.x = scrollView.frame.size.width / 2
        scoreTitleView.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.bottomLeft,.bottomRight])
        scrollView.addSubview(scoreTitleView)
        
        ////////////////////////////////////////////////////////////////
        let threeResultGraphViewImageName = "tool3_graph1_check\(flag)"
        let resultGraphView = UIImageView(frame: CGRect(x: 0, y: scoreTitleView.frame.maxY + 10, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        resultGraphView.setImageWithFrameHeight(image: UIImage(named: threeResultGraphViewImageName))
        resultGraphView.center.x = scrollView.frame.size.width / 2
        scrollView.addSubview(resultGraphView)
        
        ////////////////////////////////////////////////////////////////
        let scoreTitleView2 = ScoreTitleView(numberOfYears: 5, motaliteRateString: fivePredictedMortalityRateString, ci_string: five95CI)
        scoreTitleView2.frame.origin.y = resultGraphView.frame.maxY + 20
        scoreTitleView2.center.x = scrollView.frame.size.width / 2
        scoreTitleView2.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.allCorners])
        scrollView.addSubview(scoreTitleView2)
        
        ////////////////////////////////////////////////////////////////
        let fiveResultGraphViewImageName = "tool3_graph3_check\(flag)"
        let resultGraphView2 = UIImageView(frame: CGRect(x: 0, y: scoreTitleView2.frame.maxY + 10, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        resultGraphView2.setImageWithFrameHeight(image: UIImage(named: fiveResultGraphViewImageName))
        resultGraphView2.center.x = scrollView.frame.size.width / 2
        scrollView.addSubview(resultGraphView2)
        
        var patientInputViewY : CGFloat = resultGraphView2.frame.maxY + 10
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
            "type":"3",
            "time":"\(time)",
            "patient":patientName,
            
            "flag":flag,
            "three95CI":three95CI,
            "five95CI":five95CI,
            "threeYears":"\(threePredictedMortalityRateString)",
            "fiveYears":"\(fivePredictedMortalityRateString)",
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
        
        para["risk"] = "GPI \(score) / 3years : \(threePredictedMortalityRateString) / 5years : \(fivePredictedMortalityRateString) "
        
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


class ToolTitleView3: UIView {
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
        indexLabel.text = "Tool3"
        indexLabel.font = UIFont(name: NanumSquareR, size: 15)
        if IS_IPHONE_SE {
            indexLabel.font = UIFont(name: NanumSquareR, size: 12)
        }
        indexLabel.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        indexLabel.sizeToFit()
        innerView.addSubview(indexLabel)
        
        let titleLabel = UILabel(frame: innerView.bounds)
        titleLabel.numberOfLines = 0
        titleLabel.text = "Geriatric Prognosis Index"
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
        titleLabel2.text = "PLoS One. 2016 Jan 15;11(1):e0147032."
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
            if let url = URL(string: "https://pubmed.ncbi.nlm.nih.gov/26771562/") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class ScoreTitleView: UIView {
    
    init(numberOfYears : Int, motaliteRateString : String, ci_string : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        
        self.backgroundColor = #colorLiteral(red: 0.148327142, green: 0.3321980238, blue: 0.6730743051, alpha: 1)
        
        let yearLabel = UILabel(frame: CGRect(x: 0, y: 20, width: self.frame.size.width, height: 40))
        yearLabel.text = "\(numberOfYears) years"
        yearLabel.textAlignment = .center
        yearLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        yearLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 17)
        yearLabel.sizeToFit()
        yearLabel.frame.size.width += 35
        yearLabel.frame.size.height += 15
        yearLabel.center.x = self.frame.size.width / 2
        yearLabel.backgroundColor = #colorLiteral(red: 0.002147085965, green: 0.2049075961, blue: 0.545507431, alpha: 1)
        yearLabel.layer.cornerRadius = yearLabel.frame.size.height / 2
        yearLabel.clipsToBounds = true
        self.addSubview(yearLabel)
        
        let subBackView = UIView(frame: CGRect(x: 0, y: yearLabel.frame.maxY + 15, width: self.frame.size.width - 15, height: 0))
        subBackView.center.x = self.frame.size.width / 2
        self.addSubview(subBackView)
        
        ////////////////////
        let leftView = UIView(frame: subBackView.bounds)
        leftView.frame.size.width *= 0.5
        subBackView.addSubview(leftView)
        
        let rightView = UIView(frame: subBackView.bounds)
        rightView.frame.size.width *= 0.5
        rightView.frame.origin.x = leftView.frame.maxX
        subBackView.addSubview(rightView)
        
        
        ////////////////////
        let leftTopLabel = UILabel(frame: leftView.bounds)
        leftTopLabel.frame.origin.y = 15
        leftTopLabel.numberOfLines = 0
        leftTopLabel.text = "Predicated\nmotality rate (%)"
        leftTopLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 15)
        leftTopLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        leftTopLabel.textAlignment = .center
        leftTopLabel.frame.size.height = 100
        leftTopLabel.sizeToFit()
        leftTopLabel.center.x = leftView.frame.size.width / 2
        leftView.addSubview(leftTopLabel)
        
        let rightTopLabel = UILabel(frame: rightView.bounds)
        rightTopLabel.frame.origin.y = 15
        rightTopLabel.numberOfLines = 0
        rightTopLabel.text = "95% CI (%)"
        rightTopLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 15)
        rightTopLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        rightTopLabel.textAlignment = .center
        rightTopLabel.frame.size.height = 100
        rightTopLabel.sizeToFit()
        rightTopLabel.center.x = rightView.frame.size.width / 2
        rightView.addSubview(rightTopLabel)
        
        let maxTopLabelHeight = max(leftTopLabel.frame.size.height, rightTopLabel.frame.size.height)
        leftTopLabel.frame.size.height = maxTopLabelHeight
        rightTopLabel.frame.size.height = maxTopLabelHeight
        
        
        ////////////////////
        let leftBottomLabel = UILabel(frame: leftView.bounds)
        leftBottomLabel.frame.origin.y = leftTopLabel.frame.maxY + 5
        leftBottomLabel.text = motaliteRateString
        leftBottomLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 30)
        leftBottomLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        leftBottomLabel.textAlignment = .center
        leftBottomLabel.frame.size.height = 100
        leftBottomLabel.sizeToFit()
        leftBottomLabel.center.x = leftView.frame.size.width / 2
        leftView.addSubview(leftBottomLabel)
        
        let rightBottomLabel = UILabel(frame: rightView.bounds)
        rightBottomLabel.frame.origin.y = rightTopLabel.frame.maxY + 5
        rightBottomLabel.text = ci_string
        rightBottomLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 30)
        rightBottomLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        rightBottomLabel.textAlignment = .center
        rightBottomLabel.frame.size.height = 100
        rightBottomLabel.sizeToFit()
        rightBottomLabel.center.x = rightView.frame.size.width / 2
        rightView.addSubview(rightBottomLabel)
        
        let maxBottomLabelHeight = max(leftBottomLabel.frame.size.height, rightBottomLabel.frame.size.height)
        leftBottomLabel.frame.size.height = maxBottomLabelHeight
        rightBottomLabel.frame.size.height = maxBottomLabelHeight
        
        leftView.frame.size.height = leftBottomLabel.frame.maxY + 15
        subBackView.frame.size.height = leftView.frame.maxY
        
        let separaterView1 = UIView(frame: CGRect(x: 0, y: 0, width: 0.5, height: subBackView.frame.size.height * 0.8))
        separaterView1.center = subBackView.frame.center
        separaterView1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subBackView.addSubview(separaterView1)
        
        self.frame.size.height = subBackView.frame.maxY + 20
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
