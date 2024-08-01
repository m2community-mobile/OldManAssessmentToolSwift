//
//  ResultFunction.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 29/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

func requestGubunList(complete:@escaping (_ :[[String:Any]])->Void  ) {
    let urlString = "https://app.m2comm.co.kr/SNUH/gubun.php"
    let para = ["sid":user_sid]
    print("requestGubunList urlString:\(urlString)")
    print("para:\(para)")
    Server.postData(urlString: urlString, otherInfo: para, completion: { (kData : Data?) in
        if let data = kData{
            if let dataString = data.toString() {
                print("requestGubunList : \(dataString)")
            }
            if let dataArray = data.toJson() as? [[String:Any]] {
                complete(dataArray)
            }
        }
    })
}



class ClinicalResearchInputView : UIView {
    
    var dataArray = [[String:Any]]()
    
    var valueLabel : UILabel!
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 0))
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 40))
        titleLabel.center.x = SCREEN.WIDTH / 2
        titleLabel.text = "᛫ 임상연구를 선택하세요."
        titleLabel.textColor = #colorLiteral(red: 0.2666666667, green: 0.3450980392, blue: 0.5019607843, alpha: 1)
        titleLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 15)
        self.addSubview(titleLabel)
        
        let backView = UIView(frame: CGRect(x: 0, y: titleLabel.frame.maxY + 5, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 50))
        backView.center.x = SCREEN.WIDTH / 2
        backView.layer.cornerRadius = 5
        backView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        backView.layer.borderWidth = 0.5
        self.addSubview(backView)
        
        let arrowLabel = UILabel(frame: CGRect(x: backView.frame.size.width - backView.frame.size.height, y: 0, width: backView.frame.size.height, height: backView.frame.size.height))
        arrowLabel.textAlignment = .center
        arrowLabel.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        arrowLabel.text = "▼"
        backView.addSubview(arrowLabel)
        
        let valueLabelBackView = UIView(frame: backView.bounds)
        valueLabelBackView.frame.size.width = arrowLabel.frame.minX
        backView.addSubview(valueLabelBackView)
        
        valueLabel = UILabel(frame: valueLabelBackView.bounds)
        valueLabel.frame.size.width *= 0.9
        valueLabel.center = valueLabelBackView.frame.center
        valueLabel.font = UIFont(name: NanumSquareR, size: valueLabel.frame.size.height * 0.35)
        valueLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        valueLabel.text = "선택해 주세요."
        valueLabelBackView.addSubview(valueLabel)
        
        let becomeButton = UIButton(frame: backView.bounds)
        becomeButton.addTarget(self, action: #selector(becomeButtonPressed), for: UIControl.Event.touchUpInside)
        backView.addSubview(becomeButton)
        
        
        self.frame.size.height = backView.frame.maxY + 10
    }
    
    var selectedDic = [String:Any]()
    @objc func becomeButtonPressed(){
        print("becomeButton")
        if self.dataPickerView == nil {
            self.dataPickerView = DataPickerView(dataArray: self.dataArray)
        }
        appDel.window?.addSubview(self.dataPickerView!)
        self.dataPickerView!.show(afterConfirm: { (selectedIndex : Int) in
            let dataDic = self.dataArray[selectedIndex]
            self.valueLabel.text = dataDic["name"] as? String ?? ""
            self.selectedDic = dataDic
            print("selectedDic update : \(dataDic)")
            self.dataPickerView?.removeFromSuperview()
            self.dataPickerView = nil
        })
    }
    
    var dataPickerView : DataPickerView?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PatientInputView: UIView {
    
    var title = ""
    var titleLabel : UILabel!
    var textFieldView : TextFieldView!
    var resetButton : PatientInputButton!
    var saveButton : PatientInputButton!
    
    init(title kTitle : String) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: 0))
        
        self.title = kTitle
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 40))
        titleLabel.center.x = SCREEN.WIDTH / 2
        titleLabel.text = "᛫ \(title)"
        titleLabel.textColor = #colorLiteral(red: 0.2666666667, green: 0.3450980392, blue: 0.5019607843, alpha: 1)
        titleLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 15)
        self.addSubview(titleLabel)
        
        textFieldView = TextFieldView(frame: CGRect(x: 0, y: titleLabel.frame.maxY + 5, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 50))
        textFieldView.center.x = SCREEN.WIDTH / 2
        textFieldView.textField.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textFieldView.textField.font = UIFont(name: NanumSquareR, size: textFieldView.frame.size.height * 0.35)
        textFieldView.layer.cornerRadius = 5
        textFieldView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        textFieldView.layer.borderWidth = 0.5
        self.addSubview(textFieldView)
        
        let buttonBackView = UIView(frame: CGRect(x: 0, y: textFieldView.frame.maxY + 15, width: SCREEN.WIDTH * TOOL_VIEW_CONTENT_WIDTH_RATIO, height: 50))
        buttonBackView.center.x = SCREEN.WIDTH / 2
        self.addSubview(buttonBackView)
        
        let buttonGap : CGFloat = 10
        let buttonWidth = (buttonBackView.frame.size.width - buttonGap) / 2
        
        //replay
        resetButton = PatientInputButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonBackView.frame.size.height), name: "다시하기", imageName: "replay")
        resetButton.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.568627451, blue: 0.6235294118, alpha: 1)
        buttonBackView.addSubview(resetButton)
        
        saveButton = PatientInputButton(frame: CGRect(x: resetButton.frame.maxX + buttonGap, y: 0, width: buttonWidth, height: buttonBackView.frame.size.height), name: "저장하기", imageName: "save")
        saveButton.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.2, blue: 0.5254901961, alpha: 1)
        buttonBackView.addSubview(saveButton)
        
        self.frame.size.height = buttonBackView.frame.maxY + 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    class PatientInputButton: UIButton {
        var iconImageView : UIImageView!
        var nameLabel : UILabel!
        
        init(frame: CGRect, name : String, imageName : String) {
            super.init(frame: frame)
            
            self.layer.cornerRadius = 5
            
            let innerView = UIView(frame: self.bounds)
            innerView.isUserInteractionEnabled = false
            self.addSubview(innerView)
            
            iconImageView  = UIImageView(frame: CGRect(x: 0, y: 0, width: 0, height: self.frame.size.height * 0.4))
            iconImageView.setImageWithFrameWidth(image: UIImage(named: imageName))
            iconImageView.center.y = self.frame.size.height / 2
            iconImageView.isUserInteractionEnabled = false
            innerView.addSubview(iconImageView)
            
            nameLabel = UILabel(frame: CGRect(x: iconImageView.frame.maxX + 10, y: 0, width: 100, height: self.frame.size.height))
            nameLabel.numberOfLines = 0
            nameLabel.textAlignment = .center
            nameLabel.text = name
            nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 20)
            nameLabel.sizeToFit()
            nameLabel.center.y = self.frame.size.height / 2
            nameLabel.isUserInteractionEnabled = false
            innerView.addSubview(nameLabel)
            
            innerView.frame.size.width = nameLabel.frame.maxX
            innerView.center.x = self.frame.size.width / 2
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}
