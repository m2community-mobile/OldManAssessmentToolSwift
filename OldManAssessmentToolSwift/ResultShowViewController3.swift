//
//  ResultShowViewController3.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 29/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class ResultShowViewController3: UIViewController {

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
    
    var threePredictedMortalityRate : CGFloat = 0
    var fivePredictedMortalityRate : CGFloat = 0
    
    var threePredictedMortalityRateString = ""
    var fivePredictedMortalityRateString = ""
    
    var three95CI = ""
    var five95CI = ""
    
    var flag = "0"
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func dataDicToValue(dataDic : [String:Any]) {
        print("ResultShowViewController3 dataDicToValue:\(dataDic)")
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
        
        if let threeYears = dataDic["threeYears"] as? String {
            threePredictedMortalityRateString = threeYears
        }
        
        if let fiveYears = dataDic["fiveYears"] as? String {
            fivePredictedMortalityRateString = fiveYears
        }
        if let value = dataDic["three95CI"] as? String {
            three95CI = value
        }
        if let value = dataDic["five95CI"] as? String {
            five95CI = value
        }
        if let value = dataDic["flag"] as? String {
            flag = value
        }
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("result3")
        
        self.dataDicToValue(dataDic: self.dataDic)
        
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
        bottomView.layer.cornerRadius = 5
        scrollView.addSubview(bottomView)
        
        let titleView2 = ToolTitleView3(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 200), index: self.index, infoDic: self.infoDic)
        bottomView.addSubview(titleView2)
        
        
        ////////////////////////////////////////////////////////////////
        let scoreTitleView = ScoreTitleView(numberOfYears: 3, motaliteRateString: threePredictedMortalityRateString, ci_string: three95CI)
        scoreTitleView.frame.origin.y = titleView2.frame.maxY
        scoreTitleView.center.x = bottomView.frame.size.width / 2
        scoreTitleView.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.bottomLeft,.bottomRight])
        bottomView.addSubview(scoreTitleView)
        
        ////////////////////////////////////////////////////////////////
        let threeResultGraphViewImageName = "tool3_graph1_check\(flag)"
        let resultGraphView = UIImageView(frame: CGRect(x: 0, y: scoreTitleView.frame.maxY + 10, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        resultGraphView.setImageWithFrameHeight(image: UIImage(named: threeResultGraphViewImageName))
        resultGraphView.center.x = bottomView.frame.size.width / 2
        bottomView.addSubview(resultGraphView)
        
        ////////////////////////////////////////////////////////////////
        let scoreTitleView2 = ScoreTitleView(numberOfYears: 5, motaliteRateString: fivePredictedMortalityRateString, ci_string: five95CI)
        scoreTitleView2.frame.origin.y = resultGraphView.frame.maxY + 20
        scoreTitleView2.center.x = bottomView.frame.size.width / 2
        scoreTitleView2.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.allCorners])
        bottomView.addSubview(scoreTitleView2)
        
        ////////////////////////////////////////////////////////////////
        let fiveResultGraphViewImageName = "tool3_graph3_check\(flag)"
        let resultGraphView2 = UIImageView(frame: CGRect(x: 0, y: scoreTitleView2.frame.maxY + 10, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        resultGraphView2.setImageWithFrameHeight(image: UIImage(named: fiveResultGraphViewImageName))
        resultGraphView2.center.x = bottomView.frame.size.width / 2
        bottomView.addSubview(resultGraphView2)
        
        bottomView.frame.size.height = resultGraphView2.frame.maxY + 10
        scrollView.contentSize.height = max(scrollView.frame.size.height, bottomView.frame.maxY)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
