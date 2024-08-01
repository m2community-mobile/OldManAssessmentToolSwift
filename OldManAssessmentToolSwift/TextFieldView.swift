

import UIKit

class TextFieldView: UIView {
    
    var textFieldFontSize : CGFloat {
        if IS_IPHONE_SE {
            return self.frame.size.height * 0.35
        }
        return self.frame.size.height * 0.4
    }
    
    var textField : UITextField!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        textField = UITextField(frame: self.bounds)
        textField.frame.size.width *= 0.9
        textField.center = self.frame.center
        textField.font = UIFont(name: NanumSquareR, size: textFieldFontSize)!
        textField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textField.addDoneCancelToolbar()
        self.addSubview(textField)
        
        let becomeButton = UIButton(frame: self.bounds)
        becomeButton.addTarget(event: .touchUpInside) { (button) in
            self.textField.becomeFirstResponder()
        }
        self.addSubview(becomeButton)
        
//        self.layer.cornerRadius = 5
//        self.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
//        self.layer.borderWidth = 0.5
        
    }
    
    func setPlaseHolder(plaseHolder : String) {
        textField.attributedPlaceholder = NSAttributedString(
            string: plaseHolder,
            attributes: [
                NSAttributedString.Key.font : UIFont(name: NanumSquareR, size: textFieldFontSize)!,
                NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
