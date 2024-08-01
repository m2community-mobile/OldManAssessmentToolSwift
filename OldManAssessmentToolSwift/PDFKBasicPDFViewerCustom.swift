//
//  PDFKBasicPDFViewerCustom.swift
//  OldManAssessmentToolSwift
//
//  Created by JinGu's iMac on 21/11/2019.
//  Copyright © 2019 JinGu's iMac. All rights reserved.
//

import UIKit

class PDFKBasicPDFViewerCustom: PDFKBasicPDFViewer {
    
    func reSettingShareFunction(){
        if self.shareItem != nil {
            self.shareItem.target = self
            self.shareItem.action = #selector(shareItemPressed)
        }
    }
    
    var documentInteractionCon : UIDocumentInteractionController!
    @objc func shareItemPressed(){
        if self.document.fileURL != nil {
            documentInteractionCon = UIDocumentInteractionController(url: self.document.fileURL)
            documentInteractionCon.presentOptionsMenu(from: CGRect(x: 0, y: 0, width: 100, height: 100), in: self.view, animated: true)
        }
        
    }


}
