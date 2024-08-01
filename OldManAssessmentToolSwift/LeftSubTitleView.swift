//
//  LeftSubTitleView.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 21/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

@objc protocol LeftSubTitleViewDelegate {
    @objc optional func leftSubTitleViewButtonPressed(index : Int)
}
class LeftSubTitleView: UIView {
    
    var delegate : LeftSubTitleViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let titles = ["즐겨찾기","행사리스트","설정"]
        
        let innerView = UIView(frame: self.bounds)
        innerView.frame.size.width *= 0.9
        self.addSubview(innerView)
        
        let buttonWidth = innerView.frame.size.width / 3
        let buttonHeight = innerView.frame.size.height
        for i in 0..<titles.count {
            let topButton = LeftSubTitleButton(frame: CGRect(x: CGFloat(i) * buttonWidth, y: 0, width: buttonWidth, height: buttonHeight), name: titles[i], imageName: "leftViewTopiCon\(i+1)")
            innerView.addSubview(topButton)
            
            topButton.setTarget(event: .touchUpInside) { (button) in
                self.delegate?.leftSubTitleViewButtonPressed?(index: i)
            }
        }
        
        innerView.center.x = self.frame.size.width / 2
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class LeftSubTitleButton: UIButton {
    
    var iconImageView : UIImageView!
    var nameLabel : UILabel!
    
    init(frame: CGRect, name : String, imageName : String) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        
        let innerView = UIView(frame: self.bounds)
        innerView.isUserInteractionEnabled = false
        self.addSubview(innerView)
        
        let iconImageBackViewRatio : CGFloat = 0.5
        let iconImageBackView = UIView(frame: self.bounds)
        iconImageBackView.frame.size.height *= iconImageBackViewRatio
        iconImageBackView.frame.size.width = iconImageBackView.frame.size.height
        iconImageBackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        iconImageBackView.layer.cornerRadius = iconImageBackView.frame.size.width * 0.5
        iconImageBackView.clipsToBounds = true
        iconImageBackView.center.x = self.frame.size.width / 2
        innerView.addSubview(iconImageBackView)
        
        iconImageView  = UIImageView(frame: iconImageBackView.bounds)
        iconImageView.frame.size.width *= 0.5
        iconImageView.frame.size.height *= 0.5
        iconImageView.backgroundColor = UIColor.random.withAlphaComponent(0.3)
        iconImageBackView.addSubview(iconImageView)
        
        if let iconImage = UIImage(named: imageName) {
            if iconImage.size.width > iconImage.size.height {
                iconImageView.setImageWithFrameHeight(image: iconImage)
            }else{
                iconImageView.setImageWithFrameWidth(image: iconImage)
            }
        }
        iconImageView.center = iconImageBackView.frame.center
        
        nameLabel = UILabel(frame: CGRect(x: 0, y: iconImageBackView.frame.maxY, width: self.frame.size.width * 2, height: 50))
        nameLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        nameLabel.textAlignment = .center
        nameLabel.font = UIFont(name: Nanum_Barun_Gothic_OTF_Bold, size: 16)
        nameLabel.numberOfLines = 0
        innerView.addSubview(nameLabel)
        
        nameLabel.frame.origin.y = iconImageBackView.frame.maxY + 5
        nameLabel.center.x = innerView.frame.size.width / 2
        nameLabel.text = name
        if !name.contains("\n") {
            nameLabel.text = "\(name)\n"
        }
        nameLabel.sizeToFit()
        nameLabel.text = name
        nameLabel.center.x = self.frame.size.width / 2
        
        innerView.frame.size.height = nameLabel.frame.maxY
        innerView.center.y = self.frame.size.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
