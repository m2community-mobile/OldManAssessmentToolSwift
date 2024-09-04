//
//  CustomAlertViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by m2comm on 2024/09/03.
//  Copyright © 2024 JinGu's iMac. All rights reserved.
//

import Foundation
import UIKit
// Custom Alert의 버튼의 액션을 처리하는 Delegate입니다.
protocol CustomAlertDelegate {
    func action()   // confirm button event
    func exit()     // cancel button event
}



enum AlertType {
    case onlyConfirm    // 확인 버튼
    case canCancel      // 확인 + 취소 버튼
}


extension CustomAlertDelegate where Self: UIViewController {
    func show(
        alertType: AlertType,
        alertText: String,
        confirmButtonText: String,
        cancelButtonText: String? = ""
        
    ) {
        
        let customAlertStoryboard = UIStoryboard(name: "CustomAlertViewController", bundle: nil)
        let customAlertViewController = customAlertStoryboard.instantiateViewController(withIdentifier: "CustomAlertViewController") as! CustomAlertViewController
        
        customAlertViewController.delegate = self
        
        customAlertViewController.modalPresentationStyle = .overFullScreen
        customAlertViewController.modalTransitionStyle = .crossDissolve
        customAlertViewController.alertText = alertText
        customAlertViewController.alertType = alertType
        
        customAlertViewController.cancelButtonText = cancelButtonText ?? ""
        customAlertViewController.confirmButtonText = confirmButtonText
        
        self.present(customAlertViewController, animated: true, completion: nil)
    }
}

class CustomAlertViewController: UIViewController {
    
    
    var delegate: CustomAlertDelegate?
    var alertType: AlertType = .onlyConfirm // Default value
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var confirmButton: UIButton!
    
    var alertText = ""
    
    var cancelButtonText = ""
    var confirmButtonText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // customAlertView 기본 세팅
        setCustomAlertView()
        
        switch alertType {
        
        // alertType에 따른 디자인 처리
        case .onlyConfirm:
            cancelButton.isHidden = true
            
            confirmButton.isHidden = false
            confirmButton.setTitle(confirmButtonText, for: .normal)
            confirmButton.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 1).isActive = true
        
        case .canCancel:
            cancelButton.isHidden = false
            cancelButton.setTitle(cancelButtonText, for: .normal)
            
            confirmButton.isHidden = false
            confirmButton.setTitle(confirmButtonText, for: .normal)
            confirmButton.layer.maskedCorners = CACornerMask.layerMaxXMaxYCorner
            confirmButton.widthAnchor.constraint(equalTo: alertView.widthAnchor, multiplier: 0.5).isActive = true
        }
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
                   self.delegate?.action()
               }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.dismiss(animated: true) {
                   self.delegate?.exit()
               }
    }
    
    private func setCustomAlertView() {
        
        /// customAlertView 둥글기 적용
        alertView.layer.cornerRadius = 20
        
        /// alert 내용 폰트 설정
        textLabel.numberOfLines = 0
//        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.text = alertText
        textLabel.textColor = .black
        textLabel.font = UIFont.systemFont(ofSize: 20)
        textLabel.font = UIFont(name: "NanumSquareR", size: 20)
        
        /// 취소 버튼 둥글기 적용 및 폰트 설정
        cancelButton.backgroundColor = #colorLiteral(red: 0.2048232257, green: 0.7089874148, blue: 0.9985322356, alpha: 1)
        cancelButton.layer.cornerRadius = 20
        cancelButton.layer.maskedCorners = CACornerMask.layerMinXMaxYCorner
        cancelButton.titleLabel?.textColor = .white
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.titleLabel?.font = UIFont(name: "NanumSquareR", size: 16)
        
        /// 확인 버튼 둥글기 적용 및 폰트 설정
        confirmButton.backgroundColor = #colorLiteral(red: 0.5301773548, green: 0.5724127293, blue: 0.625515759, alpha: 1)
        confirmButton.layer.cornerRadius = 20
        confirmButton.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMaxYCorner, .layerMaxXMaxYCorner)
        confirmButton.titleLabel?.textColor = .white
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        confirmButton.titleLabel?.font = UIFont(name: "NanumSquareR", size: 16)
    }
}

