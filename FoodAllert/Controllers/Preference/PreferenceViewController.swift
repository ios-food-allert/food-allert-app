//
//  PreferenceViewController.swift
//  FoodAllert
//
//  Created by Angel Ricardo Solsona Nevero on 1/30/19.
//  Copyright © 2019 José Gil Ramírez S. All rights reserved.
//

import UIKit
import Magnetic

class PreferenceViewController: UIViewController {

    @IBOutlet weak var magneticView:MagneticView! {
        didSet{
            magnetic.magneticDelegate = self
        }
    }
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    let allergens = ["eggs","fish","milk","nut","nutshell","peach","peanuts","shrimp-and-lobster","soy","strawberry","wheat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addAllergen()

        // Do any additional setup after loading the view.
    }
    
    func addAllergen(){
        for name in allergens{
            let image = UIImage(named: name)
            let color = UIColor.colors.randomItem()
            let node = Node(text: name, image: image, color: color, radius: 50)
            magnetic.addChild(node)
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension PreferenceViewController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        print("didSelect -> \(node)")
    }
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        print("didDeselect -> \(node)")
    }
    
}
