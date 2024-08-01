//
//  AdViewSmooth.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 21/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit
import SDWebImage

class AdViewSmooth: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
    }
    
    var adArray = [[String:Any]]()
    var adViews = [UIImageView]()
    
    func adUpdate(complete:@escaping(_ count:Int)->Void){
        
        for adImageView in adViews {
            adImageView.removeFromSuperview()
        }
        adViews = [UIImageView]()
        
        let sampleCode = "kses190818"
        let urlString = "https://ezv.kr/voting/php/banner/list.php?code=\(sampleCode)&gubun=1"
        
        print("adUpdate:\(urlString)")
        
        Server.postData(urlString: urlString) { [weak self] (kData : Data?) in
            guard let self = self else { return }
            if let data = kData {
                if let dataArray = data.toJson() as? [[String:Any]] {
                    print("bannerDataArray:\(dataArray)")
                    
                    self.adArray = dataArray
                    
                    
                    var maxX : CGFloat = 0
                    maxX = self.adViewsSetting(maxX: maxX, dataArray: dataArray)
                    
                    
                    for _ in 0..<4 {
                        if maxX <= self.frame.size.width * 2 {
                            maxX = self.adViewsSetting(maxX: maxX, dataArray: dataArray)
                        }else{
                            break
                        }
                    }
                    
                    complete(self.adArray.count)
                }
            }
        }
    }
    
    func adViewsSetting(maxX kMaxX : CGFloat, dataArray : [[String:Any]]) -> CGFloat {
        
        var maxX = kMaxX
        
        let sampleImage = UIImage(named: "sampleAD.png")
        
        for i in 0..<dataArray.count {
            let dataDic = dataArray[i]
            if var imageUrlString = dataDic["image"] as? String {
                //http://ezv.kr/voting/upload/booth/1553823717amgen.png
                imageUrlString = "https://ezv.kr\(imageUrlString)"
                print("imageUrlString:\(imageUrlString)")
                let adImageView = UIImageView(frame: CGRect(x: maxX, y: 0, width: 0, height: self.frame.size.height))
                adImageView.setImageWithFrameWidth(image: sampleImage)
                adImageView.isUserInteractionEnabled = true
                adImageView.backgroundColor = UIColor.random.withAlphaComponent(0.3)
                self.addSubview(adImageView)
                
                maxX = adImageView.frame.maxX
                adImageView.sd_setImage(with: URL(string: imageUrlString), completed: nil)
                
                if let linkurl = dataDic["linkurl"] as? String {
                    let adButton = UIButton(frame: adImageView.bounds)
                    adButton.setTarget(event: .touchUpInside, buttonAction: { (butotn) in
                        if let url = URL(string: linkurl.addPercenterEncoding()){
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: { (fi) in
                                    
                                })
                            }
                        }
                    })
                    adImageView.addSubview(adButton)
                }
                self.adViews.append(adImageView)
            }
        }
        return maxX
    }
    
    var adViewAnimationTimer : Timer?
    func adViewAnimationStart(){
        adViewAnimationTimer?.invalidate()
        
        adViewAnimationTimer = Timer.scheduledTimer(withTimeInterval: 0.001, repeats: true, block: { [weak self] (timer : Timer) in
            guard let self = self else { return }
            
            for i in 0..<self.adViews.count {
                let adView = self.adViews[i]
                
                DispatchQueue.main.async {
                    adView.frame.origin.x -= 0.05
                    
                    if (adView.frame.maxX - 1) <= 0 {
                        adView.frame.origin.x = self.adViews.reduce(0, { (max : CGFloat, adView : UIImageView) -> CGFloat in
                            return (max > adView.frame.maxX) ? max : adView.frame.maxX
                        })
                    }
                }
            }
        })
        
        RunLoop.current.add(adViewAnimationTimer!, forMode: .common)
        
    }
    
    func adViewAnimationStop(){
        adViewAnimationTimer?.invalidate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
