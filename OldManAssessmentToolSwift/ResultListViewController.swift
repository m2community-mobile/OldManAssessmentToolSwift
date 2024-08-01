
//
//  ResultViewController.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 25/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

func readIntValueOfDic(dataDic : [String:Any], key : String) -> Int?{
    var intValue : Int? = nil
    if let valueInt = dataDic[key] as? Int {
        intValue = valueInt
    }
    if let valueString = dataDic[key] as? String {
        if let valueInt = Int(valueString, radix: 10) {
            intValue = valueInt
        }
    }
    return intValue
}

class ResultListViewController: BaseViewController {
    
    var naviLabel: UILabel!
    var tableView : UITableView!
    
    var dataArray = [[String:Any]]()
    var heightInfo = [IndexPath:CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.titleLabel.text = "결과보기"
        
        naviLabel = UILabel(frame: CGRect(x: 50, y: 20, width: 20, height: 20))
        naviLabel.text = UserDefaults.standard.string(forKey: "la")
        naviLabel.textColor = .white
        naviBar.addSubview(naviLabel)
        naviLabel.isHidden = true
        
        if naviLabel.text == "ko" {
            self.titleLabel.text = "결과보기"
            
        }
        if naviLabel.text == "en" {
            self.titleLabel.text = "Result"
        }
        
        tableView = UITableView(frame: CGRect(x: 0, y: naviBar.frame.maxY, width: SCREEN.WIDTH, height: SCREEN.HEIGHT - naviBar.frame.maxY))
        tableView.center.x = SCREEN.WIDTH / 2
        tableView.register(ResultListTableViewCell.self, forCellReuseIdentifier: "ResultListTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.bounces = false
        self.view.addSubview(tableView)
        
        //        self.dataArray = readToolData()
        
        self.dataUpdate()
    }
    
    
    func dataUpdate(){
        
        self.dataArray = readToolData()
        let urlString = "https://app.m2comm.co.kr/SNUH/get_result_list.php"
        
        let para = [
            "user_sid":user_sid,
            "device":"IOS",
            "deviceid":deviceID,
        ]
        print("urlString:\(urlString)")
        print("para:\(para)")
        let request = Server.postData(urlString: urlString, otherInfo: para, completion: { (kData : Data?) in
            if let data = kData{
                if let dataString = data.toString() {
                    print(" : \(dataString)")
                }
                if let kDataArray = data.toJson() as? [[String:Any]] {
                    self.dataArray = kDataArray
                    
                    self.dataArray = kDataArray.map { (dataDic : [String : Any]) -> [String:Any] in
                        var kdataDic = dataDic
                        
                        let score = readIntValueOfDic(dataDic: kdataDic, key: "sum") ?? 0
                        
                        
                        
                        
                        if let typeString = dataDic["type"] as? String {
                            if let typeInt = Int(typeString, radix: 10) {
                                if typeInt == 1 {
                                    
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
                                    kdataDic["risk"] = risk
                                    
                                    
                                    if let value = dataDic["val1"] as? String {
                                        kdataDic["btn1"] = value == "0" ? "1":"2"
                                    }
                                    if let value = dataDic["val2"] as? String {
                                        kdataDic["btn2"] = value == "0" ? "1":"2"
                                    }
                                    if let value = dataDic["val3"] as? String {
                                        kdataDic["btn3"] = value == "1" ? "1":"2"
                                    }
                                    if let value = dataDic["val4"] as? String {
                                        kdataDic["btn4"] = value == "0" ? "1":"2"
                                    }
                                    if let value = dataDic["val5"] as? String {
                                        kdataDic["btn5"] = value == "0" ? "1":"2"
                                    }
                                    if let value = dataDic["val6"] as? String {
                                        kdataDic["btn6"] = value == "0" ? "1":"2"
                                    }
                                }
                                if typeInt == 2 {
                                    
                                    var risk = "\(score)점 "
                                    if score <= 5 {
                                        risk = "\(risk) Score ≤ 5 recommends full geriatric assessment."
                                    }else{
                                        risk = "\(risk) Score ≥ 6 is normal."
                                    }
                                    kdataDic["risk"] = risk
                                    
                                    
                                    if let value = dataDic["val1"] as? String {
                                        kdataDic["btn1"] = value == "1" ? "1":"2"
                                    }
                                    if let value = dataDic["val2"] as? String {
                                        kdataDic["btn2"] = value == "1" ? "1":"2"
                                    }
                                    if let value = dataDic["val3"] as? String {
                                        kdataDic["btn3"] = value == "1" ? "1":"2"
                                    }
                                    if let value = dataDic["val4"] as? String {
                                        kdataDic["btn4"] = value == "1" ? "1":"2"
                                    }
                                    if let value = dataDic["val5"] as? String {
                                        kdataDic["btn5"] = value == "1" ? "1":"2"
                                    }
                                    if let value = dataDic["val6"] as? String {
                                        kdataDic["btn6"] = value == "1" ? "1":"2"
                                    }
                                    if let value = dataDic["val7"] as? String {
                                        kdataDic["btn7"] = value == "1" ? "1":"2"
                                    }
                                }
                                if typeInt == 3 {
                                    
                                    var GPIScore : CGFloat = 0
                                    
                                    if let value = dataDic["val1"] as? String {
                                        if value == "0" { kdataDic["btn1"] = "1" }
                                        if value == "0.5" {
                                            kdataDic["btn1"] = "2"
                                            GPIScore += 0.5
                                        }
                                        if value == "1" {
                                            kdataDic["btn1"] = "3"
                                            GPIScore += 1
                                        }
                                    }
                                    if let value = dataDic["val2"] as? String {
                                        if value == "0" { kdataDic["btn2"] = "1" }
                                        if value == "1" {
                                            kdataDic["btn2"] = "2"
                                            GPIScore += 1
                                        }
                                    }
                                    if let value = dataDic["val3"] as? String {
                                        if value == "0" { kdataDic["btn3"] = "1" }
                                        if value == "0.5" {
                                            kdataDic["btn3"] = "2"
                                            GPIScore += 0.5
                                        }
                                        if value == "1" {
                                            kdataDic["btn3"] = "3"
                                            GPIScore += 1
                                        }
                                    }
                                    if let value = dataDic["val4"] as? String {
                                        if value == "0" { kdataDic["btn4"] = "1" }
                                        if value == "0.5" {
                                            kdataDic["btn4"] = "2"
                                            GPIScore += 0.5
                                        }
                                        if value == "1" {
                                            kdataDic["btn4"] = "3"
                                            GPIScore += 1
                                        }
                                    }
                                    if let value = dataDic["val5"] as? String {
                                        if value == "0" { kdataDic["btn5"] = "1" }
                                        if value == "1" {
                                            kdataDic["btn5"] = "2"
                                            GPIScore += 1
                                        }
                                    }
                                    if let value = dataDic["val6"] as? String {
                                        if value == "0" { kdataDic["btn6"] = "1" }
                                        if value == "0.5" {
                                            kdataDic["btn6"] = "2"
                                            GPIScore += 0.5
                                        }
                                        if value == "1" {
                                            kdataDic["btn6"] = "3"
                                            GPIScore += 1
                                        }
                                    }
                                    if let value = dataDic["val7"] as? String {
                                        if value == "0" { kdataDic["btn7"] = "1" }
                                        if value == "0.5" {
                                            kdataDic["btn7"] = "2"
                                            GPIScore += 0.5
                                        }
                                        if value == "1" {
                                            kdataDic["btn7"] = "3"
                                            GPIScore += 1
                                        }
                                    }
                                    if let value = dataDic["val8"] as? String {
                                        if value == "0" { kdataDic["btn8"] = "1" }
                                        if value == "0.5" {
                                            kdataDic["btn8"] = "2"
                                            GPIScore += 0.5
                                        }
                                        if value == "1" {
                                            kdataDic["btn8"] = "3"
                                            GPIScore += 1
                                        }
                                    }
                                    
                                    var threePredictedMortalityRate : CGFloat = 0
                                    var fivePredictedMortalityRate : CGFloat = 0
                                    
                                    var three95CI = ""
                                    var five95CI = ""
                                    
                                    var flag = "0"
                                    
                                    
                                    if (GPIScore == 0) {
                                        threePredictedMortalityRate = 0.7
                                        three95CI = "0.0 - 12.6"
                                        fivePredictedMortalityRate = 14.7
                                        five95CI = "0.0 - 14.7"
                                        flag = "1"
                                        
                                    }else if (GPIScore == 0.5) {
                                        threePredictedMortalityRate = 1.1
                                        three95CI = "0.0 - 15.2"
                                        fivePredictedMortalityRate = 15.9
                                        five95CI = "0.0 - 15.9"
                                        flag = "2"
                                        
                                    }else if (GPIScore == 1) {
                                        threePredictedMortalityRate = 1.5
                                        three95CI = "0.0 - 7.7"
                                        fivePredictedMortalityRate = 10.1
                                        five95CI = "0.4 - 10.1"
                                        flag = "3"
                                        
                                    }else if (GPIScore == 1.5) {
                                        threePredictedMortalityRate = 2.2
                                        three95CI = "0.2 - 8.6"
                                        fivePredictedMortalityRate = 12.1
                                        five95CI = "0.9 - 12.1"
                                        flag = "4"
                                        
                                    }else if (GPIScore == 2) {
                                        threePredictedMortalityRate = 3.1
                                        three95CI = "0.7 - 8.1"
                                        fivePredictedMortalityRate = 12.7
                                        five95CI = "2.6 - 12.7"
                                        flag = "5"
                                        
                                    }else if (GPIScore == 2.5) {
                                        threePredictedMortalityRate = 4.4
                                        three95CI = "1.4 - 9.8"
                                        fivePredictedMortalityRate = 15.9
                                        five95CI = "4.7 - 15.9"
                                        flag = "6"
                                        
                                    }else if (GPIScore == 3) {
                                        threePredictedMortalityRate = 6.1
                                        three95CI = "2.5 - 12.2"
                                        fivePredictedMortalityRate = 20.6
                                        five95CI = "7.5 - 20.6"
                                        flag = "7"
                                        
                                    }else if (GPIScore == 3.5) {
                                        threePredictedMortalityRate = 8.6
                                        three95CI = "4.1 - 15.4"
                                        fivePredictedMortalityRate = 26.5
                                        five95CI = "11.7 - 26.5"
                                        flag = "8"
                                        
                                    }else if (GPIScore == 4) {
                                        threePredictedMortalityRate = 11.9
                                        three95CI = "6.0 - 20.5"
                                        fivePredictedMortalityRate = 35.1
                                        five95CI = "16.3 - 35.1"
                                        flag = "9"
                                        
                                    }else if (GPIScore == 4.5) {
                                        threePredictedMortalityRate = 16.3
                                        three95CI = "9.2 - 25.7"
                                        fivePredictedMortalityRate = 43.7
                                        five95CI = "23.1 - 43.7"
                                        flag = "10"
                                        
                                    }else if (GPIScore == 5) {
                                        threePredictedMortalityRate = 21.8
                                        three95CI = "11.0 - 36.5"
                                        fivePredictedMortalityRate = 57.5
                                        five95CI = "27.5 - 57.5"
                                        flag = "11"
                                        
                                    }else if (GPIScore == 5.5) {
                                        threePredictedMortalityRate = 28.6
                                        three95CI = "15.3 - 45.4"
                                        fivePredictedMortalityRate = 68.1
                                        five95CI = "35.1 - 68.1"
                                        flag = "12"
                                        
                                    }else if (GPIScore == 6) {
                                        threePredictedMortalityRate = 36.6
                                        three95CI = "19.5 - 56.6"
                                        fivePredictedMortalityRate = 78.8
                                        five95CI = "41.4 - 78.8"
                                        flag = "13"
                                        
                                    }else if (GPIScore == 6.5) {
                                        threePredictedMortalityRate = 43.1
                                        three95CI = "8.0 - 85.7"
                                        fivePredictedMortalityRate = 97.7
                                        five95CI = "23.8 - 97.7"
                                        flag = "14"
                                        
                                    }else {
                                        threePredictedMortalityRate = 54.4
                                        three95CI = "7.6 - 96.2"
                                        fivePredictedMortalityRate = 100
                                        five95CI = "19.9 - 100.0"
                                        flag = "15"
                                        
                                    }
                                    
                                    kdataDic["flag"] = flag
                                    kdataDic["three95CI"] = three95CI
                                    kdataDic["five95CI"] = five95CI
                                    kdataDic["threeYears"] = "\(threePredictedMortalityRate)"
                                    kdataDic["fiveYears"] = "\(fivePredictedMortalityRate)"
                                    
                                    kdataDic["risk"] = "GPI \(score) / 3years : \(threePredictedMortalityRate) / 5years : \(fivePredictedMortalityRate) "
                                }
                            }
                        }
                        
                        
                        
                        return kdataDic
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    return
                }
            }
            self.dataArray = [[String:Any]]()
            DispatchQueue.main.async {
                appDel.showAlert(title: "Notice", message: "네트워크가 불안정합니다.")
                self.tableView.reloadData()
            }
            
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}




extension ResultListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        return 10
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightInfo[indexPath] ?? ResultListTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heightInfo[indexPath] ?? ResultListTableViewCell.height
        //        return ResultListTableViewCell.height
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultListTableViewCell", for: indexPath) as! ResultListTableViewCell
        
        //        let newIndex = self.dataArray.count - indexPath.row - 1
        
        let height = cell.valueUpdate(dataDic: self.dataArray[indexPath.row])
        self.heightInfo[indexPath] = height
        
        
        if naviLabel.text == "ko" {
            cell.label1.text = "환자번호:\(UserDefaults.standard.object(forKey: "pa") ?? "") / Tool\(UserDefaults.standard.object(forKey: "ty") ?? "")"
        }
        if naviLabel.text == "en" {
            cell.label1.text = "Patient No.:\(UserDefaults.standard.object(forKey: "pa") ?? "") / Tool\(UserDefaults.standard.object(forKey: "ty") ?? "")"
        }
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let dataDic = self.dataArray[indexPath.row]
        print("\(#function) dataDic : \(dataDic)")
        if let typeString = dataDic["type"] as? String {
            if let typeInt = Int(typeString, radix: 10) {
                if typeInt == 1 {
                    let nextVC = ResultShowViewController1()
                    nextVC.index = 0
                    nextVC.infoDic = MAIN_CONTENT_INFOS[0]
                    nextVC.dataDic = dataDic
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }else if typeInt == 2 {
                    let nextVC = ResultShowViewController2()
                    nextVC.index = 1
                    nextVC.infoDic = MAIN_CONTENT_INFOS[1]
                    nextVC.dataDic = dataDic
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }else if typeInt == 3 {
                    let nextVC = ResultShowViewController3()
                    nextVC.index = 2
                    nextVC.infoDic = MAIN_CONTENT_INFOS[2]
                    nextVC.dataDic = dataDic
                    self.navigationController?.pushViewController(nextVC, animated: true)
                }
            }
        }
        
        
    }
    
}

class ResultListTableViewCell: UITableViewCell {
    static let height : CGFloat = 55
    
    var label1 : UILabel!
    var label2 : UILabel!
    var label3 : UILabel!
    
//    var navi: UILabel!
    
    
    var arrowImageView : UIImageView!
    
    var separaterView1 : UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        navi = UILabel(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//        navi.text = UserDefaults.standard.string(forKey: "la")
//        self.addSubview(navi)
        
       
        
        
        
        label1 = UILabel(frame: CGRect(x: 10, y: 0, width: SCREEN.WIDTH, height: 150))
        label1.textColor = #colorLiteral(red: 0.3857345581, green: 0.4093826413, blue: 0.5080980659, alpha: 1)
        label1.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 13)
        self.addSubview(label1)
        
        label2 = UILabel(frame: CGRect(x: 10, y: 0, width: SCREEN.WIDTH, height: 150))
        label2.textColor = #colorLiteral(red: 0.2244906723, green: 0.2391071022, blue: 0.2947487235, alpha: 1)
        label2.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 17)
        label2.numberOfLines = 0
        self.addSubview(label2)
        
        label3 = UILabel(frame: CGRect(x: 10, y: 0, width: SCREEN.WIDTH, height: 150))
        label3.textColor = #colorLiteral(red: 0.3857345581, green: 0.4093826413, blue: 0.5080980659, alpha: 1)
        label3.font = UIFont(name: Nanum_Barun_Gothic_OTF, size: 13)
        self.addSubview(label3)
        
        arrowImageView = UIImageView(frame: CGRect(x: SCREEN.WIDTH - 40, y: 0, width: 40, height: 40))
        arrowImageView.setImageWithFrameHeight(image: UIImage(named: "btn_d_next2")?.withRenderingMode(.alwaysTemplate))
        arrowImageView.tintColor = #colorLiteral(red: 0.2244906723, green: 0.2391071022, blue: 0.2947487235, alpha: 1)
        arrowImageView.center.y = self.frame.size.height / 2
        self.addSubview(arrowImageView)
        
        separaterView1 = UIView(frame: CGRect(x: 0, y: self.frame.size.height - 0.5, width: SCREEN.WIDTH, height: 0.5))
        separaterView1.center.x = SCREEN.WIDTH / 2
        separaterView1.backgroundColor = #colorLiteral(red: 0.2244906723, green: 0.2391071022, blue: 0.2947487235, alpha: 1).withAlphaComponent(0.5)
        self.addSubview(separaterView1)
    }
    
    
    
    
    func valueUpdate(dataDic : [String:Any]) -> CGFloat {
        
        dataDic.showValue()
        
        let patient = dataDic["patient"] as? String ?? ""
        let type = dataDic["type"] as? String ?? ""
        let risk = dataDic["risk"] as? String ?? ""
        
        
        UserDefaults.standard.setValue(patient, forKey: "pa")
        UserDefaults.standard.setValue(type, forKey: "ty")
        
        //        let signdateString = dataDic["signdate"] as? String ?? ""
        //        var date = Date()
        //        if let signDateInt = signdateString.toInt() {
        //            let timeInterval = TimeInterval(signDateInt)
        //            date = Date(timeIntervalSince1970: timeInterval)
        //        }
        //        let dateString = DateCenter.shared.dateToStringWithFormat(formatString: "YYYY.MM.dd", date: date)
        
        
//        //설정된 언어 코드 가져오기
//        let language = UserDefaults.standard.array(forKey: "AppleLanguages")?.first as! String // 초기에 "ko-KR" , "en-KR" 등으로 저장되어있음
//        let index = language.index(language.startIndex, offsetBy: 2)
//        let languageCode = String(language[..<index]) //"ko" , "en" 등
//        
//        //설정된 언어 파일 가져오기
//        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
//        let bundle = Bundle(path: path!)
//    
//   
//        if navi.text == "ko" {
//            label1.text = "환자번호:\(patient) / Tool\(type)"
//            
//            label1.text = "123"
//        }
//        if navi.text == "en" {
////            label1.text = "Patient No.:\(patient) / Tool\(type)"
//            label1.text = "234"
//        }
    
    
   
    
    
    
        
        
        
        
        
        
        label1.frame.size.height = 150
        label2.frame.size.height = 150
        label3.frame.size.height = 150
        
        label1.frame.size.width = arrowImageView.frame.minX - 20
        label2.frame.size.width = arrowImageView.frame.minX - 20
        label3.frame.size.width = arrowImageView.frame.minX - 20
        
        
        
        
        label1.text = "환자번호:\(patient) / Tool\(type)"
        
        
        
        
//        label1.text = bundle?.localizedString(forKey: "환자번호:\(patient) / Tool\(type)" , value: nil, table: nil)
        
        
        
        
        
        label2.text = risk
        label3.text = dataDic["time"] as? String ?? ""
        //            dateString
        
        label1.sizeToFit()
        label2.sizeToFit()
        label3.sizeToFit()
        
        label1.frame.size.width = arrowImageView.frame.minX - 20
        label2.frame.size.width = arrowImageView.frame.minX - 20
        label3.frame.size.width = arrowImageView.frame.minX - 20
        
        label1.frame.origin.y = 10
        label2.frame.origin.y = label1.frame.maxY + 7
        label3.frame.origin.y = label2.frame.maxY + 7
        
        self.frame.size.height = label3.frame.maxY + 10
        
        arrowImageView.center.y = self.frame.size.height / 2
        
        separaterView1.center.y = self.frame.size.height - 0.5
        
        return self.frame.size.height
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

