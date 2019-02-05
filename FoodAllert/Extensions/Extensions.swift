//
//  Extensions.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/27/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import Foundation
import UIKit

extension Array where Element:Equatable{
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self{
            if result.contains(value) == false{
                result.append(value)
            }
        }
        return result
    }
    
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
    
    func containsElemets(array: [Element]) -> (Bool, [Element]) {
        var success = false
        var elemenstContains:[Element] = []
        for item in array {
            
            if !self.contains(item) {
                continue
            }else{
                success = true
                elemenstContains.append(item)
            }
        }
        return (success,elemenstContains)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


extension String {
    func withBoldText(boldPartsOfString: Array<String>, font: UIFont!, boldFont: UIFont!) -> NSAttributedString {
        let nonBoldFontAttribute = [NSAttributedString.Key.font:font!]
        let boldFontAttribute = [NSAttributedString.Key.font:boldFont!]
        let boldString = NSMutableAttributedString(string: self as String, attributes:nonBoldFontAttribute)
        for i in 0 ..< boldPartsOfString.count {
            boldString.addAttributes(boldFontAttribute, range: (self as NSString).range(of: boldPartsOfString[i] as String))
        }
        return boldString
    }
}

extension UIColor {

    static var greenDark: UIColor {
        return UIColor(named: "greenDark")!
    }
    static var greenLight: UIColor {
        return UIColor(named: "greenLight")!
    }
    static var greenMedium: UIColor {
        return UIColor(named: "greenMedium")!
    }
    static var greenRegular: UIColor {
        return UIColor(named: "greenRegular")!
    }

    static let colors:[UIColor] = [.greenDark,.greenLight,.greenMedium,.greenRegular]
    static let colorsStrongs:[UIColor] = [.greenDark,.greenMedium,.greenRegular]


    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}

extension Array {

    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

extension CGPoint {

    func distance(from point: CGPoint) -> CGFloat {
        return hypot(point.x - x, point.y - y)
    }

}
