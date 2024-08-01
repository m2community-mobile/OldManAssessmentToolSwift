//
//  DataPickerView.swift
//  KOSNI 2018
//
//  Created by m2comm on 2018. 9. 12..
//  Copyright © 2018년 m2community. All rights reserved.
//

import UIKit

class DataPickerView: UIView {

    var cancelButton : UIButton?
    var pickerBackView : UIView?
    var dataPicker : UIPickerView?
    var afterFunc : ((_ number : Int) -> Void)?
    
    let pickerHeight : CGFloat = 150
    
    var dataArray = [[String:Any]]()
    
    init(dataArray kDataArray : [[String:Any]]) {
        super.init(frame: UIScreen.main.bounds)
        
        self.dataArray = kDataArray
        
        self.backgroundColor = UIColor.clear
        
        self.cancelButton = UIButton(frame: self.frame)
        self.cancelButton?.backgroundColor = UIColor.clear
        self.cancelButton?.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
        self.addSubview(self.cancelButton!)
        
        self.pickerBackView = UIView(frame: CGRect(
            x: 0,
            y: UIScreen.main.bounds.size.height,
            width: UIScreen.main.bounds.size.width,
            height: pickerHeight + 50 + SAFE_AREA))
        self.pickerBackView?.backgroundColor = UIColor.white
        self.addSubview(self.pickerBackView!)
        
        let barHeight : CGFloat = 50
        
        self.dataPicker = UIPickerView(frame: CGRect(x: 0, y: barHeight, width: UIScreen.main.bounds.size.width, height: pickerHeight))
        self.dataPicker?.delegate = self
        self.dataPicker?.dataSource = self
        
        self.pickerBackView?.addSubview(self.dataPicker!)
        
        let separatorView = UIView(frame: CGRect(x: 0, y: barHeight - 1, width: self.frame.size.width, height: 1))
        separatorView.backgroundColor = UIColor(white: 225.0/255.0, alpha: 1)
        self.pickerBackView?.addSubview(separatorView)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN.WIDTH, height: barHeight))
        titleLabel.text = "선택해주세요."
        titleLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        titleLabel.font = UIFont.systemFont(ofSize: barHeight * 0.35)
        titleLabel.textAlignment = .center
        self.pickerBackView?.addSubview(titleLabel)
        
        let confirmButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.size.width - barHeight, y: 0, width: barHeight, height: barHeight))
        confirmButton.setTitle("확인", for: .normal)
        confirmButton.setTitleColor(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), for: .normal)
        confirmButton.addTarget(self, action: #selector(confirmButtonPessed), for: .touchUpInside)
        self.pickerBackView?.addSubview(confirmButton)
        
        
        
        self.isHidden = true
    }
    
    @objc func confirmButtonPessed(){
        self.afterFunc?((self.dataPicker!.selectedRow(inComponent: 0)))
        self.hide {}
    }
    
    func show(afterConfirm : @escaping (_ number : Int) -> Void) {
        
        self.afterFunc = afterConfirm
        
        self.isHidden = false
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerBackView?.frame.origin.y = UIScreen.main.bounds.size.height - self.pickerBackView!.frame.size.height
            self.cancelButton?.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }) { (fi:Bool) in
            
        }
        
    }
    
    func hide( complete : @escaping () -> Void) {
        
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerBackView?.frame.origin.y = UIScreen.main.bounds.size.height
            self.cancelButton?.backgroundColor = UIColor.clear
        }) { (fi : Bool) in
            self.isHidden = true
            complete()
        }
        
    }
    
    @objc func cancelButtonPressed(){
        self.afterFunc = nil
        self.hide {
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension DataPickerView : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.dataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let dataDic = self.dataArray[row]
        return dataDic["name"] as? String ?? ""
    }
    
}
