//
//  AllergenCollectionViewCell.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/27/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import Kingfisher
class AllergenCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var nameAllergen:UILabel!
    
    func setup(entity:Entity){
        self.nameAllergen.text = entity.entityEs
        let url = URL(string: entity.imageURL)
        self.image.kf.setImage(with: url)
        
    }
}
