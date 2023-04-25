//
//  UILabel+Extension.swift
//  Extentions
//
//  Created by Akshay Kumar on 25/04/23.
//

import Foundation
import UIKit

extension UILabel {
    func setHTMLFromString(text: String) {
        let modifiedFont = NSString(format:"<span style=\"font-family: \(self.font!.fontName); font-size: \(self.font!.pointSize)\">%@</span>" as NSString, text)
        
        let attrStr = try! NSAttributedString(
            data: modifiedFont.data(using: String.Encoding.unicode.rawValue, allowLossyConversion: true)!,
            options: [NSAttributedString.DocumentReadingOptionKey.documentType:NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        self.attributedText = attrStr
    }
    
}

extension String {
    func makeHTMLfriendly() -> String {
        var finalString = ""
        for char in self {
            for scalar in String(char).unicodeScalars {
                finalString.append("&#\(scalar.value)")
            }
        }
        return finalString
    }
    
    func htmlAttributed(using font: UIFont, color: UIColor) -> NSAttributedString? {
          do {
              let htmlCSSString = "<style>" +
                  "html *" +
                  "{" +
                  "font-size: \(font.pointSize)pt !important;" +
                "color: #\(color.cgColor) !important;" +
                  "font-family: \(font.familyName), Helvetica !important;" +
                  "}</style> \(self)"

              guard let data = htmlCSSString.data(using: String.Encoding.utf8) else {
                  return nil
              }

              return try NSAttributedString(data: data,
                                            options: [.documentType: NSAttributedString.DocumentType.html,
                                                      .characterEncoding: String.Encoding.utf8.rawValue],
                                            documentAttributes: nil)
          } catch {
              print("error: ", error)
              return nil
          }
      }
}
