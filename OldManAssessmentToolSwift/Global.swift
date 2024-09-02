//
//  Global.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 21/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import Foundation


func saveToolData(dataDic : [String:Any]) {
    let key = "TOOL_DATA"
    
    var valueArray = userD.object(forKey: key) as? [[String:Any]] ?? [[String:Any]]()
    valueArray.append(dataDic)
    userD.set(valueArray, forKey: key)

}

func readToolData() -> [[String:Any]]{
    let key = "TOOL_DATA"
    
    return userD.object(forKey: key) as? [[String:Any]] ?? [[String:Any]]()
}


func saveUserD(jsonDic : [String:Any], valueKey : String, saveKey : String) {
    if let value = jsonDic[valueKey] as? String {
        userD.set(value, forKey: saveKey)
        userD.synchronize()
        print("saveUserD \(valueKey) value is \(value)")
    }else{
        print("saveUserD \(valueKey) value is nil")
    }
}



struct MAIN_CONTENT_INFO_KEY {
    static let BACKGROUND_COLOR = "BACKGROUND_COLOR"
    static let TITLE = "TITLE"

    static let QUESTIONS = "QUESTIONS"
    static var QUESTION = "QUESTION"
    
    static let ANSWERS = "ANSWERS"
    static let ANSWER = "ANSWER"
    
    static let IS_ANSWER_TYPE_B = "IS_ANSWER_TYPE_B"
    
}

let MAIN_CONTENT_INFOS = [
    [
        MAIN_CONTENT_INFO_KEY.TITLE:"Prediction tool for occurrence of adverse envets≥G3 (servere)",
        MAIN_CONTENT_INFO_KEY.BACKGROUND_COLOR:#colorLiteral(red: 0.5281631351, green: 0.5734537244, blue: 0.6287283301, alpha: 1),
        
        MAIN_CONTENT_INFO_KEY.QUESTIONS :
            [
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "혈중 단백질 (g/dL)",
//                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("혈중 단백질 (g/dL)", comment: "")) ",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["≥ 6.7","< 6.7"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("첫번째 cycle에서 항암제 용량감량", comment: "")) ",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("최근 3달간 심한 스트레스를 받거나 병을 앓은 적이 있다", comment: "")) ",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("1일 수분 섭취량 (물, 주스, 커피, 차, 우유포함)", comment: "")) ",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("3컵 이상", comment: ""))","\(NSLocalizedString("2컵 이하", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("말씀 드리는 대로 해 보십시오.\n\"오른손으로 받는다\"\n\n(지시를 끝낸 후에 종이를 건내 준다.\n지시를 반복하거나 옆에서 도와주면 안 됨)", comment: "")) ",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("맞음", comment: ""))","\(NSLocalizedString("틀림", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("본인의 현재 상태를 스스로 평가하면?", comment: "")) ",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("보통이거나\n아주 건강하다", comment: ""))","\(NSLocalizedString("건강하지\n못하다", comment: ""))"]
                ],
            ]
        
    ],
    [
        MAIN_CONTENT_INFO_KEY.TITLE:"KCSG-Geriatric Score 7\n(KG-7)",
        MAIN_CONTENT_INFO_KEY.BACKGROUND_COLOR:#colorLiteral(red: 0.2367474437, green: 0.3182975948, blue: 0.4579529166, alpha: 1),
        
        MAIN_CONTENT_INFO_KEY.QUESTIONS :
            [
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("도움 없이 혼자서 목욕을 하실 수 있습니까?", comment: ""))",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("도움 없이 혼자서 계단을 오를 수 있습니까?", comment: ""))",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("필요한 물건은 모두 혼자서 구입할 수 있습니까?", comment: ""))",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("본인의 영양 상태를 스스로 평가하시면 어떻습니까?", comment: ""))",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("양호", comment: ""))","\(NSLocalizedString("불량", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("현재 매일 3가지 이상의 약물을 복용하고 있습니까?", comment: ""))",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("아니오", comment: ""))","\(NSLocalizedString("예", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("오늘이 몇 년도 몇 월 며칠 입니까?", comment: ""))",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("맞춤", comment: ""))","\(NSLocalizedString("못 맞춤", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "\(NSLocalizedString("활동이나 의욕이 많이 줄었습니까?", comment: ""))",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("아니오", comment: ""))","\(NSLocalizedString("예", comment: ""))"]                
                ]
                
        ]
    ],
    [
        MAIN_CONTENT_INFO_KEY.TITLE:"Geriatric Prognosis Index",
        MAIN_CONTENT_INFO_KEY.BACKGROUND_COLOR:#colorLiteral(red: 0.1972873807, green: 0.4069689512, blue: 0.785780251, alpha: 1),
        
        MAIN_CONTENT_INFO_KEY.QUESTIONS :
            [
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Age(years)",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["65-74","75-84","≥ 85"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Gender",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["Female","Male"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "ADL",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "Independent",
                        "Minimally dependent\n(1 domain impaired)",
                        "Dependent (≥2 domains impaired)"
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "IADL",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "Independent",
                        "Minimally dependent\n(1 domain impaired)",
                        "Dependent (≥2 domains impaired)"
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Comorbidity",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "CCI = 0 (or CIRS-G 0-3)",
                        "CCI ≥ 1 (or CIRS-G 0 ≥ 4)",
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Mood",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "GDS ≤ 13 (or GDS-SF ≤ 4)",
                        "GDS 14-21 (or GDS-SF 5-8)",
                        "GDS 22-30 (or GDS-SF 9-15)",
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Cognition",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "MMSE 25-30",
                        "MMSE 18-24",
                        " MMSE ≤ 17",
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Nutritional status",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "MNA 24-30 (or NSI 0-2)",
                        "MNA 17-23.5 (or NSI 3-5)",
                        "MNA ≤ 16.5 (or NSI ≥ 6)",
                    ]
                ],
                
                
        ]
    ],
]


let MAIN_CONTENT_INFOS_EN = [
    [
        MAIN_CONTENT_INFO_KEY.TITLE:"Prediction tool for occurrence of adverse envets≥G3 (servere)",
        MAIN_CONTENT_INFO_KEY.BACKGROUND_COLOR:#colorLiteral(red: 0.5281631351, green: 0.5734537244, blue: 0.6287283301, alpha: 1),
        
        MAIN_CONTENT_INFO_KEY.QUESTIONS :
            [
                [
//                    MAIN_CONTENT_INFO_KEY.QUESTION : "혈중 단백질 (g/dL)",
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Protein (g/dL)",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["≥ 6.7","< 6.7"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Initial dose reduction",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Has suffered psychological stress or acute disease in the past 3 months?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "How much fluid (water, juice, coffee, tea, milk…) is consumed per day?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("3컵 이상", comment: ""))","\(NSLocalizedString("2컵 이하", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Obey command: “take a piece of paper in your hand",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("맞음", comment: ""))","\(NSLocalizedString("틀림", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Health perception?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("보통이거나\n아주 건강하다", comment: ""))","\(NSLocalizedString("건강하지\n못하다", comment: ""))"]
                ],
            ]
        
    ],
    [
        MAIN_CONTENT_INFO_KEY.TITLE:"KCSG-Geriatric Score 7\n(KG-7)",
        MAIN_CONTENT_INFO_KEY.BACKGROUND_COLOR:#colorLiteral(red: 0.2367474437, green: 0.3182975948, blue: 0.4579529166, alpha: 1),
        
        MAIN_CONTENT_INFO_KEY.QUESTIONS :
            [
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Can you take a shower or bath without help?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Can you ascend the stairs without help?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Can you take care of all shopping needs independently?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("예", comment: ""))","\(NSLocalizedString("아니오", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "How is the self-view of your nutritional status?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("양호", comment: ""))","\(NSLocalizedString("불량", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Do you take more than 3 prescription drugs per day?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("아니오", comment: ""))","\(NSLocalizedString("예", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "What year, month and day is this?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("맞춤", comment: ""))","\(NSLocalizedString("못 맞춤", comment: ""))"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "What year, month and day is this?",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["\(NSLocalizedString("아니오", comment: ""))","\(NSLocalizedString("예", comment: ""))"]                ],
                
        ]
    ],
    [
        MAIN_CONTENT_INFO_KEY.TITLE:"Geriatric Prognosis Index",
        MAIN_CONTENT_INFO_KEY.BACKGROUND_COLOR:#colorLiteral(red: 0.1972873807, green: 0.4069689512, blue: 0.785780251, alpha: 1),
        
        MAIN_CONTENT_INFO_KEY.QUESTIONS :
            [
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Age(years)",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["65-74","75-84","≥ 85"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Gender",
                    MAIN_CONTENT_INFO_KEY.ANSWERS : ["Female","Male"]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "ADL",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "Independent",
                        "Minimally dependent\n(1 domain impaired)",
                        "Dependent (≥2 domains impaired)"
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "IADL",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "Independent",
                        "Minimally dependent\n(1 domain impaired)",
                        "Dependent (≥2 domains impaired)"
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Comorbidity",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "CCI = 0 (or CIRS-G 0-3)",
                        "CCI ≥ 1 (or CIRS-G 0 ≥ 4)",
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Mood",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "GDS ≤ 13 (or GDS-SF ≤ 4)",
                        "GDS 14-21 (or GDS-SF 5-8)",
                        "GDS 22-30 (or GDS-SF 9-15)",
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Cognition",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "MMSE 25-30",
                        "MMSE 18-24",
                        " MMSE ≤ 17",
                    ]
                ],
                [
                    MAIN_CONTENT_INFO_KEY.QUESTION : "Nutritional status",
                    MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B:MAIN_CONTENT_INFO_KEY.IS_ANSWER_TYPE_B,
                    MAIN_CONTENT_INFO_KEY.ANSWERS : [
                        "MNA 24-30 (or NSI 0-2)",
                        "MNA 17-23.5 (or NSI 3-5)",
                        "MNA ≤ 16.5 (or NSI ≥ 6)",
                    ]
                ],
                
                
        ]
    ],
]
