//
//  AboutTool.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 29/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class ToolComponentView: UIView {
    
    var index = 0
    var infoDic = [String:Any]()
    
    var indexLabel : UILabel!
    var titleLabel : UILabel!
    var selectButtons = [ToolSelectButton]()
    var selectedIndex = -1
    var naviLabel: UILabel!
    var lastSeparaterView : UIView!
    var button: ToolSelectButtonTypeA!
    
    init(index kIndex : Int, infoDic kInfoDic : [String:Any]) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 0))
        
        index = kIndex
        infoDic = kInfoDic
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.size.width -= 40
        innerView.center.x = self.frame.size.width / 2
        innerView.isUserInteractionEnabled = true
        self.addSubview(innerView)
        
        indexLabel = UILabel(frame: CGRect(x: 0, y: 20, width: innerView.frame.size.width, height: 40))
        indexLabel.text = String(NSString(format: "%02d", index + 1))
        indexLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        indexLabel.font = UIFont(name: NanumSquareR, size: 14)
        indexLabel.sizeToFit()
        indexLabel.frame.size.width = innerView.frame.size.width
        innerView.addSubview(indexLabel)
        
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        self.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: indexLabel.frame.maxY + 5, width: innerView.frame.size.width, height: 1000))
//        titleLabel.backgroundColor = .yellow
        titleLabel.numberOfLines = 10
        titleLabel.textColor = #colorLiteral(red: 0.2588235294, green: 0.3450980392, blue: 0.5019607843, alpha: 1)
        titleLabel.font = UIFont(name: NanumSquareR, size: indexLabel.font.pointSize + 3)
        titleLabel.text = infoDic[MAIN_CONTENT_INFO_KEY.QUESTION] as? String
        titleLabel.sizeToFit()
        titleLabel.frame.size.width = innerView.frame.size.width
        innerView.addSubview(titleLabel)
        print("num ----> \(titleLabel.text)")
        
        let answerBackView = UIView(frame: CGRect(x: 0, y: titleLabel.frame.maxY + 15, width: innerView.frame.size.width, height: 45))
        answerBackView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        answerBackView.layer.borderWidth = 0.5
        innerView.addSubview(answerBackView)
        
        let answers = infoDic[MAIN_CONTENT_INFO_KEY.ANSWERS] as? [String] ?? [String]()
        //        print("answers:\(answers)")
        
        if let _ = infoDic[MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B] {
            //ToolSelectButton
            var maxY : CGFloat = 0
            for i in 0..<answers.count {
                let button = ToolSelectButtonTypeB(value: answers[i])
                button.center.x = answerBackView.frame.size.width / 2
                button.frame.origin.y = maxY
                answerBackView.addSubview(button)
                selectButtons.append(button)
                button.addTarget(self, action: #selector(buttonPressed(button:)), for: .touchUpInside)
                
                maxY = button.frame.maxY
                
                if i != (answers.count - 1) {
                    let separaterView1 = UIView(frame: CGRect(x: 0, y: maxY, width: answerBackView.frame.size.width, height: 0.5))
                    separaterView1.center.y = maxY
                    separaterView1.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    answerBackView.addSubview(separaterView1)
                    
                    maxY = separaterView1.frame.maxY
                }
            }
            answerBackView.frame.size.height = maxY
            
        }else{
            let buttonWidth = answerBackView.frame.size.width / CGFloat(answers.count)
            let buttonHeight = answerBackView.frame.size.height
            for i in 0..<answers.count {
                 button = ToolSelectButtonTypeA(frame: CGRect(
                    x: CGFloat(i) * buttonWidth,
                    y: 0,
                    width: buttonWidth,
                    height: buttonHeight))
                button.setTitle(answers[i], for: .normal)
                button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                button.titleLabel?.font = UIFont(name: NanumSquareR, size: 15)
                button.titleLabel?.numberOfLines = 0
                button.titleLabel?.textAlignment = .center
                button.sizeToFit()
                button.frame.size.width = buttonWidth
                button.frame.size.height += 5
                answerBackView.addSubview(button)
                selectButtons.append(button)
                button.addTarget(self, action: #selector(buttonPressed(button:)), for: .touchUpInside)
                
                button.frame.size.height = max(answerBackView.frame.size.height, button.frame.size.height)
                answerBackView.frame.size.height = button.frame.size.height
                button.center.y = answerBackView.frame.size.height / 2
                
                
                if i != 0 {
                    let separaterView1 = UIView(frame: CGRect(x: 0, y: 0, width: 0.5, height: answerBackView.frame.size.height))
                    separaterView1.center.x = CGFloat(i) * buttonWidth
                    separaterView1.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    answerBackView.addSubview(separaterView1)
                }
            }
            
            
        }
        
        
        
        
        innerView.frame.size.height = answerBackView.frame.maxY + 20
        self.frame.size.height = innerView.frame.size.height
        
        
        lastSeparaterView = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 0.5, width: self.frame.size.width - 40, height: 0.5))
        lastSeparaterView.center.x = self.frame.size.width / 2
        lastSeparaterView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.addSubview(lastSeparaterView)
        
        
//        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("ko"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(la(_ :)), name: Notification.Name("en"), object: nil)
//
//        
//
//        if naviLabel.text == "ko" {
//            //한국어로 변경
//                  UserDefaults.standard.set(["ko"], forKey: "AppleLanguages")
////                  UserDefaults.standard.synchronize()
//                  
//                  //보통 메인화면으로 이동시켜줌
//                  setLanguage()
//            
//            
//        } 
//        if naviLabel.text == "en" {
//            //영어로 변경
//                   UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
////                   UserDefaults.standard.synchronize()
//            
//            
//                   
//                   //보통 메인화면으로 이동시켜줌
//                   setLanguage()
//            
//            
//            
//            
//            
//            
//         
//        }
        
    }
    
        
        
        
        
        
        
    
//    
//    @objc func la(_ sender: UIButton) {
//        naviLabel.text = UserDefaults.standard.string(forKey: "la")
//    }
//    
//    func setLanguage() {
//            
//            //설정된 언어 코드 가져오기
//            let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String // 초기에 "ko-KR" , "en-KR" 등으로 저장되어있음
//            let index = language.index(language.startIndex, offsetBy: 2)
//            let languageCode = String(language[..<index]) //"ko" , "en" 등
//            
//            //설정된 언어 파일 가져오기
//            let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
//            let bundle = Bundle(path: path!)
//        
//        
//        
////        titleLabel.text = (bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil))
////        titleLabel.text = (bundle?.localizedString(forKey: "첫번째 cycle에서 항암제 용량감량", value: nil, table: nil))
//        
////        toolComponentViews[0].titleLabel.text = bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil)
////                  toolComponentViews[1].titleLabel.text = bundle?.localizedString(forKey: "첫번째 cycle에서 항암제 용량감량", value: nil, table: nil)
////                  toolComponentViews[2].titleLabel.text = bundle?.localizedString(forKey: "최근 3달간 심한 스트레스를 받거나 병을 앓은 적이 있다", value: nil, table: nil)
////                  toolComponentViews[3].titleLabel.text = bundle?.localizedString(forKey: "1일 수분 섭취량 (물, 주스, 커피, 차, 우유포함)", value: nil, table: nil)
////                  toolComponentViews[4].titleLabel.text = bundle?.localizedString(forKey: "말씀 드리는 대로 해 보십시오.\n\"오른손으로 받는다\"\n\n(지시를 끝낸 후에 종이를 건내 준다.\n지시를 반복하거나 옆에서 도와주면 안 됨", value: nil, table: nil)
////                  toolComponentViews[5].titleLabel.text = bundle?.localizedString(forKey: "본인의 현재 상태를 스스로 평가하면?", value: nil, table: nil)
////        titleLabel.text = "혈중 단백질".localized()
////        titleLabel.text = (bundle?.localizedString(forKey: infoDic[MAIN_CONTENT_INFO_KEY.QUESTION], value: nil, table: nil))
//        
//        
//        
////        titleLabel.text = infoDic[MAIN_CONTENT_INFO_KEY.QUESTION] as? String
//
//        
//        
//        
////        titleLabel.text = (bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil))!
////        titleLabel.text = (bundle?.localizedString(forKey: "첫번째 cycle에서 항암제 용량감량", value: nil, table: nil))!
////        _ = (bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil))!
////            myLabel.text = bundle?.localizedString(forKey: "Hello", value: nil, table: nil)
////            buttonKorean.setTitle(bundle?.localizedString(forKey: "buttonKorean", value: nil, table: nil), for: .normal)
//        }
//    
    @objc func buttonPressed(button : ToolSelectButton) {
        
        for i in 0..<self.selectButtons.count {
            let targetButton = self.selectButtons[i]
            targetButton.isSelected = targetButton == button
            if targetButton == button {
                self.selectedIndex = i
            }
        }
    }
    
    func reset(){
        for i in 0..<self.selectButtons.count {
            let targetButton = self.selectButtons[i]
            targetButton.isSelected = false
        }
        self.selectedIndex = -1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class ToolSelectButton: UIButton {}
class ToolSelectButtonTypeA: ToolSelectButton {
    
    override var isSelected: Bool {
        willSet(newIsSelected) {
            if newIsSelected {
                setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
                backgroundColor = #colorLiteral(red: 0.2591966987, green: 0.3456728458, blue: 0.5022798777, alpha: 1)
            }else{
                setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
                backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
}

class ToolSelectButtonTypeB: ToolSelectButton {
    
    
    static let height : CGFloat = 50
    
    override var isSelected: Bool {
        willSet(newIsSelected) {
            if newIsSelected {
                checkImageView.image = UIImage(named: "btn_check_on")
                valueLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                backgroundColor = #colorLiteral(red: 0.2591966987, green: 0.3456728458, blue: 0.5022798777, alpha: 1)
            }else{
                checkImageView.image = UIImage(named: "btn_check_out")
                valueLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
    }
    
    var checkImageView : UIImageView!
    var valueLabel : UILabel!
    
    init(value : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: (SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO) - 40, height: 50))
        
        let checkImageBackView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height))
        checkImageBackView.isUserInteractionEnabled = false
        self.addSubview(checkImageBackView)
        
        checkImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: checkImageBackView.frame.size.height, height: checkImageBackView.frame.size.height))
        checkImageView.frame.size.width *= 0.4
        checkImageView.frame.size.height *= 0.4
        checkImageView.image = UIImage(named: "btn_check_out")
        checkImageView.center = checkImageBackView.frame.center
        checkImageView.isUserInteractionEnabled = false
        checkImageBackView.addSubview(checkImageView)
        
        valueLabel = UILabel(frame: CGRect(x: checkImageBackView.frame.maxX, y: 0, width: self.frame.size.width - checkImageBackView.frame.maxX - 10, height: self.frame.size.height))
        valueLabel.numberOfLines = 0
        valueLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        valueLabel.font = UIFont(name: NanumSquareR, size: valueLabel.frame.size.height * 0.35)
        valueLabel.text = value
        valueLabel.isUserInteractionEnabled = false
        self.addSubview(valueLabel)
        
        self.isSelected = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class ToolTitleView: UIView {
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
        indexLabel.text = "Tool \(index + 1)"
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
        
        innerView.frame.size.height = titleLabel.frame.maxY
        self.frame.size.height = innerView.frame.size.height + 20
        innerView.center.y = self.frame.size.height / 2
        
        self.setCornerRadius(cornerRadius: 5, byRoundingCorners: [.topLeft,.topRight])
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
