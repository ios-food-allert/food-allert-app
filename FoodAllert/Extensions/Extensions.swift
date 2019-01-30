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
