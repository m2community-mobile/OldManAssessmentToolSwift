//
//  SelectedViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by m2comm on 2024/03/05.
//  Copyright © 2024 JinGu's iMac. All rights reserved.
//

import Foundation
import UIKit

class SelectedViewController: BaseViewController {
    
    var backBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("here?")
        
        
        self.view.backgroundColor = #colorLiteral(red: 0.1687407494, green: 0.1793107986, blue: 0.2257117033, alpha: 1)
        
        
        titleLabel.text = "Sign-up"
        
        
        backBtn = UIButton(frame: CGRect(x: 30, y: 30, width: 50, height: 50))
        backBtn.setImage(UIImage(named: "btn_d_back1"), for: .normal)
        backBtn.addTarget(self, action: #selector(back(_ :)), for: .touchUpInside)
//        self.view.addSubview(backBtn)
        
        
        var doView = UIButton()
        doView.translatesAutoresizingMaskIntoConstraints = false
        doView.backgroundColor = #colorLiteral(red: 0.2586658597, green: 0.3448346555, blue: 0.5009961724, alpha: 1)
        doView.layer.cornerRadius = 8
    
        doView.addTarget(self, action: #selector(goDo(_ :)), for: .touchUpInside)
        self.view.addSubview(doView)
        
        doView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        doView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width / 2.5).isActive = true
        doView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 3).isActive = true
        doView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        let doImg = UIImage(named: "do")
        
//        var doImgView = UIImageView(frame: CGRect(x: 125, y: 50, width: doView.frame.size.width - 100, height: 100))
        var doImgView = UIImageView()

        doImgView.translatesAutoresizingMaskIntoConstraints = false
        doImgView.image = doImg
        doView.addSubview(doImgView)
        
        doImgView.centerXAnchor.constraint(equalTo: doView.centerXAnchor).isActive = true
        doImgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        doImgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        doImgView.centerYAnchor.constraint(equalTo: doView.centerYAnchor, constant: -30).isActive = true
        
        var doLabel = UILabel()
        doLabel.translatesAutoresizingMaskIntoConstraints = false
        doLabel.text = "Domestic"
        doLabel.font = UIFont.systemFont(ofSize: 22)
        doLabel.textColor = .white
        
        doView.addSubview(doLabel)
        
        doLabel.topAnchor.constraint(equalTo: doImgView.topAnchor, constant: 10).isActive = true
//        doLabel.leadingAnchor.constraint(equalTo: doView.leftAnchor, constant: 20).isActive = true
//        doLabel.trailingAnchor.constraint(equalTo: doView.trailingAnchor, constant: -20).isActive = true
//        doLabel.bottomAnchor.constraint(equalTo: doView.bottomAnchor, constant: -10).isActive = true
        
        doLabel.centerXAnchor.constraint(equalTo: doView.centerXAnchor).isActive = true
        doLabel.centerYAnchor.constraint(equalTo: doView.centerYAnchor, constant: 50).isActive = true
            
        
    
        
        
        var inView = UIButton()
        inView.translatesAutoresizingMaskIntoConstraints = false
        inView.backgroundColor = #colorLiteral(red: 0.1980314851, green: 0.4070751965, blue: 0.7869122624, alpha: 1)
        inView.layer.cornerRadius = 8
        
        inView.addTarget(self, action: #selector(goIn(_ :)), for: .touchUpInside)
        self.view.addSubview(inView)
        
        
        inView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        inView.widthAnchor.constraint(equalToConstant: self.view.frame.size.width / 2.5).isActive = true
        inView.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 3).isActive = true
        inView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true

        
        let inImg = UIImage(named: "in")
        
//        var doImgView = UIImageView(frame: CGRect(x: 125, y: 50, width: doView.frame.size.width - 100, height: 100))
        var inImgView = UIImageView()

        inImgView.translatesAutoresizingMaskIntoConstraints = false
        inImgView.image = inImg
        inView.addSubview(inImgView)
        
        inImgView.centerXAnchor.constraint(equalTo: inView.centerXAnchor).isActive = true
        inImgView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        inImgView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        inImgView.centerYAnchor.constraint(equalTo: inView.centerYAnchor, constant: -30).isActive = true
        
        
        var inLabel = UILabel()
        inLabel.translatesAutoresizingMaskIntoConstraints = false
        inLabel.text = "International"
        inLabel.font = UIFont.systemFont(ofSize: 22)
        inLabel.textColor = .white
        
        inView.addSubview(inLabel)
        
        inLabel.topAnchor.constraint(equalTo: inView.topAnchor, constant: 10).isActive = true
//        doLabel.leadingAnchor.constraint(equalTo: doView.leftAnchor, constant: 20).isActive = true
//        doLabel.trailingAnchor.constraint(equalTo: doView.trailingAnchor, constant: -20).isActive = true
//        doLabel.bottomAnchor.constraint(equalTo: doView.bottomAnchor, constant: -10).isActive = true
        
        inLabel.centerXAnchor.constraint(equalTo: inView.centerXAnchor).isActive = true
        inLabel.centerYAnchor.constraint(equalTo: inView.centerYAnchor, constant: 50).isActive = true
        
        
        
    }
    
    @objc func back(_ sender: UIButton) {
        
        let joinVC = LoginViewController()
        self.navigationController?.pushViewController(joinVC, animated: false)
    }
    
    
    @objc func goDo(_ sender: UIButton) {
        print("joinButtonPressed")
        
      
        
        let joinVC = JoinViewController()
        self.navigationController?.pushViewController(joinVC, animated: true)
        
        UserDefaults.standard.set("ko", forKey: "la")
    }
    @objc func goIn(_ sender: UIButton) {
        
     
        
//        UserDefaults.standard.set(["ko"], forKey: "AppleLanguages")
//               UserDefaults.standard.synchronize()
//        setLa()
        
        
        print("joinButtonPressed")
        let joinVC = JoinViewController()
        self.navigationController?.pushViewController(joinVC, animated: true)
        
        UserDefaults.standard.set("en", forKey: "la")
        
    }
    
    
//    func setLa() {
//        
//        
//        let language = UserDefaults.standard.array(forKey: "AppleLanguges")?.first as! String
//        let index = language.index(language.startIndex, offsetBy: 2)
//        let languageCode = String(language[..<index])
//        
//        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
//        let bundle = Bundle(path: path!)
//        
//        MAIN_CONTENT_INFO_KEY.QUESTION = (bundle?.localizedString(forKey: "혈중 단백질", value: nil, table: nil))!
//        
//        
//    }
    
}
